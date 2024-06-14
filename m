Return-Path: <linux-nfs+bounces-3834-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD71908DB8
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 16:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB062870B1
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F84F9D9;
	Fri, 14 Jun 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TzTxWrOE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vgvaOOhw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD780F4EE;
	Fri, 14 Jun 2024 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376281; cv=fail; b=E4Lj9t5ljEuMhqt5AYixdiQ/x9YLQk92Rw0nXargSCipwxbcYZ3vmry5xZZoTw0TohClGeDVpjqeEazYTHwIqm40Rz8Q6VLr70l5jqKNZapZc3X4wsxwYH6NnEeNUCnDia8hgE1bLQ3gNDu6GNVxvN9KS0/cri3Y26hdcXi1sGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376281; c=relaxed/simple;
	bh=AXZgjp82o+UkutJ7GpbL0/gb/5PbHfMTDvitb3PIlHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B53t8OeBvFK4bV0K2ZDjJXgWHVcW9+JFtQbYawRXyT25DrvI0ZMoEMPYHYGkg3jlmhyLHgo2h0bm7zmKqvMQfYw+WZ9b+393oR8ywjALAJYWk+oiS3dlPHx+JmG7pcdGOdJtlfnRf8NkXJWX0iDXzL8Fn7Gkwg5dYLyUPDW/Ch0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TzTxWrOE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vgvaOOhw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EDH0vc013755;
	Fri, 14 Jun 2024 13:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=nKtcRtwp5sIRCOC
	5BFblVIh6fDJ9FMe0FE/9VzxuQFs=; b=TzTxWrOEjr4iKWLfIfLtUe4m6v0PJUP
	MOuBQT8bpos/4OgLpCX9CKjSVIh/7UZSCkFaj+1DWaS6UOtShXDKTuQtVLp0X75O
	v8O8paDzFH3MC4/1NezpZ5kuKbqwRRZXhq6fsa4C7ovPtOKJROMKsqCjsu72dgy4
	KaBRiLZL0NDGBJOWxjcsB8s2KmOpkD/4fnJhwoWpcOeDgQPzGzwmenIpxT0hBNpX
	v4mWtccYDNviWEgBtG5K8WFMqFnIolwq0qSA83Diyf1O49/VjitrkPLbLzVzMTZz
	GUdR3MYAvgkCEbCRkvixN/2hLULx3r9cpCS9wS5ufOll6vR9w52Lo9g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7dupdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 13:24:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45ECq17W014226;
	Fri, 14 Jun 2024 13:24:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ynceyb3s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 13:24:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XczJ+idp3/GR0/DaZVRfXjNU/6X/BZp39Tn3psUkglLb7kHJscj4Mi/nh4/BN8+41StZoHlBnYwB+Z0Ydcovh2oWE1VdYOZTMrMxXzf7YcQlwtl+jME5NTPWKwPZbYmbQxzdGOdNzLOhm89pzOYcyVZT83jguh+PvwXjKM/ki6qVDtV8/bYt+B022Sw3bisI+YqT0agjRG03fW2MQyW7cIINDikY6ViGDpwoaHJeHtpSliHsrnwDBoMdxj4t0N+8ps1Ehxx77KxYcVcR8pnLfGcNbM9dWfdsm5/ENpioEmUW7qQkPT/pleHgqQQ0dIOK8mGDcmVggxpwW/DBmxwn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKtcRtwp5sIRCOC5BFblVIh6fDJ9FMe0FE/9VzxuQFs=;
 b=h7pjBIlbj0NRA/E4Nzt/llMJScXvgLbSZ+Y0hOQVVajNt0JzaJoT/xoHeHzIzSnmUK+8MBCLN0tl9DYMi3w7Qtklp42XFnvJMbKLnglxa4OE1roQrIYxZzxAu8ZS2PPhWs3imKLzCZjdqZ7rINKEQFIhIZfb4qNeRC6kgzDgrtm76njf3R1/M3byoQdBRO5g5facg5PtnWnttQ92L1DQPdfGcw/EogbdDN9QmfCzhpKyh33GEz1alXkDnRJbxh4/4t1SHBtU3WW8nuPpbX93N0mkSumBOzmFMx30Qel90gdS1cETyR2ZrrypHnkO8121PGbIUtolK33Aay4MoLMiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKtcRtwp5sIRCOC5BFblVIh6fDJ9FMe0FE/9VzxuQFs=;
 b=vgvaOOhwTuMt22WPOlvhQ0zCG9m4aKIm29fK619K05rAztIMp+Bt8Og8rNSW0z41nzWPqRaBRn1gY+OYxo94bVLm/69mXVRAxMlTFHdxzMYN1OML/19gkyGVbElE783aVptCR7+Qp0OLd3oiAETx617GtFusdRSNZExP+3WG8no=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 13:24:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 13:24:24 +0000
