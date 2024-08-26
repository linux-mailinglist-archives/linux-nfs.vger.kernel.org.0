Return-Path: <linux-nfs+bounces-5773-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB7895F52D
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 17:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAD3281022
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F421917DF;
	Mon, 26 Aug 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UKUeWPr+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HgBLHLB2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B58186298;
	Mon, 26 Aug 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686371; cv=fail; b=q0ry/MEIUiYPf5JVrZCpRFS3AHLS+HxC9ZZuRQl978XRzlui5ZJw0DL9BNEFVLq+alXuYY3wlhvH+DJUX23q3EaOgCBPAt8y2A7g2Cbyf2ZrJYLdokY+U/OlPLYl+yqFuo8jSlBzZFwI4dECo3Vue2Kei55E/EwdcR9l5TbaoXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686371; c=relaxed/simple;
	bh=8Zti+FODObDZogn1y0FBVBIEBy8QuwHJW8zHJ5d7om0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kEMSHPT640x538ZN2IyERIEBViw6yqEKHjeLKFkCN/MBQIvaPaaIFF2uTwwFUjcIpOjMLLs76QcX3h9If9KY0AkAC88+I8PjUYNeF/GlFYGLhRrKcqSXNe4uLM7wQ0LqKMQwxY5CQxZzNSlkUpOz0fl/dPTaDdqUGGzoJH8/w10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UKUeWPr+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HgBLHLB2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QEfbYj001897;
	Mon, 26 Aug 2024 15:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Q9gsQ1Q1Szud4Yy
	0ExsNZcxo6Nsiwte3btP0Duyw4nU=; b=UKUeWPr+5mNhCuhHQzQeOGRG+AbYmFB
	SrqUs3rSDGa0nE6yYEO5mgqaBDgmvE/6WZlDprxNm3BI8XdzLy6/NZZUS/htpxhr
	x0gSvYL9FduoDTA9lgX/Bg6MA29lMpoSm9YAA5MmRY96vKDPFWRrmUFAACBxDxLz
	jLLroTrGa0795rKKD1v6hO44j5vsjAVINYoe34j2Fq5oVxH2uuGIvVm84ZJ/qx06
	eNwQLFr0Lw1dgNnN95pqVLiXbXcy+SynWk/BwcGMnNid+fpcQR/MbxdJDq4sKIAq
	gn+FDsx7M2AAjeK+lzCRqrtEmefq0u4q3VsIVZfc/9qg8Wr0QEzRHng==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177ksuc22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 15:32:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QEdFe5010667;
	Mon, 26 Aug 2024 15:32:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894kpm01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 15:32:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBgJLcNq87FTXmYdfn2lo1ErpBksFMRVmk7Gv9aysJl1XPsjQWhBeQimWo3QsachQHrhbZCK0BEn+Y8nn0QmcnNVCKkrwgM7mUGtbvpL4ArkvkNWJYm5rEKuZ9IxosKxUcf6FhcxKIuuhxiYQ5nsThwRMX21dX0ykt4hkv1EBdLlv4jnQURH/uZ7n9C6pKAC3fizul73TmTzw3JS3tUK7qumtgDG5gokhirCe5ErrKkfbhQygiQ6zBRBUASNobk4zT9M1vtIuUBFTG8PWXY5asY/QAWg/SPaWDN9vOFU6lCUWb3X1tUB4snsRv7hGeMBT5OAYEtnUwxcSbrXNqriJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9gsQ1Q1Szud4Yy0ExsNZcxo6Nsiwte3btP0Duyw4nU=;
 b=vhbBv5x9Hio1jafRHy/CaPo/imDC+4u2QJY+pIvtKrp+jPFnrCtWwHRAbAj77AdBaiNBEIwk41hiR7Uty3VqspeBFk+qlzMZA7k6C4fcWQgQ0F6E3iZYdfWqn8zUQY4WANoCyeNNrrOTQdlSrnlkJxW/y7CZGKp6MiEVnjdFFeksrMx1w3B6FKS+GtdS3nfJ94wu/AGR9k37tuJkCcauaerH40277L7h92G8WaiDk1gHD+LKa7mLEiUcK8e0JyNEikNcvrtAVMAQ29GOa1/mttkIbLQpj+p6F3ZzzssekhnnL/0G/F44pRk1CC2MuVrWzWJxsyMdttdzhNn2zeT3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9gsQ1Q1Szud4Yy0ExsNZcxo6Nsiwte3btP0Duyw4nU=;
 b=HgBLHLB2Y3s0dB5rgMZgvNGO9TMw50o8ANPqv703ds7baXj+J+ziStr0U/kFLjJjtNJpFnkExLjoHUSYBT1d5m4KLKFoHhADzUyl62Klf75PWa+GVBDknFQCpmU4xTfzJcW+bX1kLNZ2zIilnYLtZCmvLmh3WU35R+pmsMtlusU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA6PR10MB8158.namprd10.prod.outlook.com (2603:10b6:806:442::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 15:32:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 15:32:35 +0000
Date: Mon, 26 Aug 2024 11:32:31 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] nfsd: CB_GETATTR fixes
Message-ID: <ZsygD2pZXZtdN1ZJ@tissot.1015granger.net>
References: <20240823-nfsd-fixes-v1-0-fc99aa16f6a0@kernel.org>
 <Zsoe/D24xvLfKClT@tissot.1015granger.net>
 <172462816214.6062.16988455872478253419@noble.neil.brown.name>
 <227e2d809951caa485e8ea03978afea515e89464.camel@kernel.org>
 <bd1beb5d5d6862827336aa25a09c2ae16597cc47.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1beb5d5d6862827336aa25a09c2ae16597cc47.camel@kernel.org>
