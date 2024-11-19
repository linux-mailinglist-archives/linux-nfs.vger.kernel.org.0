Return-Path: <linux-nfs+bounces-8105-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69829D1CE3
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 02:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BFE282470
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 01:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAB929422;
	Tue, 19 Nov 2024 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V59mTlbn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y7HMcZ/b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8139A93D;
	Tue, 19 Nov 2024 01:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978233; cv=fail; b=aHWI442eF1hMv7N13d5LEb7BLSfdOeYNi8cqbBcHOefhxj8ePHS7Lcrg3XKRVuZlbI7RwJqOetz9m5Vn0FbZF7MXOgscjn05iaD3fVwYqx7oQ6bzjcDY3ptq5FotY+FDNnq4UOK8Gmoha5AHa/Pdiisxa8IB46yRA+b1DHysuwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978233; c=relaxed/simple;
	bh=WpDuYoRIrMZWZnHYZ8uLku2D0teBMlRM4qK/rb1qoKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jP4A9epV8C2Yin0B4HNcraRDXpp8T/GChSyl/z3M0CBgQaGONqHcx9/jSEwh+/rhBWd7ti2OdYgfKTp8YDE0HEKRlFm3JRhm0hrmv8s5RJF61uzGgR55+uAfUlq38FPhB1fVyqfuwdmvJhpHc6HxV83WiHdLX7Lz48nFUxaAytQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V59mTlbn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y7HMcZ/b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AINMqa9012644;
	Tue, 19 Nov 2024 01:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=K3FaWucJWRP6AWPmJa
	Sb50bZpCVgpX70/B3/FXxeNsE=; b=V59mTlbn9H7XJZgiWvR6NPR0qIVuSvWlS3
	xbRoJs4EPJDNkQ9TrxT3TnAxshftulzFethA7Cdoqw+YLwjXT9Dvrp1BqzKb2yTA
	93uR2i4evwywwPCJnzvz2o+Iqs3RmT3gS9j6gYRw25hB73vbN0tfxdQbw3L+sNA5
	GwDfscsOlry8s292ry59NQukZK+1ohNHiGd3Sbx7SKXfFeatvBFB/Q7/ingwrTKw
	oWAdtbx10nWLS8jU71juR6zWKjRAicGPpfEd3Zdh2lQ19YJGCvc4wYWGNOTzNxdY
	FecmGzKXNkRtIyKd4mkBGXo25TPr6H2eQbkYkU7arUKiLWZWa2uA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyybyfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 01:03:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AINj6BI036497;
	Tue, 19 Nov 2024 01:03:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7vr78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 01:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJcj/QngtMHIS+7z8lUtmTVCMKikoz/1yAzOL09VPa0nDe39QKOr4oIXNOIr/W3q81pjcUdK9/mSv1YWncHo62XULaadc5JvmCpRtUmiazwGsA7qmCnutpiDHb4aecwV+7yR84yoG1xriHV86t/UqecMBWTkSZYR85GeCPAcwTHYlavHGiOTgsgKQ4jZ/IDF7JQWEGhqZ1YNeBrDIHEqqnoyfca3n8+jjlOSMHrYx7Ve614P65uKkDs3rCx27Gi6xva+/3uXG8ucqRqjuXLOVYIPFO1SIoFP6Y8WeFtqK2rF3pCOOs1DoadCbM/lSXYK+Q8mRVxh0c5S307efJ8dmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3FaWucJWRP6AWPmJaSb50bZpCVgpX70/B3/FXxeNsE=;
 b=UtqdP5pbklm+R0P90w6qwWQQLjVPfOX6Bml+vPhs/5ZzMz5FxdVIfWin8FPD1n7vfSWf85GCHG9GJIuYssR2iXGJJlychFrQxxDntv43ILI7sKhT/2MB3jDwAjNCRXdM4z+MS3PNHtyMDodyOC+FiBP++ON30yPljA1URp3uH4v70voaFyfSFVzjttiBkiV3Egjn7JXccgAt2j/nAZ0tRrdFcxtdYvP7aXTGg+MWFlXRfnCytGj393zBn6ix0NaU96ocf3NPnfjb5BAYtHPkkpJBxqlV7K3OeUTdUV2h/u7vHavy1eTZ5U9XZJuHn6Ix+XmrpoGxI/bkf+wQ15z9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3FaWucJWRP6AWPmJaSb50bZpCVgpX70/B3/FXxeNsE=;
 b=y7HMcZ/bA1fRZwHBUcD+Cq3gLKLgyF8APTYAD/+cOSQdBJPP0FLFrXsz7YhBSxnNrpeKDuRgGolIP7kidlDtY3jjn73nxBTjHD65cfbnwZMncQxhp8uwOh4za4S4OHuhvjgbIGFeTa3JeU2qdYdbbTrXoG2JAZ1fRV2OikG5Jug=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB5917.namprd10.prod.outlook.com (2603:10b6:8:b1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Tue, 19 Nov 2024 01:03:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 01:03:27 +0000
Date: Mon, 18 Nov 2024 20:03:24 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jonathan Corbet <corbet@lwn.net>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Thomas Haynes <loghyr@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/6] nfsd: add support for delegated timestamps
Message-ID: <Zzvj3BdZg2sxB+SF@tissot.1015granger.net>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
 <20241014-delstid-v1-5-7ce8a2f4dd24@kernel.org>
 <173197809388.1734440.12511559535515038071@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173197809388.1734440.12511559535515038071@noble.neil.brown.name>