Date: Fri, 14 Jun 2024 09:24:22 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix error handling bug in
 nfsd_nl_pool_mode_get_doit
Message-ID: <ZmxEhlVWsj5nlsLa@tissot.1015granger.net>
References: <20240614-nfsd-next-v1-1-d360eea79d0b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614-nfsd-next-v1-1-d360eea79d0b@kernel.org>
X-ClientProxiedBy: CH0PR03CA0435.namprd03.prod.outlook.com
 (2603:10b6:610:10e::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 687a8fc5-9323-458e-e786-08dc8c754f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BNaG6OJGy/n62WSiF+qIqtiJrUbMggDh31W9ChZsxlwLELmLTv1jwb2Fx6w8?=
 =?us-ascii?Q?+yDclVfDC/+/nEBAHT27FMFBIwVjuMvJXATwjrWlPLlo562hl6UCeC2tOYWj?=
 =?us-ascii?Q?0+3yviwne8TzRUzsv1XHKTYuuOhtr32snA7uRp2cANn9/eXLPtYb9DRkJaNd?=
 =?us-ascii?Q?nDL/nOo8sZNnmod7UBdAbx/mgYQtsdXdwJhGrh5i/fR0eRWRBWNBDlgDXE/z?=
 =?us-ascii?Q?Xi4+mGHbPP7qzfmVa48fm7VTo4gyxcoL5yCBLyzqZ7VIHFIY/IdEsgfYY0F6?=
 =?us-ascii?Q?Ahi1r7rCXXVk79SeT21pCDymg3l1KQs/EiyjuuKAnB8tYmjEBo51Zq5L7Pm7?=
 =?us-ascii?Q?8zzpA3U7UGdhbyxAFbsS6yLHmOAgMZMZjiSh40UYzTfjR/c0ng237+UkjDwi?=
 =?us-ascii?Q?O9xxqiA7LOTN0ZTOqWmJKyefwsDiclub7ZSGyF0SzA4Fkdhn/ZwyVUVUkJZ6?=
 =?us-ascii?Q?7tIFvJNf3FimLvruXK1TkTJmGBWf8NX2CeCHUISgr3Wilg9Gjep7QBRhMW1z?=
 =?us-ascii?Q?rcI7TNNm946j7YVAPH/E5VwCIWxnqJ4wFSHm+EfT+DvfBUSdvSYJSvohEl1t?=
 =?us-ascii?Q?tCgDGf7iwrVm/0DM54+WCmUWC0/ldHQXt3oq1z0VkwgWWFCnh1H+D5D2VlvT?=
 =?us-ascii?Q?OElbci4PquPVS8nnP2TpctiPIpKtI78UB2A7+jbaRHd1kMrbNW4JcTX+sn5S?=
 =?us-ascii?Q?mb9eFLlCPE/VnUmwrHgCK8M1+CJ0GwCDl1VCKoqcmBYt+CBx9qsHTlbXLm8r?=
 =?us-ascii?Q?IyltALX+CNTlPzKa/I9REQ9ktPZwXIbcZg3wacla9KEWimxdYKe4oVMmW0l5?=
 =?us-ascii?Q?Xxke1v2mRqDwVKPDhkTUQft/hkVa3K77yjRDUH6qG8jiuCPlACauu6PXSg8p?=
 =?us-ascii?Q?TvZfTHJFel3bHeCEK5EBQ8Z0AgX7coJzzLYe6I756JVWJFY7JmZ7Q6DAGjZG?=
 =?us-ascii?Q?4PZP5xzO8OD98k1/Dt/M40XP0jaII7aiW1AjKHhYiQEDprV80qV5tMvBEaey?=
 =?us-ascii?Q?P2oMNLvvPdIf1tuTuv+C6WtJA0x1sGqDl+7T/lBs9pYh9eViqR5MHEvdCxjW?=
 =?us-ascii?Q?KO77pg0+eHOf9KgupFfkytT3LsXaGjwtZB41hEdU7HtWyhOBftt7ZBFRIrR/?=
 =?us-ascii?Q?QVjBo8S8GTchLp3gYTyRWw2qn1gqhAMQaCA2iK5rOI45d4UnTuA+/pf6KSpW?=
 =?us-ascii?Q?45L2t1BPInlqh8ZnKwmunEp4DrmB+5Cl2fgMKSINzZsyUkLu52soRQZX7kps?=
 =?us-ascii?Q?2FP9jU3lLQFp9sC7e42Z5CpnaUXq3UgE//1ORaGcU+LRqwt7x8KBpAumLQJI?=
 =?us-ascii?Q?i3O5j8sUSWThtviOx2+RPYMI?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AbScgKGq6IIMqKqG0gdOPIxzdpveaJrMO9Iv0eMbNJ/kkxgaANXcfGSvlGrS?=
 =?us-ascii?Q?lqD+ZzlAL2QTBURNOE+1OkN1Xmwdxr667n0F3NYYqrwqRPONiMgHRnnjbjI6?=
 =?us-ascii?Q?5ueWjB6T9nvKu60HBVi6fokDn5n1dRoWptC9LToT0lQq5NvAVQlQF/127Jff?=
 =?us-ascii?Q?2sDZjBrdatNCUfoyjaZs3RLBvD1cm88E9CrYuBSpERHzh37Bef0QizOxGqtA?=
 =?us-ascii?Q?4f2jIR9F/cv777oQWItRbD+vVlMinkz/QhYoe690X/94YaCpHMD6FKaufRRy?=
 =?us-ascii?Q?Et45+v/402KQ+LnA7WzA5et2BUWeBuV9RMl5NxTYFnpxqSBL0jWybBW+WsbL?=
 =?us-ascii?Q?DJSeG9oMKPv0RDuGjGben8LFUY5jM6m5D2o574jf4fn1okYT0zXHoM1NR7jV?=
 =?us-ascii?Q?jhFok724uwvj1stT833rACkseB7WEyuG5kSWrUOs4PHSa4XKg4zbW+4xLrKV?=
 =?us-ascii?Q?FLJxJch5bK6lVsFpGQE96hMNmCsh7kB0Z2AyyFbbxOiCnwx/nVnXTe7lZDZL?=
 =?us-ascii?Q?VSiSXSnFHMkxpOq5BDTmaqTtt6uvJhX9VVfqjjHimclHDwIRNw8SqN+tlaHv?=
 =?us-ascii?Q?fWUmRSgq8vfbN90OwCaUH5Wng+5njFAInu0jgoXll7xoUu5hob0wCxxdvTjX?=
 =?us-ascii?Q?YWCCyPViWhXP43ArjqhqfhIW5CqhbnjIKwTiQzix1PQ89cXvLyIpbOcpRIS/?=
 =?us-ascii?Q?gLC/mGzE/ibqEedz/UgAjHPBevZNUmDQlGDwKaUFSWX2sZClLydHPfu0Wy80?=
 =?us-ascii?Q?wwe4m4rN02tLwe/A/+vW3BILCcf9R5W1pC3WmLjhurwG9RT6ZfIIjoCA+FBf?=
 =?us-ascii?Q?alTdumJpX/E+AwG0oaRreawx8mXtSkbSPiTWbXOe5ihSU5bTVL3ETTawpPVf?=
 =?us-ascii?Q?XURRtATRB+4bQrX4aGGpixCvlBPgLOy0CllmIEYcMbxjlxLfqxtp4mvA62Xe?=
 =?us-ascii?Q?UTi++8Lj4Gof2p0lgZXDVeQgww86Ojx81Q3Bo1zgo+7BSxYIdwgJSEcOcXbm?=
 =?us-ascii?Q?obnq3A9CQtybxRbdHQ/IdY7kEQsF3Y0pmMVx90/VLA6e35/oQgALmEqjG8YX?=
 =?us-ascii?Q?WV8Fv6VRlprXbe9HjL/5xZcvDB+06o5us/LLDY49d/BtfR36zPpGM69Gm6QQ?=
 =?us-ascii?Q?XkTZz39pnDQ/O+DmABZdpIUvFg1ECjj7WZ+AUBEXQ4aBEyXaqasJTlKRvfz5?=
 =?us-ascii?Q?5zGWimiMU9naAdRxMN0ZfkMG/nnVm3+RXyyg7ATjzhZN1Wc8vOSnXoD/HEj9?=
 =?us-ascii?Q?+DpQGoP5Jq/hFMFyNvudPSX72+Bi2AyXbfe0k6j1YY2gCy98LI/zUqB+HtEh?=
 =?us-ascii?Q?mVk3yGmt4Y4R1gJ+j5IxEbdu08pDU3AcSRkw6Ba3fWRDgq/4Lj4YRDOtpeYk?=
 =?us-ascii?Q?Vf2oA1wOcIqaelHy8PIh8N0qQ9QvnNWloh+MWTGBVxOg/zmcJnFZlIS7wSvH?=
 =?us-ascii?Q?eXNRtMZCFtdvxzukcIP+tkIRICfiaoPGERbUnvIKNchZJXTIhA04FmFpZbpN?=
 =?us-ascii?Q?WEnaISqGnIvVLXMnsYJLW55tRykEi1hCgT/RlGtZpisw++iOXqVDIVqV2YSf?=
 =?us-ascii?Q?cR61wZUkRU0gXGMQ1vPQszcB0zKQocYRZ04tJkHOgmXVr9eGpWmAPb7UuTsz?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AC0GITauxgZc5GP4fG16u0z3vo6eeo85kp/v6F/lSsOkh1bza+6fiFuSOKHJtmg+j4bRIf/xUBYnBz6J2aSS9G9hRq65LDeQWBW9JpbN94wdrKgG2tX8kfe5gb13+JawdQOqGfzokNaxPqAvB9TqadNsKWL0+rjeDAqcI31TJaNfm3MCdEzVdy/jxrF0Fp661XLuCyPA9dgz0OGUu8AwT60sUWzOF0knqtNDjUaJL635rRKEEm0OB05UIlPtgmBkrht7it3UqXTX4RYKk0vjZeAUrGSQBGx84/Gp/CrqJoHZLZgIURyQhpXHAkN2knU1hNtvim0EZvzcbZ95wOm+eaCxMDvnG+CRxa70xQN6SiYb1w/z2tYje+M2GIUMMCLZmE5lsSh8SKxhUv1HPhlprBcrYskA/Ms9B04glvAdeajptRJX/9rdrfmTGZx+fmMHwVDPyVxBmlSVz3r/B3mSrNKahatAVAYHG973A4poP5FXhVTLr4nvuP+vVibou1t8kTqVUbegh3XJsY6oWQpECDVyPqXPgaD33KZn6xeDqa5VpEAVfMW6VCoYLZmxxbyxtj0haoJUjM9K9+W46QyS/8IvlPPVZfeLfKj7Pn0ef8Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687a8fc5-9323-458e-e786-08dc8c754f0c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 13:24:24.6702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cbJStY10F7zpnJm3XoteyqZ27qylyZwz3rzSjy39v7nJa8Zzq6sAKsGqQkzvyvf3pbQvl+He4G62xNr6deaig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_10,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140090
X-Proofpoint-GUID: ZjbcIC58_A7ffiP8HyIHfLzwd09Z0jwF
X-Proofpoint-ORIG-GUID: ZjbcIC58_A7ffiP8HyIHfLzwd09Z0jwF

On Fri, Jun 14, 2024 at 08:59:10AM -0400, Jeff Layton wrote:
> As Jakub pointed out, I meant to use a bitwise or after the call to
> nla_put_string. Also move the sunrpc_get_pool_mode call up in the
> function, which simplifies the error handling a bit.
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Technically, I think the logical or works just as well as a bitwise or
> here, but this is cleaner and maybe slightly more efficient. Chuck,
> it's probably best to squash this into 84a570328ee.

Done, and pushed to nfsd-next.


> ---
>  fs/nfsd/nfsctl.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 187e9be77b78..e5d2cc74ef77 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2214,6 +2214,9 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
>  	void *hdr;
>  	int err;
>  
> +	if (sunrpc_get_pool_mode(buf, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
> +		return -ERANGE;
> +
>  	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
>  	if (!skb)
>  		return -ENOMEM;
> @@ -2223,11 +2226,7 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *skb, struct genl_info *info)
>  	if (!hdr)
>  		goto err_free_msg;
>  
> -	err = -ERANGE;
> -	if (sunrpc_get_pool_mode(buf, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
> -		goto err_free_msg;
> -
> -	err = nla_put_string(skb, NFSD_A_POOL_MODE_MODE, buf) ||
> +	err = nla_put_string(skb, NFSD_A_POOL_MODE_MODE, buf) |
>  	      nla_put_u32(skb, NFSD_A_POOL_MODE_NPOOLS, nfsd_nrpools(net));
>  	if (err)
>  		goto err_free_msg;
> 
> ---
> base-commit: 84a570328eefd4df2e201deb5d43d152e0aca55a
> change-id: 20240614-nfsd-next-d5f6bbdf027d
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever

