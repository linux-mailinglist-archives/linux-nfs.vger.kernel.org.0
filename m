Return-Path: <linux-nfs+bounces-2730-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D825889DB48
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 15:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8D61F2167E
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65E132808;
	Tue,  9 Apr 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQ+91pLT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="siCQA7Hk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7419132471
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670575; cv=fail; b=aokuQZWt5IgES9VMPw+syyR07/ryQ9m2JB3BCKzWJFtTQFB8IwmjAOiB774BQFnrgO7olaC2TFMvxLqQW4b23SzpKjdHh7WKw5aBS2UcKgxMcnsMp96omuKrQKuBgj8haZvQbCpE50azPDF9TmzKqSwwS2KQJA1nH2Fv5ayjx64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670575; c=relaxed/simple;
	bh=tGPeb4laVISQWFVUIVyZWrELsk9mzlb7OVbC/t+Hi9Y=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=Awec7EW5HygX829DNbdOs3PH+Z2cv/6IS2XeQMbdWqHhfKKH2YOpJCgStC50toJofK3Ya7UJyf9FpHvl2kvtO5c2rVVTwqecb+mbWTJR/t5Wk+kh/ZjSLoy9E0FseGDM1A3r8qO9RhwYIXsSdK2tRRXb/Oado/+AbOFGW8OmZRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZQ+91pLT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=siCQA7Hk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BXq3s015217
	for <linux-nfs@vger.kernel.org>; Tue, 9 Apr 2024 13:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=z/P1YZL2WdU0oCdjAZegJHkrEqojFkobjtDSP1qttVU=;
 b=ZQ+91pLTZy4JAPb4+ikXPp1feoy8rWH3Ngnp8EATpMRK01C3iKzXXUiVnMomuV9ihZBQ
 cBJRniCT+0+rb7l7QQoVBdoqwqZ51yaq1hqY/s5tgR6EpUfP8ZiJhYSIyc3WX0IIcZSj
 4ZOot5e1SC2GvqptqLkcZfZLpOcLVQupIX2es5cJdbAVO3rbotP+vg++W8lvqr++RifZ
 lMFMz63AYV9KBxaXxOp5cJxJY6fhNqSCfatp3ZCTCssV4fXwfJVP1iabTX/c2qr5hEnY
 W4x07wOiP9F+/66zRXsJupJFAckTcGiWmwJe+aODv+XNJ6dIlr2DRMNb6mgKeo1TR+ra BQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedn2a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Tue, 09 Apr 2024 13:49:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439DML7L010595
	for <linux-nfs@vger.kernel.org>; Tue, 9 Apr 2024 13:49:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu6rj7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Tue, 09 Apr 2024 13:49:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5uwh2mozIWnw66EgdJWZe/puyFvcxSka0fTJTi67EgtEbwhQQhTW30PFH0soPBIpAGSj/HbEsYgkPPlssJcyD9DZIEqV1KXOQLEFG6MVQD2XdNR/J3/hlYFGPCLixaPHGH6XrrTwnNiiUmll8YJ18KBYRV6HKTGe0MkZ4m9A4eKeRrxejCyn+TgcPlfbepx0irme2xzfItBiFSQt3/6B9hYGhSp/ByvJJlKFQhb4KjsUOOMRqh9A3etTCfbPd8A4S507UYUNZMJaZWUO2vZNqg0hBdu8ljGPz3Dk0PpmJwibjPpVzYE1miP+mKAT1v+zHJo/WOLWMalOKkr0BKO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/P1YZL2WdU0oCdjAZegJHkrEqojFkobjtDSP1qttVU=;
 b=HfPS8laqmowqz9IDvRD3c3UDEG6D89apLqCWnLaAMsrNwCYpzwQ1aDvWXEbfjS0KKzWx7Z6zwRbgSoviYQB/HzWnTI2F6n3/9NJh0lhkrU3gpySvxwLo0J7WY7mssZ387/rp5CtSWOHNPREygr9icNzrt2q400LDXHA3vySKgMqrWMf7KJ0H41LjMpdsnFP4MaevV+34svGiv08xzqqyZy7+K5mpQQXvsmyBFMKSW5Q4D+yadVdNrs78aVZDRgw06N28ynkklqvepx2IFKdaEsC6TUV1Jaxep0P59ULZNT/T65V0mKOaK37fZxVScH6KWwrF8Tj0r44eVkyHBuPw5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/P1YZL2WdU0oCdjAZegJHkrEqojFkobjtDSP1qttVU=;
 b=siCQA7HkzJ2s4Ew/BXseCa6UM+8+u6y3P6cXtIYNczapBHutKJOQ6xkRoNZr12IFPDrpbDxGtmPSNXRC/p6OfQIa9/XIx5bHN0cHVTQU2NCa6qlE1mkI/MqwPGXerI5BpfDp9tkRkkLjP8WE7kPovl4LAUtecQ+KUTqEho3Q90I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5099.namprd10.prod.outlook.com (2603:10b6:610:ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 13:49:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 13:49:29 +0000
Date: Tue, 9 Apr 2024 09:49:27 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: linux-nfs@vger.kernel.org
Subject: long-term stable backports of NFSD patches
Message-ID: <ZhVHZ7imD2s86seC@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:610:e6::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5099:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fRA0FyWxasBXL12p0VdWzwuV6cvxEVnFf/nEzvh+mkjkB2L6LozM28fuv9BGnz1nlDNbl0CjibqHmZMGmjHOx85xgtt9qkyzWDBWBAVExJ87k5kPmx+Gs1pTS1rzD0r1O6d6A4THimRz6I+cT8o4Ax66q09R8lk2nYH34Jha0YCP5OFhLN6U2+F7ahe2IFZ5Gatwqp0VlDqyjarKufM/jd0Z4KMQZebb8L4GhE1sYDXdwqt5UUDCg5U10wjrxMzr8Wk5Wncb1t0v+ZSerbikObBn7cCH2mF9ai/8anbeBe6oqKDCAswOr0ARNO6/f9v3mSfqVbkTdUN+oEXi8QaFOTdMVkFTqM6xAOfSMomB5Q6V/UrAfm0oXCUouP/zqdt1WNUNsOzMk0V/0TIAP1KA+67ybga4BgwZs/39AXRv5JrwoqmbFNCmKPI9Dfb6Ilg+C5aHGykhnX+v0kLYjPguwMWkTpCrYVgqSGr9wFbc9B4yjpvSKjKacQWB9sUaAvLS3Y9RhMR5CDvLt4n70b/JA40CZlxaDYl5Tl8UUf1p3/r0kxYToRpLLBqQP0iu2mZHmyC1/YKTkPfZqwqSEQ3MIZs2wIibAsY7WAqRuW9axL6lL72NecFjypOVVEfAFfFnUj4NgEI5QJfQxknDeN6Go1+kmNlbD0HXziNRdf0fZqg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zX+5ya3chxcAGWz1Hg4IG01Xv/heMp0/VTAMCHLJC6RK89w6NOPBKZ16GRwC?=
 =?us-ascii?Q?WumHn1qI8qXTOVUhTfArKf2FNv54MWIhms6PHTeJmUdSdoOc6NZKekaWfK/I?=
 =?us-ascii?Q?qeOtv7+2Vlc2ERlLV38Uqmsj/BfVjdFoXrkU0arqKpqP9Lh+0ttRJtA/CApP?=
 =?us-ascii?Q?PZ/c37nx8K7zgMVXmFmVqpXURjqFwEn3soHRVttLnX3kBKEegZMojxqu2Fdn?=
 =?us-ascii?Q?UFKnGAmdvGEptaIYIou+PgvTMdwkUd8IWshiQLQDloEOxXPFcuhHwo2+B/Ql?=
 =?us-ascii?Q?3dUpPOkezZjvhhKlSvtM0odosa1594vKTDC1tFIuQ3dXPVn4urzGoqVku9sa?=
 =?us-ascii?Q?VBl9YIK21X8pKLocn5W4PUYPlLA1TBBXzbN8BhBqX47p4j2moGw2p0EPnpct?=
 =?us-ascii?Q?n5vF0DXM4Zi0PYZoqgajrRXwICjsL2lcWTJf/MkDOb+8R/4Te14njd9XGm+I?=
 =?us-ascii?Q?eTcPKttn1Be7xdRtVLKclezQTZZve6JrTT7vyzNqYJCRdUtBa4NW/atgjV3Q?=
 =?us-ascii?Q?xJMuLVtQrGUF1FV0H8PbdfGq8V1PgUshm5nt0/jw8L/bnDM8F1t0sRrhfOUp?=
 =?us-ascii?Q?8wjZfD0YIxUGhOxMalirbRKxf80ICgJySfY3CE5ng7ffBEMy/EjtH//Sb33J?=
 =?us-ascii?Q?ilhSs6S1cP7FMGKOol//vUa9A4p7wgwx/TgFmBM6/2Y8fJUXvLeXH4iW5ru1?=
 =?us-ascii?Q?QLeAWKjKNfV/Xzc43QSlM0FfMOQ2yKuGtppLyDOttjCj6vuksSTUyCpeKx8t?=
 =?us-ascii?Q?kzR+l7IbKcuzdHlZhsOKkJkiBqjZw9H3hvtFmJ6bAU/Bgl/bTvG0YgZMx6RM?=
 =?us-ascii?Q?Wsxg2X0/EooXK6j2MkfFQ+HK8ncD59VC/hWwX3NXQyCWdO8GgAWawp7fYxjN?=
 =?us-ascii?Q?BbXJjeTci0Wdq5zzXp2msx89KdvA/J9ek2EDNw/I7D8iwVLoTYGx2oFVf4LY?=
 =?us-ascii?Q?BqRcXaaAfB5+yp685Zf4oQ1khoR8BjV6SpcRAcCTMDCoW5XkewFme6+QEIEe?=
 =?us-ascii?Q?uSwIQAjsREIvzNPe32kM70bP/v5yh2Uc10+lqq0DyzCtlZItnpIkP277y+I9?=
 =?us-ascii?Q?2nR8ug3wPcrZTtpb2SSog1x2RjouxQa0zeUmtDS+/cCzkt+YV1ErLHS/lhpi?=
 =?us-ascii?Q?J3kJB0p3rNBGyMyzlvv1feDGV6P1aa+faPMpYg/klhKnxjQ4NuAHwGj5DMk7?=
 =?us-ascii?Q?x16flHsu3AoMyA3HKIwEphcNfPF+gyhQVvoRMbD8/gvnAyMYrZC7192IOHUh?=
 =?us-ascii?Q?zaKapdF4Gf3zkPEe84me8RnqivKvu6ZROylWc7E09R54/DZ5vNqWNq/jRKf+?=
 =?us-ascii?Q?ay69W4+hM/TE7lQX0ngBJdfjIGhoIoaZ0mi3nA/8ulN6r3xC0XYUwzOU+t/H?=
 =?us-ascii?Q?nX3dm5RiHV9y9kH8Mj0Ma06kMucyc8S2Ped5qsGKKb4bBkl0rIoNrFJ6BnUQ?=
 =?us-ascii?Q?77L71TvSFMrfGsZiN/C66Lwn/tT6NKqUVIEudwqiQXAxFSsbk4+Uim+bIVOf?=
 =?us-ascii?Q?s/0OO58pmQPHZjy4PyUn+mFr4dL8yAA6A7PfaE+6do4DXnqurLTwVEsqMBsj?=
 =?us-ascii?Q?JN3mUw9QyD8dfPBSjU09nToMufsSqahBqFMxTEsbmGaw4PZ5Iy9ynhrLBix7?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VQG2Mh3KvKS/FO7gfGnvNXg/pbvOYcCe9Nm/71EV7qKpcDoNgsP9ZcMWZgNcj1lSxxtDfJaYNDqzkLHXhf3hgLS4yEXOW8OVNPQ7D3GXt0FwcM/3ImjCEyLZ2rFWb23uxsOIq8pO68eIDb25RWLGGGBqXOipQuY1ysHYueFiWW72nXp+N+Vdq7fNTQ3naMeS+9TbkLDkZhaSwJHtJY6kiB9KJuFrygpsqRbMhOFfqL90bzTdgvKz4doCu47VZKrn3pw540Dz/JMwPg8OCvK8AJE/tVZgbwgHrJMDwYKLv4OVtU5k+FP6rophTs4Ezf0xCY1axug2BsCQu1zyd6jTlg2ZwZWbe6U+EcB6jTpB1XSyaeQGukQ8U2KamoYHFz8myEowTeLkHp78H+TDfB3Xfyh6du0jpKCY2Scw6Y9urZzaZue8+7hDWmNihjMQGVMNpG2eGjIL/zp28CKJOU3RumB4kJY+lUbVw/c5HlzvgVY6qs9YAg9mfDcX/LeuSaZxGqIjwrWy5XSM1oGxp1ROyHgzQSIy2T7JSlmBeWWD+ShZB2IVQ/CNn1pHvbvyLfb5+v7kFmk7r73OyU2LcPDnlIPxOMVPrF8gg24assCE+OA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34faacdc-d2de-4d33-8c56-08dc589be0d0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 13:49:29.6558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/yuJOpzqNP437/hQ0F1X4HLC5vg8TR8MMPsJ4DcuzmDVnzjJ6vwT/9qLjLbqjmpQVdr4Ps0JSURWgvZOCJVgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_09,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=940 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090090
X-Proofpoint-GUID: DSZPmURPcwyON4M2LX1LHY_RwNcgBNY4
X-Proofpoint-ORIG-GUID: DSZPmURPcwyON4M2LX1LHY_RwNcgBNY4

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. The backported commits are destined for the
official LTS kernel branches so that distributions can easily
integrate them into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

Here's a status update.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v5.15.y

Greg is currently working on releasing 5.15.154, which should
contain the full set of NFSD filecache backports.

You can find these patches in the "nfsd-5.15.y" branch in the above
repo.


LTS v5.10.y

This branch has been rebased on 5.10.214. No change here this week.
Once v5.15.y is complete, I will start work on this branch again in
earnest.

You can find these patches in the "nfsd-5.10.y" branch in the above
repo.


-- 
Chuck Lever