X-ClientProxiedBy: CH5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1c93e1-8c58-4295-0bdf-08dd0835f9c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?frLweFLbwZ2q0AX9Zw6C50uo+r/aDGL2O1di7oWxu43j2Z2VOihs+IGDlOJT?=
 =?us-ascii?Q?DrZw01g00ygF8FrDJbXI2O51LjdTGSb8mNKXiNbiTAODshTXvjyUiLbg25TI?=
 =?us-ascii?Q?jwoCrsi6BupVvcpvptn8JvBybHt5oV8GIPL1TkoMSbK4jiLBo1bqKVsZPODU?=
 =?us-ascii?Q?V1J4HYhaKyBydNElDlT/5m9Q1Mm4ZZe5Kv6V4KGKhAAJEaRKb57auhMHG6M2?=
 =?us-ascii?Q?hjOtVDKQH2M5Xt8OnRVmMpknoVG0eIrm06aCfJHxPUq3lwaGcEcgVQj9nNfR?=
 =?us-ascii?Q?BMeARWkaBdQDUMG+l+C5HieufdfO/fw48XjKw7RHHwiTaB+vRJ3MyzphUaeA?=
 =?us-ascii?Q?iqKolJ/E9xwpJsCZCFDHVkVUU8G6rCCvRiaDYvoZ1soNHEhQtE5ZnYMhdLzi?=
 =?us-ascii?Q?n+JnxnmtLln6xNtftwEp/otQXAKlye8QqWhLVnONm6MaunuzO6Vm4CRINQoi?=
 =?us-ascii?Q?/+kRDGuuo0+ljjspgIuDddGp+YAdFx7LRYJ4z/zZ/DlOezL57XTb56SEP/0B?=
 =?us-ascii?Q?OjEu919BQijhQL1srJMeG2Vqi0iztjHDf4iMzIgQ1AEhC7vohFSjsNZSUNvT?=
 =?us-ascii?Q?2FiWjf/sF/72tPS1h390dg/wUhXKLb7DkGRud924JsSNDokofqGwbAeLSgMm?=
 =?us-ascii?Q?brBLwfVaFu2UPAUZV2UW824+PhBR08q+mJkUherqvYpwXXAG1XUX2arzkRLp?=
 =?us-ascii?Q?cPDWoCiccKXzoeaf54oW1nLniqmfM2cL3urffP8gsv/htvOwOjdSK1CSv64t?=
 =?us-ascii?Q?ieab3M4WKKieA1Xugb/A5EK+467f+WVML7wmdjCYkcEwheOBDcfytShiFNA0?=
 =?us-ascii?Q?iQQ1MAiGnL14QAe8+fPmGngjOo2RPJYzIv9ZRZ5TyrrNZBL/ql1BAqG4lLtG?=
 =?us-ascii?Q?pkWr9BpxJQ951lLb3xyEuwzv+9h/WjzaErHXMbgz4nwjs44LQUBUgOec7lpn?=
 =?us-ascii?Q?t+P+Drx2yRHGorfBKJ2WgFEkuSjL2+Tk22MPnQ6au7iweuZRSEWSJ7Q7iw3h?=
 =?us-ascii?Q?8nJXgZvwFYt7p2GHa8a3MaJ5pUxCGix18AKHwoyEIWcohpeODeH8QFwidD7/?=
 =?us-ascii?Q?IZnvSxhkZdLTcA9YauzeUEVrK4oI/a8NpOBkdn0yoo4fCLNfTS6MU8OYgj8/?=
 =?us-ascii?Q?kNld3Cj56xty8lJq2LVS2yCgBKqxLGL62iLIZayzUKUeWzv+F2bOlbS1kJAi?=
 =?us-ascii?Q?l1h0xmk9RAoYcYeQ/yV62MWKY8Oo1HUzgPPG84jFtlUoRLjSgz2S0NEYI50O?=
 =?us-ascii?Q?VVv+w7BIagOMsq80xp/ZTpVHsEkQ+N5qk25zhR8Fp2q7ZtdxJSDzHyQHMvJk?=
 =?us-ascii?Q?t4s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qi+RCTkvFD9ThXDrVXezdkh2tho+3xQpejHegIgUXTDEkcG3F6a1ae0R3rsl?=
 =?us-ascii?Q?bqfQYcO7giy6BTj+Azl2a2rhm67fvwo9p6BUniQPta6s/CIm70JBcrpu6Rw7?=
 =?us-ascii?Q?YTUNpb7UZhoY1MqswkGP6d7NC5gtDWML66PGslZ3i1Z1Rmk/mdKpKI2QWvI+?=
 =?us-ascii?Q?hDA1xV4vjKUmts23/zhvKP2imNUcls6MOWq+ivpsTod1PWjPAIrNu6SE3UTj?=
 =?us-ascii?Q?5/MEtIrIPb3lhwYdTSS5d8mXPdQUaDVWZWxAI6rTQ7PVf7VTeBtwFjovSfrx?=
 =?us-ascii?Q?+QTBDz5C55OLDxH/Gqptl5r5yyXY1SfmB6EaPkrRAhjf86DuMzy9mduCniML?=
 =?us-ascii?Q?nfaNLeD64pCKJZyo69xL3kK5g9X8wEDCnavzS/mv9QDqbrI5Nr38Zb5YwZaT?=
 =?us-ascii?Q?K3SUmP8myC36CIpnalwCfqxy0L6v+Q07t4TQFcTYQxCRXEVZ5Kre6xCi7KC9?=
 =?us-ascii?Q?HNn0F+RKjIEArVweKI4ptQavdL8OVHzpMJIaGgbp7gE1TQQ8gNC83Zm/B7ig?=
 =?us-ascii?Q?hemYQZhsLmKliOmThxJLej8U9iwcQye5k2d11Hc77ZCzd0c3R7KFS+E8akvn?=
 =?us-ascii?Q?v1LVJB04TFLc7GV8sco4knaOA9rKVRiotUI9v37nJiwOQMwNBfRx29QlztLg?=
 =?us-ascii?Q?x3eTyIt1/R6pD+c0tKzuUGfFR+w9izMb7LUW4WhbeZngfWrYt+styGAS6YRO?=
 =?us-ascii?Q?7u64pbXWoMJQRdbxxPZttyfkkThA9JqpwFPYRkWtC+b2knSY230DHQ93i7pz?=
 =?us-ascii?Q?mX+eAWPG9ORdjAWEtIQdbRoLcF6cDt1nbrRGNwE17HkvGTqjD6HUvRyoU4HF?=
 =?us-ascii?Q?U6NfPDr6PIYzE4Iic/JtMQfHCAvWnOZsip7nSRg8B/7B/Z+KBEPfza9SOPd2?=
 =?us-ascii?Q?GHJUFSg4UH+ZzmGn0Eb7eECMxsl3RQsgqgL5QAZ5WLDboPrhITtOc1HYN21x?=
 =?us-ascii?Q?89m105ctpqH+L+yAnxnXx9Cwl5cjo8J8jd7I3t8gSK5I/yPjS5O7sp5ddlAQ?=
 =?us-ascii?Q?ml7JDJcBYvJNrV1fvhJzDDCYeYzE+XFKFtHZNDZXIhLlaabrCxZ/OUmUlvAs?=
 =?us-ascii?Q?bv/plpXEQbcBpahNUm3ybWxQv5jtww+e9wPTL9Ysu3xG64gkHIJfgMGbz0BX?=
 =?us-ascii?Q?mI3sTm9E3ew5FFmIvDklfuVGUfXDCs+5PhFxO42KMp5sinG/vNICHAV3arcp?=
 =?us-ascii?Q?iqjSha8tau0XbF79dZtgXXmKk52aE3NJTt7KPxRaq96I8oF40kaOJyTEQV4A?=
 =?us-ascii?Q?9t6QT6UjrujBkDLg0+L7MwtYI/IiQG39zA4SZ+h1ABd2njAZ0m5jdebZfPeY?=
 =?us-ascii?Q?u4qK7WIqgy+zL4QamJdE+Abs08uH4RzCieinvEQ7nHO0eUH9kLqec6Hi+VlM?=
 =?us-ascii?Q?lAZjS2xBcd1YrdvYFj/OEsUmjvvJOXTzeTF6UUqk4F2VdRsonIaShOYcshFQ?=
 =?us-ascii?Q?NvxL8bukSyXl58CDuoDRLuWt8DxFBE8ZPKjDN9vZ0zssw62jJLV/cS1lHemY?=
 =?us-ascii?Q?DO8kkxyCV8Q3I7Z9++MoGWEzGsOpVD9pFo8ItYZZ+IEioKc5AUdPR6KKuL7c?=
 =?us-ascii?Q?gDbSKgryD2F3Qv4Q35IojUAzEdP6xTBXbEBJGQCg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ioI8J32lXiAeUdxBr/WHPCWnl0XmzLjhJfPBbVrLXQGEE/pxItZuCtWFKiiJOTCyw1GVjXmXrJVsUmPzlDpgGCTpK1DHuervDh8ZR9EbDLWPCo9k4uO+pUJUaGpiC3dnmuSYtPdZt0RXUVQCr1hPQs4Hq1pFJ/uCSSjFoaUp2RfJpbc2Rr2SpaF/mgbXf9KtZgSj8rFm9m/nWLoP7SjjxOImhP+PR/NmAHtVKGl+vSOVzi5TRlPEtDP4d80xdGRfJRZxkIcD+AGObVIX5ARMpV5VQ2ra/oOIrw8CYQS/r9YqLhETSxU/msfTVFSI8O9jaI3BbRIUIse/l2OGwS2XIgG+Lmj6OnzggA3ipthkCQaZ8ZNgKWEyCya1KMcbZG4i1rtrv6bXu2jTolL8egrds2OcsSz+yt2X1SYfKjOi7NqvstPQ++X1yxeonND2C/tGgHELI/g0Fo8P3rDn8W0IFVF3s11Nu6yPDpqGihoW2R0gKotNmdm9mC62g7dOLCXzcBsKhUg/O1539zmkktxbwX7T8bdUMQzPX8tzXcW3csum2P4FUDGYdqWzWGehYiypbIlkqyhaGDurJQ+dH91S0LfUeGcLxBjR+qHg+bS/ohQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1c93e1-8c58-4295-0bdf-08dd0835f9c7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 01:03:27.4803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clUzqcSMglXvz/fk+6u6AF2Jjhtq5+EjBF4bE/H6IH7V1JaQYkTX5xFGERs/E6ZW3xE4Nvo/c6X/1w6UmnFCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190008