X-ClientProxiedBy: CH0PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:610:32::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA6PR10MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 543e1522-a9c6-4773-8124-08dcc5e44f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xG2jQdck5Z2MjlKgpy7LDwXILnyZa/eFZhczphS7ERA6uLtsi735tm7+BcVf?=
 =?us-ascii?Q?J4lAVw0eIHe/5jxsf3zUfZp3yjyAlbN+5UO04czcXgndCEKFASiekafxxp8j?=
 =?us-ascii?Q?oj7EXKOXpYb/CgmE8RkFRlIXZE8OHPpQPmrQF1r/QVIhqJkc8kkIozF/bQmm?=
 =?us-ascii?Q?0D8Qef91G0zcgokTWfdMUD5ibEKXhge4cDG79zkKfc14804YOkv0dkd5dJ29?=
 =?us-ascii?Q?acS+oR5Murd/nR5sFFtLFuj+b4vpafXFyUTuqPF8GYkhLJ4mmPcaLQJKuEY2?=
 =?us-ascii?Q?2ZWjF5WwbqoItE+rBeck+ytdmWyAxDPl1yeJXKIcB39B8wC4bFadMdatzhMC?=
 =?us-ascii?Q?bkQpeciFCv3sbsK15EogwkBz3PS/ly1JODnZWeezJUBMbaO0hCs3IhzzYe21?=
 =?us-ascii?Q?dF6bd6TS3OpfxtvkzD0iNPkuYr+xSVkMSl5KVL6wi6JOOi9Ydi4Wxa8tadVt?=
 =?us-ascii?Q?6b7di4qw+Ql6vgYyt4tI6u5pizqVhjqhnlFoRQ+/CtGrNiMUiJ5sjCgTD/Dr?=
 =?us-ascii?Q?AArBaefCT1GMSoMigHKXws+MZB8zzulGzhKUtbwPJGN7MSrsmKeihKsDcwQ2?=
 =?us-ascii?Q?6Wa9kN6XJ3AA9p99FZO/Iph0CR/zu6Ok0iGdJqLMxkmPo27ahfuQMMoActXv?=
 =?us-ascii?Q?luJ11CrXg21urFYLPI1SMs1fjFDzgRaY5FWvcxi6FftmVwVk9J1IH2EC/rBV?=
 =?us-ascii?Q?P2PrwyMSyHGZT+fRLyOex97MOiiKGK8/a5OTcS5fPFSkapJzuVUt6T86atO2?=
 =?us-ascii?Q?1jheH1XGuUqyIlsuqHGvRh5ufN5LdC5wwPynNEtcerF6JboaXROcvEdxFV86?=
 =?us-ascii?Q?bhk5rmjQGeaHCkiCa5pgSpuXiw925NtFBFJ5CHIsFI5Kz2nvSjDxwJ1JWpXV?=
 =?us-ascii?Q?CvJPz3SKFLYbq/jAs4rhUBI5itgGGQN4jPAT+tuCxtPDSTkr409F/IzcAf0J?=
 =?us-ascii?Q?XCHWrLgPqIzSmUElnqXHXqjsU7GkjSz46XwJNMjNosX48GTFKxB9gO3kXdiC?=
 =?us-ascii?Q?MvD5APO0vya2PZASFXCD8LCPo8m49BSo40Rtyiq7fqXzu/+HK9292Zb2Bz+1?=
 =?us-ascii?Q?PyE8DRC30r3uUHG8fSf420fgg5jDmo7H9FjABvE4GxU+LaZeGONrpehAp+nc?=
 =?us-ascii?Q?8T2/HqUrUE+Nfn8Q1a9+0ub03B3qH2jRG7RVGNBas3v/aKcFLSiat5vUXaSb?=
 =?us-ascii?Q?beX/emMPM3VNR/jcMCoJP7VUekp/ebrsGDuptb0vDoNLkiPCL5tUhNbwdJDW?=
 =?us-ascii?Q?hDM/8I7ei3rYj0+gcjw0Et7INZpXCkzfhTFG2YHUt8ZU/YWcrbGNMGYuQVM5?=
 =?us-ascii?Q?/ZQMd2t8ZKuNxbPXNc/R8M3pOS40n0Fbxq6HE8n0NtACwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VEZzK01bek9nxKFqLsUOK8etHzoc1wrwkl8OK78obJuoIomDvbcoEETe0tQo?=
 =?us-ascii?Q?wq8KaXhZn6qdHWHudHFtONWFbqw5EW8W7N7zr2gDlPiWmkfGfPMIgswdcdAJ?=
 =?us-ascii?Q?w0Azcy3fHkier9gjgHv4nZX5ZTJzyrFNqeU/yTaykEavAgABpVPS1LULKPz6?=
 =?us-ascii?Q?G6gxgVXfolommtkYbtdpM+JB3tl/n67FpO8xP7KBYPOjsaMCQhPib4Qy38RC?=
 =?us-ascii?Q?+zcNopkgf/QIar1AdWnJuQFeuCz+Xjkrb+mz88yFJWf19vdDP62cmIrllaKY?=
 =?us-ascii?Q?cbtzEWA6427kzIsNRkbGV8C/nsaXCitGAsCLIrxjlOUzAcIQ3AeFXkPJwcqP?=
 =?us-ascii?Q?YljjLVFbtG3DtMHqYRnrPo7YvgJ3+h+jozDHQn2FEG4ZgAXxy1cVdImtnO4/?=
 =?us-ascii?Q?S0pH2lti39sR57mNMKcb5YrA5tqqGl+zwReZ2i4Ii59yEOANRFKHSdtrdc39?=
 =?us-ascii?Q?lFC/VOBpBJKhJPGs5V/ffDRxLxTFnIDjSvKO+9OulVpK3RWUnGCmMMbX9JbS?=
 =?us-ascii?Q?KgLcNJKzw5SJcAA546I+OhBsNbOB44qNG6EXlRVvXV+wAyGRTZUu72BRpp05?=
 =?us-ascii?Q?WJCgl4G9EBXzoMUUi3jyblnHBlDb4SSY/wRZ2lpOJ+v4ADHivjPkXyslj+z2?=
 =?us-ascii?Q?mivwdjyBnT9SVJcbPEU5IG3oygcgfwb2l/IFZxJrKB5dOjVRU+mwESZzdiDA?=
 =?us-ascii?Q?Qqc9Q/p1UEi5LKV/mWle6zml2kjswPMlkKzK2cV3Ju0JWDBJqKq4yskJ07ID?=
 =?us-ascii?Q?kbfCP+L/NHlphC7PcnP71GFV7gmem2Rj7+4QqftH/4fv02llWQD7KsI07iM2?=
 =?us-ascii?Q?/tr8fbIBc99t3Jem0iTHqHDdGVV7OAZ6p3vnYhwqFTlk9x1oueZI/I16T8+i?=
 =?us-ascii?Q?vRTIokXmlz6WDoT+AoToTUhpS6HSSn28sLOFQzmuyYJHRnU4qvyxJtxZZ9K/?=
 =?us-ascii?Q?+ml6NREdpD6B4N3XlHhMR+aTOICTpytZeKlyplqr89wv0ok/qi+AgAgbQ8sW?=
 =?us-ascii?Q?T9YV2h3hq9E4zGGSMHD0DzegpYsNYoQIS1EErC7A74KbmJgAWa/i9yhR1Z9o?=
 =?us-ascii?Q?0yMUjnI8aVA5X6s4II2PmjSOaOk1WsPZqITmFdgN0a+fGrp3Z8A5p976YtUW?=
 =?us-ascii?Q?Jzf8pOX6OBZssAuNFDh7kXnlMILR/eoQj8UmfIO+S5ofvzgL+waVeMhfTstn?=
 =?us-ascii?Q?uyZ7pFHarcemhcV/Uhqg5Lk3K0pTQE1QR+/ilb65OdU0bJgKDLHQ7Ji8Gj2W?=
 =?us-ascii?Q?u5S7DJNpNFyGGW5xQwa5/7dmAxcXkutzxhFBQMBEt/iNb2KHDe7QC9NqKMq+?=
 =?us-ascii?Q?HW7OlSkaQ2cGK7XV/dH/GimDl0ppsU1dFf/SHxmjEtk9SgIAMds9gvvCBPNM?=
 =?us-ascii?Q?E84AI70vTmZIpV64XydNS1VqR25/qrihMEzFNusC5ErcqQxFCWBH0q6akSFx?=
 =?us-ascii?Q?ueczDMHudv4FDESHC5JNTsxzphockyI/cCV5NUow9UnveBB3P+/Ly8k5dnLA?=
 =?us-ascii?Q?Y1wZyaeP6a2gmj8bfEafZbegWdAzfTqS+HMzYLp+PSiG7K4m8IEsGbjhMYZn?=
 =?us-ascii?Q?nJq7vO+71j4cfD06vc0IhkWXEBWKu3gahfUIMhVj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y2DTlKX6Nju2Z1cCWoLGe2Tl2SYop8Mb+FSDgW28sYildRTyfFk47NKtPjxC1iLY8jMClTgnDe4OFYi21snP65LST9tQR+Nh3qtploKdqJ66URJAlKk1gNQ2pE6pxALc+Q3sQ2/fu/nlHD5q3c4RM8kYfOdAviMEQ2GRqxek9S37wZz6P/F8co/gNvAEMdvfBfhumz2EBZUsLikvrHFySwc7hkr9nR+kYTnv7ortLyaY3FjyS6vqF/4VJ8hThOEo6O/dkIv9CDaFBqltWv9gpDbCQjkU5NFlFOMSiviIESOIw3tbokXIUss8cniCyYbfhSxfiqoPHYQqVjIaM++R7agpBoMvIuQhwEwUAmWsEsYIIyAq6iq2hddGKSVp3dFStQQH9fHSPchRTeXM2ORMSXhktfMYKz49N211MN9b4anXqqu1GqywefThW7ejnbb0e0sp6CKXEECbOUCGO5zC348/6LDyPOgt3zNTM8UF08Zl4VuEtpUMRZ6TcMynLyfFuE3eJIZuRf1fU6E82ukke2PGyGS8x8L0opDKG+duv6/bjybIoisS0c8hPnuuSu0Mq22klSz6bh/d0yz6klLZ9bilDVcsUfnkzXlvDF/0XZc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543e1522-a9c6-4773-8124-08dcc5e44f07
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:32:35.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIMn4p/Pxv8wsJRkcrd3qVQf+8TbHlAitDyFKI4zqB6wYyHFsCVr7iNL74b9va5pPcgaHeA+h2+PBAtgRlcaBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_12,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260118
X-Proofpoint-ORIG-GUID: lELYHWHjDc-CbwE-7SavQDnhLYqioqp6
X-Proofpoint-GUID: lELYHWHjDc-CbwE-7SavQDnhLYqioqp6

