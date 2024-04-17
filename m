Return-Path: <linux-nfs+bounces-2882-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC98A88D6
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 18:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F071F2168D
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B9E148836;
	Wed, 17 Apr 2024 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NlwTph96";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A+GdJ5DN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01CE1482E5
	for <linux-nfs@vger.kernel.org>; Wed, 17 Apr 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371317; cv=fail; b=IWDkzKSxKJEGb5mCoO0gNO5zWGadOFHM2lGySzsUHTOAQ8Do0EZ5LdNLTGzoTnb003l8idWflCbgkKfIaV7acVC90wkI2t8nJVr8sXBg1Z/wugboIvnPqTfEVA5JsLSRXsWe7Dvp3A+Po6lOBObiSK/C/PbITGNoHtDVcmdjIaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371317; c=relaxed/simple;
	bh=0chVFiOHzTSI7RyvIwecIlCTOl/sMqxBuRjwx14xtJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jzHy3Sk54dTlimF/ciW083vEXvSggJ3f36yXwFSeHkXJUEW58JVZBye/grB91P66OG7ZfqTx1SUKhUF7gb5mKUNoWScUP4Cr6W3jNk9Tua0BGevwp3IjeHocqc7nErnj4BQq8/b6Vz4hzywqcNEQpvEEgM+zZpuoH6GwnU2g0MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NlwTph96; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A+GdJ5DN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HFOasH020519;
	Wed, 17 Apr 2024 16:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=gX0tdRKlkLl8BzaItn4ad6klH4mGryksLiW2yk18kQs=;
 b=NlwTph964UGfQdcJ6j5jf2LDce48rJQug4P+76078hyz0heLdpyikQP8ctHySEwkV4pg
 DMv+vjTB1ZvKav8Y4z6omlMfrDmudvQOudGU0lOKN7q1OcIl1flVGXy4dLjXn9M6ZDm2
 MVfZcsUWcKCw1nOAgBt7A2LXhdS1V6tIkb6lDsINw2c5Ei7xSUaY3KLCTuhC3Ioeyu7A
 7WjlGe+YLzhASN0VwytKykMjllb/6QB0gVGaCfUeibXsSDQ2FKkJmuhlFDxaIjdDU5UT
 FDTPermPCzXTXHMKlLninLLxm9cRCeNEols4NfFDziQubWcsjTVz28w3IIyQ3TX1DEzl xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv89g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 16:28:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43HFPJr3013462;
	Wed, 17 Apr 2024 16:28:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xgkwh5904-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 16:28:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFK6SPy2yoiIMg6yMmIuUMAtRvQWHJiVkV0G6s0AC8w84bKhiNOGrJcvOYzzc03h7Wqb3MQvZYTSBNss3gyDEXHKnFiPzSurOqQ+rlCm9mikTaJVNX8nb4Kg9wfS0T7BXie35aGTIfxx7aKHCPhrOIDwSDOV2zc0lyMsB+fvcmNYOVmPzEcS2DgHenLVuoOAqj9RGIzRu6cYcCwP9f+8GQxsEGWWzB/M9o23ijON3bfbMR20yOrRiTc3rGY1ON9ec3KOVnKSp5C9tsVU/a/2V+R/MTQnRdLaqh0wKADIEl7kfb6kP7csz712i09E+jWAxIjNS9pa4PsMueV4wqrHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX0tdRKlkLl8BzaItn4ad6klH4mGryksLiW2yk18kQs=;
 b=FbJagMKkEEH5KmievTskKJV8zw/vPIg4m8zOSo6gkTNQyzfQLeVz2qPlJWsPkYe6SwkzMXSMWESwy+LRkBhs+jswkuW1GRTd3QWEMavJkl2FYBId2vfEj1BIY/a88Kv36iKybCBssVe8Y5pdGfQp46rb7sQ3U+bKX94OEwp325noxUVfzs4VgI2l3jmFcMIYq7F0eOx7qPxKejGapFs+cx4HpPEt3Le7sdYEhf1BKaA+C4frkg9P1HSQVaoNBJVOuCe7pjL3RfbP76eIsuf9CYkN9ySEozhmLo2stWZAvmM9wfYhO0V7ql9DXdYY+3Yh2vJJuNfyUkpXCSLiV72YdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gX0tdRKlkLl8BzaItn4ad6klH4mGryksLiW2yk18kQs=;
 b=A+GdJ5DNcdJAI4RUYvz0n6wACZ2l48BtWSUfCQ6L6ggeDDT3zn/JPBPXiDbxzptoFtHVo/byH7NZ2h5UvP7qKhmXEO06mhaW/wk8pq/zV7fm7IeE49Gj2ablsIHIoJ87G1FTvHoumBMxlObmd0i/dvFJ3E/9CalYqk6MTgWf2nw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7411.namprd10.prod.outlook.com (2603:10b6:610:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 16:28:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 16:28:24 +0000
Date: Wed, 17 Apr 2024 12:28:21 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Petr Vorel <pvorel@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: don't create nfsv4recoverydir in nfsdfs when not
 used.
Message-ID: <Zh/4pd4stFgjV7gp@tissot.1015granger.net>
References: <171330258224.17212.9790424282163530018@noble.neil.brown.name>
 <20240417052516.GA681570@pevik>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417052516.GA681570@pevik>
X-ClientProxiedBy: CH2PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:610:4c::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 486e7628-27bb-4e6b-ffdd-08dc5efb6704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WM0ceH7ZNBr3/EH8d5Yt9jm03MPtGOpSrWf58K+s5t0Wek1GkmUL4/atZjbvlMi4bpJQ5R9WRMm9GQJzRpiJ+q64fEVP3Y7V+nXePHuaoQTr4OJONZfxHRNw0DbbCqg/k9yWuJgPO9pZ/J/2cUQVxx3dJXiy6ht5JnErcpFEd2HH174Gyik7vcto695TR2z0PRSma9/seLZJ4UjBLptG2zGl5ne3UBhHS7Qjw+NP16OD0EJ7ACjHiYVtNZtlg0v5rf0LKpiVI3l6ogFCj4RiSxEwW72afFIaUPUCjYmcrJmuVtVtuqj34n7kK4vS+TnczVuT8zj9K5/sj6pjutGm4+vRpCPxP12YkZy2k9IZuDjbcjjK0B/jJLZm4FB6cfSq6DbbbjZPJQiicQw33KcV/zSCgjyTmPS6zm3RnzbA/HUfINvyLn26QMo8cQpJP+EhTy1OgZ7G9ehGTfszj6ZbskZUkdOAcwdOlsz99oQ2E+6AnKUEe02FEc42i5wRKBO8cYOylJCcgV0m3iTPlM9xKbqkb2xGJKbw8zWB/CV5vsbSHaKO91FF9ZoVwtabUc3CBBnxVOA4yDSgU/p70bzCzx1FZHvQFVMwEBZX16BI1x1FgvErbsC9c+ISXdJANppTEMNw2PZ1QkLj5QNsm6S+1+0zUysz8FtG5+Y4PJtZsoo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wv/+pMNIgFJsyMLGutDP2XR7PMQNVJWKNfEeBypRWG7x7NX0D+0ZE+t+ZD5r?=
 =?us-ascii?Q?wGpy6TLUXSk+tQDcdGS8IBqQA3Fzk0uUz3Upx9sgHao7ap/gZ7YOQoNvfrkv?=
 =?us-ascii?Q?82ub6GDLcDYRUkcooJg4COXlrzlCAGcwWWGLfV123pOPJQehMrguHEXJ9/mq?=
 =?us-ascii?Q?0iR2zMeF3F8Rvn2m5jRQW3AUHvVemx/0Pp2If7VD4s97WMTQ/kj/Pik6iEo8?=
 =?us-ascii?Q?jnoCa1fRT+WNfUEnNrfAs8Orzvyx0YchlPtoSSeCZZ785PjLjnDxeO4G8pqk?=
 =?us-ascii?Q?n7KHXEbneRGlwiVJR8poNgL9OBa9Ut1OKhtvIbc+PEOYTaaXxP/kB+RzQh+w?=
 =?us-ascii?Q?nxkY37fabldGLPSX9oZb+0JYyv07/MaBym7DBQMAQCJQgS1lewdN5OypoTKu?=
 =?us-ascii?Q?cab33HoEmNN2RnNjXXBBh+B0feJiL+NjvRaDoXdMMzExUlyQrE8QoSuPOGgB?=
 =?us-ascii?Q?zDbiGEoBA2/eMC/QCpAoJK7W4zY9kKgmiDcZIKLTVcRh69dlHIKVIeOm2pk/?=
 =?us-ascii?Q?UGo7/wNdhBD1O/AFJmDmY7AeYy8fWDoWYJvP0fXOIHg++wmE+GAPd3EK78gO?=
 =?us-ascii?Q?SqeCgTUjREG9xO3HzbOJr1zbESK7vDOpjJKL1zcjuiG4uBhSrThaU7gGpKQ0?=
 =?us-ascii?Q?Yqtqy8EuKSr+g9ULSS3OAKEwpQKB3MZzLqVmxbvwEayyrCXG4CvRjyn8R4Vw?=
 =?us-ascii?Q?ikHlfElBXOd+yK0aZ0UtUdZa8HOjAZhO+UGMiaAgoTDXoa2Nl5byQZfiP0jV?=
 =?us-ascii?Q?bNCTsO+EQxGarJlQsHw2xwB8mR8OgJd9PlnaG2bScoqkY2ykZK5DO855ILaB?=
 =?us-ascii?Q?3cvJ79wbdcPqHBfo3gTi7t442xguTsBLT0pngPPaK2S2tS/Sv0e24NbZOzP9?=
 =?us-ascii?Q?ESoZJpn8L/loFshRELQznA+nLVp0d3zg6HLmv5w6CDPFAdTRIcQymXvfZWG4?=
 =?us-ascii?Q?PcgMPbJDUy9uQB4krH6fOVq4VciyyRUsi24UxnkmrtBL3rM+0bm2/64tQ1PG?=
 =?us-ascii?Q?cbBIODUJljFQEAZgobGOYP98vssVN9hAgDx2J6fZnd8qGoZxoJUByT37bL43?=
 =?us-ascii?Q?ediJrkTp4lp8ksRdXUiQLwv8W5E3+miqTN+1F4/+CbSeuiUXxyw387U0hruy?=
 =?us-ascii?Q?vn++BPpQsZdOjZrWu4/oKB2IpbIzwxoHycONSvc2jwNr9XzKJF1ZQqxqBH31?=
 =?us-ascii?Q?+lemWx/DklnVpPdSTQRtjX/rmpuoCsa8cO7DZoEnU9S79fxya48qOLQV3dke?=
 =?us-ascii?Q?sTpaFTSY/w1dC2JD5gS9ypVOaYnPveTTgswkRtGy9QSCsvJgP/70eU65hIth?=
 =?us-ascii?Q?+exs0SEVZQDg+oHDAHnNnQwBjotlkGhD0CDm8QyVjk9+7SGujYiZOpt457tP?=
 =?us-ascii?Q?kyGsZerwVqJ27KN3hiRsggDXM9XP5kUW5GUn8kqmohhK0L9MjGBjJPAIVnjQ?=
 =?us-ascii?Q?ufqrvQm+hyzANo/r5JQJZ/dODRTbbFyEijB5D0eporutYfiIHdvcnC/DVv+r?=
 =?us-ascii?Q?kRyVA48HvMWs3TsSYpigGHvJeQP6vCo80usq/FFo1e4WUeu98WQYE0gKWU18?=
 =?us-ascii?Q?Y4Q76y5BNAM9xPjBJ0O3ZsuclLRU4XjoGfgqME/HDFQqUaZXeM34Xe3KpSak?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	a9wInc1tR+l/YP+hl6RGhoQI7CsWfibO0GNCoIJqAovCZGTZ+hDz64PYI/+6qiC7TiVDK+1NAMb8Nx6O0SKUYGJtQma05aODcYlKBsxNXJnJ+J7ENbJ4K9X+jzlbyB6EUCTmd3qXtcqa+mhY7ycHVurZ8GQwgpBmIWpYBBQTEQk5sa05a3GzsZ0WZ+iMUD+QNnjSe7FvCuA9ZqYyoqqS5URY9BlGn2Qna0WEDHGvjUgcaMotN2nS5Z5C2ZsP0FmSyDMI52E+ltniMy4Nj/l+hEyDNSePc025dSJMGHVTCvZwwB0lcbqt5a0hm3NHJJwKDbp11PgxpaAP/OYxbcLNyZI7ov6UwthqU4k/2uJ01md7qxStVWZ/h89KQdC8II2dRKs9cNvV1gX3qayYFtpxW65skmnQA5wIi2jKGJ485kG9rqC1Y0YwPwN5ujBw3R7DeyeA0CeeOHhpupiTefxd0pOErTV0JHg81OxXDqwxvTLSzhRodND5xs26FhZu2rBDF/0ONN07jJOnN9MZY4aVT3mkKFi/v5SKKAIziC8RQ3B6AQlcd7BJGfIVto8/M1jctW8Ifxhnr5U7SzOQTwwVG3FNHoa8sHqL6mFEYWQ0aWs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486e7628-27bb-4e6b-ffdd-08dc5efb6704
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 16:28:23.9815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHe/siZx7fMaQXK3fLiQS/e+UkIbUAVhi/cqrk2wRxt51UQquM+xCTBXCmxfDFVavp+5a2cB6EoKQej0zl1r1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_14,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404170115
X-Proofpoint-ORIG-GUID: XvzkjYcWVV77e4dgl9Dcwfj_7YaY_4Ls
X-Proofpoint-GUID: XvzkjYcWVV77e4dgl9Dcwfj_7YaY_4Ls

On Wed, Apr 17, 2024 at 07:25:16AM +0200, Petr Vorel wrote:
> Hi Neil, all,
> 
> > When CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set, the virtual file
> >   /proc/fs/nfsd/nfsv4recoverydir
> > is created but responds EINVAL to any access.
> > This is not useful, is somewhat surprising, and it causes ltp to
> > complain.
> 
> > The only known user of this file is in nfs-utils, which handles
> > non-existence and read-failure equally well.  So there is nothing to
> > gain from leaving the file present but inaccessible.
> 
> > So this patch removes the file when its content is not available - i.e.
> > when that config option is not selected.
> 
> > Also remove the #ifdef which hides some of the enum values when
> > CONFIG_NFSD_V$ not selection.  simple_fill_super() quietly ignores array
> > entries that are not present, so having slots in the array that don't
> > get used is perfectly acceptable.  So there is no value in this #ifdef.
> 
> > Reported-by: Petr Vorel <pvorel@suse.cz>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Fixes: 74fd48739d04 ("nfsd: new Kconfig option for legacy client tracking")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfsctl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 93c87587e646..340c5d61f199 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -48,12 +48,10 @@ enum {
> >  	NFSD_MaxBlkSize,
> >  	NFSD_MaxConnections,
> >  	NFSD_Filecache,
> > -#ifdef CONFIG_NFSD_V4
> >  	NFSD_Leasetime,
> >  	NFSD_Gracetime,
> >  	NFSD_RecoveryDir,
> >  	NFSD_V4EndGrace,
> > -#endif
> >  	NFSD_MaxReserved
> >  };
> 
> > @@ -1360,7 +1358,9 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
> >  #ifdef CONFIG_NFSD_V4
> >  		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
> >  		[NFSD_Gracetime] = {"nfsv4gracetime", &transaction_ops, S_IWUSR|S_IRUSR},
> > +#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
> >  		[NFSD_RecoveryDir] = {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IRUSR},
> > +#endif
> 
> LGTM.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> 
> >  		[NFSD_V4EndGrace] = {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO},
> >  #endif
> >  		/* last one */ {""}

Thanks to you both! Applied to nfsd-next (for v6.10), unless you'd
like this to go in sooner.

-- 
Chuck Lever

