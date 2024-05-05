Return-Path: <linux-nfs+bounces-3159-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 316D88BC27E
	for <lists+linux-nfs@lfdr.de>; Sun,  5 May 2024 18:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B0FB21195
	for <lists+linux-nfs@lfdr.de>; Sun,  5 May 2024 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472B03A1BA;
	Sun,  5 May 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i5tyVMmu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j4vczein"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EB3DDBB;
	Sun,  5 May 2024 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714926238; cv=fail; b=liIFYHCUPKCn2UB/N8/bzW4cK6aao5bnWcGUFgURDp27p1DDqmBqsVSPcBFRMYVD0VhO2hkyBu2Ksplu+PULRObEiIr01Rit85U/4XpLSiCDc253F916Qj4vV965s8/GCd1PjKMPx3fcqZyyU9AK4nzNKvoxEi1/a1sWLhQglPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714926238; c=relaxed/simple;
	bh=p5lTbwMOTakEzTNKn6iqLlj2UADMZA3kuRF9bu6cNHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lvd9Q8np1bXm8AblebX2B/w4uh+rnB9v6CKaM1m0azau7EnsTXwQA8sIzH+CC7KV6WM8HuVNECDIK/cmx8OkVXqpY8Hw0AtFZtM3xuTOAffZXtIkWW/XrNDwWQLdgidA1cqWYqG8Fn/vQlf3ZjsiojOCOu8pbkoiwUuMuTc8o5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i5tyVMmu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j4vczein; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4454qi2s028918;
	Sun, 5 May 2024 14:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=R1E1t9gYjha+Sn/QIiDE6G6gtC9tyRUVzJghWhqJhtM=;
 b=i5tyVMmu0opYG3qfCPRQrScnmlu5NeHQxAjPqejuRtg6E3YFBEgEQ8fcEINPu7CFw2EA
 jQzHXz57X/WeMPIVNMvMCpYampblfJB8RGKqoqpvCLw23rZ1r9MLZVuvPkuBfCGaukxs
 ymb2HuIDslMGpWHOgmYF3h0XC482hzcr4A/czJ4dUg6gwvmJ/gLnYzwZ+OctFLZbDEOs
 AZlY6QsvHAY1IHyYS9smx4CL+ykB47MeBJC+Hg64gi5WFeqc/omvHhNEk9mNw1AwGfhx
 7fnzoR0kV9FC7ZT8VUNRp7XrkCl2viD0wU8IaVKFL6IQ0VA4xCzbiB0P9I2xKURQH2bp nA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbt51b5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 May 2024 14:35:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 445A3BSS039363;
	Sun, 5 May 2024 14:35:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf4qr9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 May 2024 14:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hote0u7xmISjcb+6b14TFZ8ML5ZoxbKYbCdiS1okg/Ed2iiaT+fWcSJm63ByWlJFDylr5dV2B/h3fSqoW6qCRkig7SZcIUk99oEgfLPyE4hDs1ODcFlJg7HynJ5/UhrGljmywMv+YveJqMIM2aWt7dlVjIQYvzWxI6A0RQpZzVhYjb+OJFwWg4rdlAKzoxRuyPLi0jNnjKGjoWXszCEfJQbJaLJTfChIofl8fNMo8QkcIDow1IrtfEZuEYR9WroK1W1Ic1MJL5t1msokraYQ3zsFcxGQ++H/H350W/yTr6C6fzloFC8bd5kkqhisGmSYr2ntDmpv7uobVGkDLzVPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1E1t9gYjha+Sn/QIiDE6G6gtC9tyRUVzJghWhqJhtM=;
 b=FN/jjEEvi+mJ2nJksgR3AjorJtrV8zEGhqBZYw6owVwlvBIp0VN+hoHiLD0ZWOqHwr6g/6pkn91HH5T+xPktOH4JzDOvKCuBjRR5SiBwjOgstqevIpDku2bUOUkilnaMtKh+3SBXs6GC+5C2XFcFLBHeiIhksNAA6/AirKUawiTvEqtQURJAtiPB2u1NhDfUhWsbjBsYuA4O5kBEk+x6SEAYvUHK0DfWDmgGqGgBAvikp1ozMYrAxRb4MsUddjW2XnvHlq1X8PeEtLxsSWWIhflCw14tmfXk8lWA7FjdbGC5LbBJiVDV2WITZYKC29BbZJ+Bt8tk8PZzsnhYCz60vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1E1t9gYjha+Sn/QIiDE6G6gtC9tyRUVzJghWhqJhtM=;
 b=j4vczeinyFFpNSdDHnsD1gu5yBF8hVfVgjqGUFbfhbHEy9M4PgsVrkRrX58GNJmpiSSS6R1Q3RnSs2y143BsXQa6qQuUDFcPDnDW2khDzb8fbBmekvexqx2UcrBpB+nyaF9q85D0Vui8vjY5+Mc63kdmZMcoyXNykXkUTw8hhng=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7191.namprd10.prod.outlook.com (2603:10b6:8:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 14:35:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 14:35:49 +0000
Date: Sun, 5 May 2024 10:35:46 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Dan Aloni <dan.aloni@vastdata.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rpcrdma: don't decref EP if a ESTABLISHED did not happen
Message-ID: <ZjeZQmi7um7LDOd3@tissot.1015granger.net>
References: <20240505124910.1877325-1-dan.aloni@vastdata.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505124910.1877325-1-dan.aloni@vastdata.com>
X-ClientProxiedBy: CH0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:610:b2::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a10f9b7-9dcf-43ba-ab96-08dc6d10a850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HWL9aojeVZyHS815YRs6MVtoPOa2g+gOU8r+nL5QvpH7MvVhsw98dO8xM5dD?=
 =?us-ascii?Q?DLyCE3nR1CHu1+2pVCAT8U5Nb9ipHk/WGAAN/zxftmc8a+FT9Xv1yI/cjuAT?=
 =?us-ascii?Q?ZLjxibBLN1jHNR4zaI/DcOmj/dzfL8pEWXN0vuSvCJAomyRjgTUttQ7sy0mj?=
 =?us-ascii?Q?qQHMCYP7Vyv0/594IU3IM3+tuFLTuD/K+00A5HZXEH2TOJYAJmPo9eo+KbZ1?=
 =?us-ascii?Q?RHFiz0EggtroVelSvGVRkKLuTGSpYQYbook8VPA2fuUAUZT7Rz25klunjT6P?=
 =?us-ascii?Q?Q5Owv86RpKW5IOrYF0JNUUk5BpOnecbwM5aiuOlsDpRO/Fa9uFyAzoxNYDrW?=
 =?us-ascii?Q?i5FAj+H4hjPsO5vmbl8mF94HGJ0llc8HPKAPwc1k+dP02JECyj1B5zAxhbgM?=
 =?us-ascii?Q?GoF+Tzs5uyrDAI7pbF5uHzxc1zRFqm2E6l0NXA+Am1oIxAP7eZWmKFZeOtDr?=
 =?us-ascii?Q?etf40f5aUVZnLNIJNOqmh9qMVaZ4pVEFS+lSxh2VkwdWcO78C2extqcwk2mC?=
 =?us-ascii?Q?rXuv6iOkDHU8QVj5NXKEfqNwUvDcPa22AvBSs7eKhnZxokYR2aObUQFlgwuo?=
 =?us-ascii?Q?7vclBFdlzIOfHVQ4w6a32JskVvkKR7rgTM2Ws/Y3Mmcyrmrx5WJJNhQ/aI1p?=
 =?us-ascii?Q?rzlf8pI8ARAui6NLkFwSoJjvHq3UBil51xO+/zvASExdEXazC3eztAbjAnem?=
 =?us-ascii?Q?nUAGRFpkfPe1NoIjmQU4Yf0GAA+RtWK/KTi6J1IvTvPvzyjziu/G6QUHd2Vs?=
 =?us-ascii?Q?h9/vsWRVM2apqk6rQIiB3XIfXCni0VnoUGzzVq0GakApMElMVaixGoJ8XSNo?=
 =?us-ascii?Q?kvZs9SkHDiMcLeQ6B0TRH+maNUtgGp9ga5e8oDiC0VLRQUWTvfJ2mQq75n92?=
 =?us-ascii?Q?2EAtzOlM4N3os3iFpXRMnNXi/gSNYEkTInBPNTpTxgoLVKk/57vX/5ZhYuxw?=
 =?us-ascii?Q?/mjmKtSrdjun5TdV5iPT3AazQ6XQC2zMkdr07l9Wk+OO1603Hnpbq6DASPQM?=
 =?us-ascii?Q?3oFE7uurTbPQX20c2jUx23G951KfK1Mux/UjKPTAakKSfZayhWJ5T+rFMZGd?=
 =?us-ascii?Q?u22tKUOp8n1RP49blJvfHHJ5KwFZsPF5bUo2s4xncD7LG6CPkjk2Sa1qjWGL?=
 =?us-ascii?Q?Ze3sO3qGfczThiNgoYPTRRIn5QNg454WnGZTvI797d2TfnV6zmRqzAPdKX9I?=
 =?us-ascii?Q?pRsCsy46wRDEg+saPFMnhe0NwYogN/ISQXQS9hAuHsknpN4xqgUjBWLi4UOe?=
 =?us-ascii?Q?SnX8KK3h40VCmJgS9GUI/3KH7j6mz1nWu8QXov1SyA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9/e/YC/XP2KG+t1Z8a/DO4WFZFA5gHuWYc1eC1weSQ7WGMsgDN7HedeCIPnA?=
 =?us-ascii?Q?uQOBx9AwjahR4u57eatqipbc+AAr29IPJFDEUqN5nzlZ01otdC5QKs2Z4R6c?=
 =?us-ascii?Q?l9zNyvdmEODeeYp8uBvW7WudlrH7+MRh0/Dw7ILY8lggTSiWyNLAcxkc/Acv?=
 =?us-ascii?Q?QhULxNc8TsT2y67l2pxNha8t1XaLs5MEKZvPeX+QXQG29U5aKSiXsaKswdul?=
 =?us-ascii?Q?SL0xoqp8NF0lzuYYXz90/uExuRJ24/2f+g9WlyqD0EZ1IqNc+YAmo3t912Tc?=
 =?us-ascii?Q?40JU/siH2qDijOAdFD8sEK/ZfinMHkwPStXTPWVCgh6tubEs3BRpX/Y/sNFq?=
 =?us-ascii?Q?PvvolGeR5xHSbOmf8LJLSgtQSQQ4GB6nf9kUHfgJUi8Mf3A/LWGkcmiMmPVa?=
 =?us-ascii?Q?JTYMvgjL19z8q4ztEoylZUfLWJ6QJELYbPPtNC/pE1HPaIBUiFiVnxvNCzXv?=
 =?us-ascii?Q?54yyuEDlC9GfL6rmu/b8/c9kHmY5czL+XIet71UvB02NPUW9C98MBU4qa/IJ?=
 =?us-ascii?Q?dLgSjpp4PcJbQzaOwCB7lNDUCyBL6g7Vy7wmCe6H8WjUwPnnsKhLV0IRpN/a?=
 =?us-ascii?Q?yKSTb+D6MOjLXCHfQy6HCCPGI3wW+JETWXTUgEgbDt0E4sPlsB1b0cu96SQ+?=
 =?us-ascii?Q?UpzalVyfMyQcQdtepU5DBP1oEEDT9dPxe+/873p57xPW0R+IE6pSkElJ6Hbp?=
 =?us-ascii?Q?pVQPVTkLL9Tzj5Lfk+HIJ5RZqWWQI0q/KGavxPp2mmu+yChbUzlDqtUh+XAA?=
 =?us-ascii?Q?1KyfStNwQhVgG9LEhPhoQ/mpjfvZF5imUlDsVY5aUnFGdlHvBTKaxASCS15R?=
 =?us-ascii?Q?ll01rbDq+pE6w8163iIwNagP6h77hxnPmQ51etlY04YCnnNgFVdR1ybf8zTQ?=
 =?us-ascii?Q?E0YPYPNdGSkWnzGFk64qVGRyWYNnr9e3aT6x+YC8D3nWBh+fU4KbsbHO6uOu?=
 =?us-ascii?Q?PYOFETfHufRvT3OVGi3yk3s0fl9isiTcQT8SgqRyDSP+iz+d5KevOLAD6qzg?=
 =?us-ascii?Q?7F8T91tCZ+muQvAVhIlASu8g44+OGVC1eiclXIV3z02xSS93pAofz+PgFI7S?=
 =?us-ascii?Q?d7u6e6SxvlJDkhtenPjw+P8BEN3jRywbw4a70N0H8YgbSXQFKDmv6mAeBDHQ?=
 =?us-ascii?Q?GsEC+OsEUBbp/FeU3ylwpGViCJbI3+/5vTYxVwLAxgX83b7PvitfxWHSARv9?=
 =?us-ascii?Q?oRZ6MdRUei8W6e6ZSqKVPa75INBX7UKhSqCV2QrZrTsRiRkvdrRf92T+EGAP?=
 =?us-ascii?Q?2DsHKDumGiYY3neZ5SbQ622CGkW2RqtWDIgGOSGmdodsJ5tQHjGWsB4/R9U9?=
 =?us-ascii?Q?ZK052LNOBSY1P0FYYorlclmKIlwt9eb/MkM3fehaUYVl/Ni4lZ8LAITJ/XCO?=
 =?us-ascii?Q?fdlhlSJ2/x9lOj1Za6Uc/5ygLz0YMNGWDsHmMvZFanwLd18EUUMT3ZqJoduR?=
 =?us-ascii?Q?Ac4qJJ0Oz5S2MJl/qD+WfK3BJVwENiAQJF+ieBumbtcF6ylmy3IIo2c6h9pN?=
 =?us-ascii?Q?nuKLyTxtYBBv/2BJc2NHk3g7pkbe+PPkkkgdPN5z0/xwrGpHNHmk55u3VATD?=
 =?us-ascii?Q?XI1896ar8hh4UTMO3Ljf+zSV5KuXHwoqE0fw0nMH41xR80qPNn7qrSTSgP98?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1oQFmf4woH8V2NfTQWUARoROof16lYIJa2L+MbPwMWVPxuq5nIBLkKT+a+TSFstE/Twzmn52mQqwuCmmwvLSJE/Aq9eIZkLHuvdvzMcKPg4Ze52gY8xPI0JZix6QNYb3cj2hx1asycOir+rEY5n1p54hME+F+F7EbvLNcHKNEBv1hoMsr2AGNxTtz0Tg+F7+rWk9nMRjdI3JJqIc+erLaXiZrm7u5m2WR9/8W1J4uB2a5/DAoRIASCikOQ9yQy5rtk9rFQSpJFwBbh16D7RNgrdNhf9IavgEH+/LW4WeHyhVnX1gJts8/61/FZrysUwOTD1CID5Rl3tFo+YYvnFLcQNd64nB5lWcbrcrjnP5Wi+xIvv6Cn1Qdpb/s9M3ucF9FaNEmBKZCnSD72nS0OZIgfijXvuFGZzeDr/KrRbWv1ycaoRftDJBdFTY4XnsePAv1H5BecYXtwk3CyM8Qfr8Bk7YTsQY3wv58wMPpbydICS3rzVqBgJ9Rn/H5I/aYZ7YjpnDgpqs4C9XUcyseq2nMDphFJB3bJWmVRSHGwotJYP3eYEmch1LpjBbjMCK6mNcnQ+sGs17b0FZo9nk7T4ezbusaqHwuYB9F5aqescO0Og=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a10f9b7-9dcf-43ba-ab96-08dc6d10a850
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 14:35:49.3734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsTgCGzzYPgss9oPhlvWg0YRMILq/fBIncj6mlyjDXH0Fo5E22y2efZGnxIaTpXI9Mgrupx7RMzzp/Q7jFJGJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_09,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405050065
X-Proofpoint-GUID: P4y5Pr_n3OhtDwU5imtl45s9qyyDoGPT
X-Proofpoint-ORIG-GUID: P4y5Pr_n3OhtDwU5imtl45s9qyyDoGPT

On Sun, May 05, 2024 at 03:49:10PM +0300, Dan Aloni wrote:
> We found a case where `RDMA_CM_EVENT_DEVICE_REMOVAL` causes a refcount
> underflow.
> 
> The specific scenario that caused this to happen is IB device bonding,
> when bringing down one of the ports, or all ports. The situation is not
> just a print - it also causes a non-recoverable state it is not even
> possible to complete the disconnect and shut it down the mount,
> requiring a reboot, suggesting that tear-down is also incomplete in this
> state.
> 
> The trivial fix seems to work as such - if we did not receive a
> `RDMA_CM_EVENT_ESTABLISHED`, we should not decref the EP, otherwise
> `rpcrdma_xprt_drain` kills the EP prematurely in from the context of
> `rpcrdma_xprt_disconnect`.
> 
> Fixes: 2acc5cae2923 ('xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed')

Hi Dan, thanks for the bug report!

In the future, note that the Fixes: tag needs to go down by the
Signed-off-by: tag. But I wonder if 2acc5 introduced this issue --
ep reference counting seems to have been added before this commit.

Second, I wonder if, when bonding interfaces, there's an opportunity
for the verbs consumer to take an additional transport reference.
Cc'ing linux-rdma for input on that issue. Can you show a brief
diagram of when the ep reference count changes when bonding?

Also, I note that the WARNING below happened on a RHEL9 kernel:

   5.14.0-284.11.1.el9_2.x86_64

Can you confirm that this issue reproduces on v6.8 and newer ?


> Example crash:
> 
> rpcrdma: removing device mlx5_3 for 172.21.208.2:20049
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 60 PID: 19700 at lib/refcount.c:28 refcount_warn_saturate+0xba/0x110
> Modules linked in: mst_pciconf(OE) nfsv3(OE) nfs_acl(OE) rpcsec_gss_krb5(OE) auth_rpcgss(OE) nfsv4(OE) dns_resolver rpcrdma(OE) nfs(OE) lockd(OE) grace compat_nfs_ssc(OE) snd_seq_dummy snd_hrtimer snd_seq snd_timer snd_seq_device snd soundcore uio_pci_generic uio vfio_pci vfio_pci_core vfio_virqfd vfio_iommu_>
> isst_if_mmio mei isst_if_common i2c_smbus intel_pch_thermal intel_vsec ipmi_msghandler acpi_power_meter xfs libcrc32c mlx5_ib(OE) ib_uverbs(OE) ib_core(OE) sd_mod t10_pi sg mgag200 i2c_algo_bit drm_shmem_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ahci libahci drm crct10dif_pclmul mlx>
> CPU: 60 PID: 19700 Comm: kworker/u132:4 Kdump: loaded Tainted: G        W  OE    --------  ---  5.14.0-284.11.1.el9_2.x86_64 #1
> Hardware name: Dell Inc. PowerEdge C6520/0TY3YW, BIOS 1.8.2 09/14/2022
> Workqueue: xprtiod xprt_rdma_connect_worker [rpcrdma]
> RIP: 0010:refcount_warn_saturate+0xba/0x110
> Code: 01 01 e8 27 e1 56 00 0f 0b c3 cc cc cc cc 80 3d b8 29 9b 01 00 75 85 48 c7 c7 38 ec 04 93 c6 05 a8 29 9b 01 01 e8 04 e1 56 00 <0f> 0b c3 cc cc cc cc 80 3d 93 29 9b 01 00 0f 85 5e ff ff ff 48 c7
> RSP: 0018:ff34fa4968cafe10 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ff1210404a15e000 RCX: 0000000000000027
> RDX: ff12103f803998a8 RSI: 0000000000000001 RDI: ff12103f803998a0
> RBP: ff1210404a15e648 R08: 0000000000000000 R09: 00000000ffff7fff
> R10: ff34fa4968cafcb0 R11: ffffffff939e9608 R12: 0000000000000000
> R13: dead000000000122 R14: dead000000000100 R15: ff1210404a15e928
> FS:  0000000000000000(0000) GS:ff12103f80380000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f170f8a5000 CR3: 00000001c3adc002 CR4: 0000000000771ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
> <TASK>
> rpcrdma_ep_put+0x42/0x50 [rpcrdma]
> rpcrdma_xprt_disconnect+0x303/0x3b0 [rpcrdma]
> xprt_rdma_connect_worker+0xc8/0xd0 [rpcrdma]
> process_one_work+0x1e5/0x3c0
> ? rescuer_thread+0x3a0/0x3a0
> worker_thread+0x50/0x3b0
> ? rescuer_thread+0x3a0/0x3a0
> kthread+0xd6/0x100
> ? kthread_complete_and_exit+0x20/0x20
> ret_from_fork+0x1f/0x30
> </TASK>
> 
> Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
> ---
>  net/sunrpc/xprtrdma/verbs.c     | 5 ++++-
>  net/sunrpc/xprtrdma/xprt_rdma.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
> index 4f8d7efa469f..19996515da94 100644
> --- a/net/sunrpc/xprtrdma/verbs.c
> +++ b/net/sunrpc/xprtrdma/verbs.c
> @@ -250,6 +250,7 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
>  		goto disconnected;
>  	case RDMA_CM_EVENT_ESTABLISHED:
>  		rpcrdma_ep_get(ep);
> +               ep->re_connect_ref = true;
>  		ep->re_connect_status = 1;
>  		rpcrdma_update_cm_private(ep, &event->param.conn);
>  		trace_xprtrdma_inline_thresh(ep);
> @@ -272,7 +273,9 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
>  		ep->re_connect_status = -ECONNABORTED;
>  disconnected:
>  		rpcrdma_force_disconnect(ep);
> -		return rpcrdma_ep_put(ep);
> +		if (ep->re_connect_ref)
> +			return rpcrdma_ep_put(ep);
> +		return 0;
>  	default:
>  		break;
>  	}
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
> index da409450dfc0..1553ef69a844 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -84,6 +84,7 @@ struct rpcrdma_ep {
>  	unsigned int		re_max_inline_recv;
>  	int			re_async_rc;
>  	int			re_connect_status;
> +	bool			re_connect_ref;
>  	atomic_t		re_receiving;
>  	atomic_t		re_force_disconnect;
>  	struct ib_qp_init_attr	re_attr;
> -- 
> 2.39.3
> 

-- 
Chuck Lever