X-Proofpoint-ORIG-GUID: CPKtfgfl5TuyVdPPBd1j2BGNp1ONyr3f
X-Proofpoint-GUID: CPKtfgfl5TuyVdPPBd1j2BGNp1ONyr3f

On Tue, Nov 19, 2024 at 12:01:33PM +1100, NeilBrown wrote:
> On Tue, 15 Oct 2024, Jeff Layton wrote:
> > Add support for the delegated timestamps on write delegations. This
> > allows the server to proxy timestamps from the delegation holder to
> > other clients that are doing GETATTRs vs. the same inode.
> > 
> > When OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS bit is set in the OPEN
> > call, set the dl_type to the *_ATTRS_DELEG flavor of delegation.
> > 
> > Add timespec64 fields to nfs4_cb_fattr and decode the timestamps into
> > those. Vet those timestamps according to the delstid spec and update
> > the inode attrs if necessary.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4callback.c | 42 +++++++++++++++++++--
> >  fs/nfsd/nfs4state.c    | 99 +++++++++++++++++++++++++++++++++++++++++++-------
> >  fs/nfsd/nfs4xdr.c      | 13 ++++++-
> >  fs/nfsd/nfsd.h         |  2 +
> >  fs/nfsd/state.h        |  2 +
> >  fs/nfsd/xdr4cb.h       | 10 +++--
> >  include/linux/time64.h |  5 +++
> >  7 files changed, 151 insertions(+), 22 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index 776838bb83e6b707a4df76326cdc68f32daf1755..08245596289a960eb8b2e78df276544e7d3f4ff8 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -42,6 +42,7 @@
> >  #include "trace.h"
> >  #include "xdr4cb.h"
> >  #include "xdr4.h"
> > +#include "nfs4xdr_gen.h"
> >  
> >  #define NFSDDBG_FACILITY                NFSDDBG_PROC
> >  
> > @@ -93,12 +94,35 @@ static int decode_cb_fattr4(struct xdr_stream *xdr, uint32_t *bitmap,
> >  {
> >  	fattr->ncf_cb_change = 0;
> >  	fattr->ncf_cb_fsize = 0;
> > +	fattr->ncf_cb_atime.tv_sec = 0;
> > +	fattr->ncf_cb_atime.tv_nsec = 0;
> > +	fattr->ncf_cb_mtime.tv_sec = 0;
> > +	fattr->ncf_cb_mtime.tv_nsec = 0;
> > +
> >  	if (bitmap[0] & FATTR4_WORD0_CHANGE)
> >  		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_change) < 0)
> >  			return -NFSERR_BAD_XDR;
> >  	if (bitmap[0] & FATTR4_WORD0_SIZE)
> >  		if (xdr_stream_decode_u64(xdr, &fattr->ncf_cb_fsize) < 0)
> >  			return -NFSERR_BAD_XDR;
> > +	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
> > +		fattr4_time_deleg_access access;
> > +
> > +		if (!xdrgen_decode_fattr4_time_deleg_access(xdr, &access))
> > +			return -NFSERR_BAD_XDR;
> > +		fattr->ncf_cb_atime.tv_sec = access.seconds;
> > +		fattr->ncf_cb_atime.tv_nsec = access.nseconds;
> > +
> > +	}
> > +	if (bitmap[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
> > +		fattr4_time_deleg_modify modify;
> > +
> > +		if (!xdrgen_decode_fattr4_time_deleg_modify(xdr, &modify))
> > +			return -NFSERR_BAD_XDR;
> > +		fattr->ncf_cb_mtime.tv_sec = modify.seconds;
> > +		fattr->ncf_cb_mtime.tv_nsec = modify.nseconds;
> > +
> > +	}
> >  	return 0;
> >  }
> >  
> > @@ -364,15 +388,21 @@ encode_cb_getattr4args(struct xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
> >  	struct nfs4_delegation *dp = container_of(fattr, struct nfs4_delegation, dl_cb_fattr);
> >  	struct knfsd_fh *fh = &dp->dl_stid.sc_file->fi_fhandle;
> >  	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
> > -	u32 bmap[1];
> > +	u32 bmap_size = 1;
> > +	u32 bmap[3];
> >  
> >  	bmap[0] = FATTR4_WORD0_SIZE;
> >  	if (!ncf->ncf_file_modified)
> >  		bmap[0] |= FATTR4_WORD0_CHANGE;
> >  
> > +	if (deleg_attrs_deleg(dp->dl_type)) {
> > +		bmap[1] = 0;
> > +		bmap[2] = FATTR4_WORD2_TIME_DELEG_ACCESS | FATTR4_WORD2_TIME_DELEG_MODIFY;
> > +		bmap_size = 3;
> > +	}
> >  	encode_nfs_cb_opnum4(xdr, OP_CB_GETATTR);
> >  	encode_nfs_fh4(xdr, fh);
> > -	encode_bitmap4(xdr, bmap, ARRAY_SIZE(bmap));
> > +	encode_bitmap4(xdr, bmap, bmap_size);
> >  	hdr->nops++;
> >  }
> >  
> > @@ -597,7 +627,7 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
> >  	struct nfs4_cb_compound_hdr hdr;
> >  	int status;
> >  	u32 bitmap[3] = {0};
> > -	u32 attrlen;
> > +	u32 attrlen, maxlen;
> >  	struct nfs4_cb_fattr *ncf =
> >  		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
> >  
> > @@ -616,7 +646,11 @@ static int nfs4_xdr_dec_cb_getattr(struct rpc_rqst *rqstp,
> >  		return -NFSERR_BAD_XDR;
> >  	if (xdr_stream_decode_u32(xdr, &attrlen) < 0)
> >  		return -NFSERR_BAD_XDR;
> > -	if (attrlen > (sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize)))
> > +	maxlen = sizeof(ncf->ncf_cb_change) + sizeof(ncf->ncf_cb_fsize);
> > +	if (bitmap[2] != 0)
> > +		maxlen += (sizeof(ncf->ncf_cb_mtime.tv_sec) +
> > +			   sizeof(ncf->ncf_cb_mtime.tv_nsec)) * 2;
> > +	if (attrlen > maxlen)
> >  		return -NFSERR_BAD_XDR;
> >  	status = decode_cb_fattr4(xdr, bitmap, ncf);
> >  	return status;
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 62f9aeb159d0f2ab4d293bf5c0c56ad7b86eb9d6..2c8d2bb5261ad189c6dfb1c4050c23d8cf061325 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5803,13 +5803,14 @@ static struct nfs4_delegation *
> >  nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  		    struct svc_fh *parent)
> >  {
> > -	int status = 0;
> > +	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
> >  	struct nfs4_client *clp = stp->st_stid.sc_client;
> >  	struct nfs4_file *fp = stp->st_stid.sc_file;
> >  	struct nfs4_clnt_odstate *odstate = stp->st_clnt_odstate;
> >  	struct nfs4_delegation *dp;
> >  	struct nfsd_file *nf = NULL;
> >  	struct file_lease *fl;
> > +	int status = 0;
> >  	u32 dl_type;
> >  
> >  	/*
> > @@ -5834,7 +5835,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  	 */
> >  	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
> >  		nf = find_rw_file(fp);
> > -		dl_type = OPEN_DELEGATE_WRITE;
> > +		dl_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELEGATE_WRITE;
> >  	}
> >  
> >  	/*
> > @@ -5843,7 +5844,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  	 */
> >  	if (!nf && (open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
> >  		nf = find_readable_file(fp);
> > -		dl_type = OPEN_DELEGATE_READ;
> > +		dl_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG : OPEN_DELEGATE_READ;
> >  	}
> >  
> >  	if (!nf)
> > @@ -6001,13 +6002,14 @@ static void
> >  nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  		     struct svc_fh *currentfh)
> >  {
> > -	struct nfs4_delegation *dp;
> > +	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
> >  	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
> >  	struct nfs4_client *clp = stp->st_stid.sc_client;
> >  	struct svc_fh *parent = NULL;
> > -	int cb_up;
> > -	int status = 0;
> > +	struct nfs4_delegation *dp;
> >  	struct kstat stat;
> > +	int status = 0;
> > +	int cb_up;
> >  
> >  	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
> >  	open->op_recall = false;
> > @@ -6048,12 +6050,14 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> >  			destroy_delegation(dp);
> >  			goto out_no_deleg;
> >  		}
> > -		open->op_delegate_type = OPEN_DELEGATE_WRITE;
> > +		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG :
> > +						    OPEN_DELEGATE_WRITE;
> >  		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
> >  		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat);
> >  		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> >  	} else {
> > -		open->op_delegate_type = OPEN_DELEGATE_READ;
> > +		open->op_delegate_type = deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DELEG :
> > +						    OPEN_DELEGATE_READ;
> >  		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> >  	}
> >  	nfs4_put_stid(&dp->dl_stid);
> > @@ -8887,6 +8891,78 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
> >  	get_stateid(cstate, &u->write.wr_stateid);
> >  }
> >  
> > +/**
> > + * set_cb_time - vet and set the timespec for a cb_getattr update
> > + * @cb: timestamp from the CB_GETATTR response
> > + * @orig: original timestamp in the inode
> > + * @now: current time
> > + *
> > + * Given a timestamp in a CB_GETATTR response, check it against the
> > + * current timestamp in the inode and the current time. Returns true
> > + * if the inode's timestamp needs to be updated, and false otherwise.
> > + * @cb may also be changed if the timestamp needs to be clamped.
> > + */
> > +static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *orig,
> > +			const struct timespec64 *now)
> > +{
> > +
> > +	/*
> > +	 * "When the time presented is before the original time, then the
> > +	 *  update is ignored." Also no need to update if there is no change.
> > +	 */
> > +	if (timespec64_compare(cb, orig) <= 0)
> > +		return false;
> > +
> > +	/*
> > +	 * "When the time presented is in the future, the server can either
> > +	 *  clamp the new time to the current time, or it may
> > +	 *  return NFS4ERR_DELAY to the client, allowing it to retry."
> > +	 */
> > +	if (timespec64_compare(cb, now) > 0) {
> > +		/* clamp it */
> > +		*cb = *now;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation *dp)
> > +{
> > +	struct inode *inode = d_inode(dentry);
> > +	struct timespec64 now = current_time(inode);
> > +	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
> > +	struct iattr attrs = { };
> > +	int ret;
> > +
> > +	if (deleg_attrs_deleg(dp->dl_type)) {
> > +		struct timespec64 atime = inode_get_atime(inode);
> > +		struct timespec64 mtime = inode_get_mtime(inode);
> > +
> > +		attrs.ia_atime = ncf->ncf_cb_atime;
> > +		attrs.ia_mtime = ncf->ncf_cb_mtime;
> > +
> > +		if (set_cb_time(&attrs.ia_atime, &atime, &now))
> > +			attrs.ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
> > +
> > +		if (set_cb_time(&attrs.ia_mtime, &mtime, &now)) {
> > +			attrs.ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET;
> > +			attrs.ia_ctime = attrs.ia_mtime;
> > +		}
> > +	} else {
> > +		attrs.ia_valid |= ATTR_MTIME | ATTR_CTIME;
> > +		attrs.ia_mtime = attrs.ia_ctime = now;
> > +	}
> > +
> > +	if (!attrs.ia_valid)
> > +		return 0;
> > +
> > +	attrs.ia_valid |= ATTR_DELEG;
> > +	inode_lock(inode);
> > +	ret = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> > +	inode_unlock(inode);
> > +	return ret;
> > +}
> > +
> >  /**
> >   * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
> >   * @rqstp: RPC transaction context
> > @@ -8913,7 +8989,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
> >  	struct file_lock_context *ctx;
> >  	struct nfs4_delegation *dp = NULL;
> >  	struct file_lease *fl;
> > -	struct iattr attrs;
> >  	struct nfs4_cb_fattr *ncf;
> >  	struct inode *inode = d_inode(dentry);
> >  
> > @@ -8975,11 +9050,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
> >  		 * not update the file's metadata with the client's
> >  		 * modified size
> >  		 */
> > -		attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
> > -		attrs.ia_valid = ATTR_MTIME | ATTR_CTIME | ATTR_DELEG;
> > -		inode_lock(inode);
> > -		err = notify_change(&nop_mnt_idmap, dentry, &attrs, NULL);
> > -		inode_unlock(inode);
> > +		err = cb_getattr_update_times(dentry, dp);
> >  		if (err) {
> >  			status = nfserrno(err);
> >  			goto out_status;
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 1c9d9349e4447c0078c7de0d533cf6278941679d..0e9f59f6be015bfa37893973f38fec880ff4c0b1 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -3409,6 +3409,7 @@ static __be32 nfsd4_encode_fattr4_xattr_support(struct xdr_stream *xdr,
> >  #define NFSD_OA_SHARE_ACCESS_WANT	(BIT(OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG)		| \
> >  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG)		| \
> >  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL)		| \
> > +					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS)	| \
> >  					 BIT(OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION))
> >  
> >  #define NFSD_OA_OPEN_CLAIM	(BIT(OPEN_ARGS_OPEN_CLAIM_NULL)		| \
> > @@ -3602,7 +3603,11 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
> >  		if (status)
> >  			goto out;
> >  	}
> > -	if (attrmask[0] & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> > +	if ((attrmask[0] & (FATTR4_WORD0_CHANGE |
> > +			    FATTR4_WORD0_SIZE)) ||
> > +	    (attrmask[1] & (FATTR4_WORD1_TIME_ACCESS |
> > +			    FATTR4_WORD1_TIME_MODIFY |
> > +			    FATTR4_WORD1_TIME_METADATA))) {
> >  		status = nfsd4_deleg_getattr_conflict(rqstp, dentry, &dp);
> >  		if (status)
> >  			goto out;
> > @@ -3617,8 +3622,14 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
> >  		if (ncf->ncf_file_modified) {
> >  			++ncf->ncf_initial_cinfo;
> >  			args.stat.size = ncf->ncf_cur_fsize;
> > +			if (!timespec64_is_epoch(&ncf->ncf_cb_mtime))
> > +				args.stat.mtime = ncf->ncf_cb_mtime;
> >  		}
> >  		args.change_attr = ncf->ncf_initial_cinfo;
> > +
> > +		if (!timespec64_is_epoch(&ncf->ncf_cb_atime))
> > +			args.stat.atime = ncf->ncf_cb_atime;
> > +
> >  		nfs4_put_stid(&dp->dl_stid);
> >  	} else {
> >  		args.change_attr = nfsd4_change_attribute(&args.stat);
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 1955c8e9c4c793728fa75dd136cadc735245483f..004415651295891b3440f52a4c986e3a668a48cb 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -459,6 +459,8 @@ enum {
> >  	FATTR4_WORD2_MODE_UMASK | \
> >  	NFSD4_2_SECURITY_ATTRS | \
> >  	FATTR4_WORD2_XATTR_SUPPORT | \
> > +	FATTR4_WORD2_TIME_DELEG_ACCESS | \
> > +	FATTR4_WORD2_TIME_DELEG_MODIFY | \
> 
> This breaks 4.2 mounts for me (in latest nfsd-nexT).  OPEN fails.

Yep, we're on it.


> By setting these bits we tell the client that we support timestamp
> delegation, but you haven't updated nfsd4_decode_share_access() to
> understand NFS4_SHARE_WANT_DELEG_TIMESTAMPS in the 'share' flags for an
> OPEN request.  So the server responds with BADXDR to OPEN requests now.
> 
> Mounting with v4.1 still works.
> 
> NeilBrown
> 
> 
> >  	FATTR4_WORD2_OPEN_ARGUMENTS)
> >  
> >  extern const u32 nfsd_suppattrs[3][3];
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 9d0e844515aa6ea0ec62f2b538ecc2c6a5e34652..6351e6eca7cc63ccf82a3a081cef39042d52f4e9 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -142,6 +142,8 @@ struct nfs4_cb_fattr {
> >  	/* from CB_GETATTR reply */
> >  	u64 ncf_cb_change;
> >  	u64 ncf_cb_fsize;
> > +	struct timespec64 ncf_cb_mtime;
> > +	struct timespec64 ncf_cb_atime;
> >  
> >  	unsigned long ncf_cb_flags;
> >  	bool ncf_file_modified;
> > diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
> > index e8b00309c449fe2667f7d48cda88ec0cff924f93..f1a315cd31b74f73f1d52702ae7b5c93d51ddf82 100644
> > --- a/fs/nfsd/xdr4cb.h
> > +++ b/fs/nfsd/xdr4cb.h
> > @@ -59,16 +59,20 @@
> >   * 1: CB_GETATTR opcode (32-bit)
> >   * N: file_handle
> >   * 1: number of entry in attribute array (32-bit)
> > - * 1: entry 0 in attribute array (32-bit)
> > + * 3: entry 0-2 in attribute array (32-bit * 3)
> >   */
> >  #define NFS4_enc_cb_getattr_sz		(cb_compound_enc_hdr_sz +       \
> >  					cb_sequence_enc_sz +            \
> > -					1 + enc_nfs4_fh_sz + 1 + 1)
> > +					1 + enc_nfs4_fh_sz + 1 + 3)
> >  /*
> >   * 4: fattr_bitmap_maxsz
> >   * 1: attribute array len
> >   * 2: change attr (64-bit)
> >   * 2: size (64-bit)
> > + * 2: atime.seconds (64-bit)
> > + * 1: atime.nanoseconds (32-bit)
> > + * 2: mtime.seconds (64-bit)
> > + * 1: mtime.nanoseconds (32-bit)
> >   */
> >  #define NFS4_dec_cb_getattr_sz		(cb_compound_dec_hdr_sz  +      \
> > -			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + op_dec_sz)
> > +			cb_sequence_dec_sz + 4 + 1 + 2 + 2 + 2 + 1 + 2 + 1 + op_dec_sz)
> > diff --git a/include/linux/time64.h b/include/linux/time64.h
> > index f1bcea8c124a361b6c1e3c98ef915840c22a8413..9934331c7b86b7fb981c7aec0494ac2f5e72977e 100644
> > --- a/include/linux/time64.h
> > +++ b/include/linux/time64.h
> > @@ -49,6 +49,11 @@ static inline int timespec64_equal(const struct timespec64 *a,
> >  	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
> >  }
> >  
> > +static inline bool timespec64_is_epoch(const struct timespec64 *ts)
> > +{
> > +	return ts->tv_sec == 0 && ts->tv_nsec == 0;
> > +}
> > +
> >  /*
> >   * lhs < rhs:  return <0
> >   * lhs == rhs: return 0
> > 
> > -- 
> > 2.47.0
> > 
> > 
> > 
> 

-- 
Chuck Lever