On Mon, Aug 26, 2024 at 10:47:46AM -0400, Jeff Layton wrote:
> On Mon, 2024-08-26 at 10:37 -0400, Jeff Layton wrote:
> > On Mon, 2024-08-26 at 09:22 +1000, NeilBrown wrote:
> > > On Sun, 25 Aug 2024, Chuck Lever wrote:
> > > > On Fri, Aug 23, 2024 at 06:27:37PM -0400, Jeff Layton wrote:
> > > > > Fixes for a couple of CB_GETATTR bugs I found while working on the
> > > > > delstid set. Mostly this just ensures that we hold references to the
> > > > > delegation while working with it.
> > > > > 
> > > > > 
> > > > 
> > > > Applied to nfsd-fixes for v6.11-rc, thanks!
> > > > 
> > > > [1/2] nfsd: hold reference to delegation when updating it for cb_getattr
> > > >       commit: 8fceb5f6636bbbf803fe29fff59f138206559964
> > > > [2/2] nfsd: fix potential UAF in nfsd4_cb_getattr_release
> > > >       commit: 8bc97f9b84c8852fcc56be2382f5115c518de785
> > > > 
> > > > -- 
> > > > Chuck Lever
> > > > 
> > > 
> > > Maybe the following can tidy up that code.  I can split this into
> > > a few separate patches if you like.
> > > Thoughts?
> > > 
> > > Note that the patch is easier to review if you apply it then use "git
> > > diff -b".
> > > 
> > > NeilBrown
> > > 
> > > 
> > > From: NeilBrown <neilb@suse.de>
> > > Subject: [PATCH] nfsd: untangle code in nfsd4_deleg_getattr_conflict()
> > > 
> > > The code in nfsd4_deleg_getattr_conflict() is convoluted and buggy.
> > > 
> > > With this patch we:
> > >  - properly handle non-nfsd leases.  We must not assume flc_owner is a
> > >     delegation unless fl_lmops == &nfsd_lease_mng_ops
> > 
> > AFAICT, non-nfsd leases are already properly handled (though I do agree
> > that the "flow" of this code is awkward). What case do you see that's
> > wrong?
> > 
> 
> Doh! Nevermind -- I see it now. It looks like the break_lease tag is
> just in the wrong place. We should definitely fix that.
> 
> In any case, your patch looks reasonable to me, but I couldn't get it
> to apply.

I applied Jeff's weekend CB_GETATTR patches to nfsd-fixes. If
there's an additional bug fix carried in Neil's clean-up, I would
like that to apply to that branch, as a small surgical fix, so it
can go into v6.11-rc.

Seems like these CB_GETATTR fixes need to be applicable to LTS
kernels, so let's keep them narrow.


> Care to send a real PATCH instead?  It's fine if you want to
> drop my patch and just replace it with yours.

Neil, I'd prefer:

1) specific fixes to apply to the nfsd-fixes branch
2) larger clean-ups to apply to the nfsd-next branch

Untangling nfsd4_deleg_getattr_conflict() is a sensible thing to do,
IMO, but I'd bet that Linus would consider that development rather
than an urgent bug fix.

-- 
Chuck Lever

