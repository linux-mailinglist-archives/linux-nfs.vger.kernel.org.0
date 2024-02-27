Return-Path: <linux-nfs+bounces-2095-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AAE86989D
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 15:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46922B250F4
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CD51384A6;
	Tue, 27 Feb 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k0IFcFcj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LQ9F5Cg0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1FE16423
	for <linux-nfs@vger.kernel.org>; Tue, 27 Feb 2024 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044795; cv=fail; b=pXzDS4btQui7pDMCCDsJiGDRYDKpVCWwE0TUJG3mbu8K/Y92nxQzfA+n7Gt/IbA4xNNICi3UghxRvfiwsPLACw5kbtbTHecgWUgi9NdAUQyeO56CIR/mQDg6R/31qdW6kZYgVymaz4d3Z9pW/jniW59WFwEyXNpz/42X23e0XyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044795; c=relaxed/simple;
	bh=+duxIXwWLV3EGGXJkQUoS5dNmwXlN1y+dU3PRzTUTTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=igPRb29C9f7hndbBB9fgW2KmZ4Vb463jQ8mBFeLos9mrrQk1LlfYUTEeN+vCBuPwFP26lkfGPOcSn/8O+MCYLbVzC7aIOImk0ged7Zh0ICeVRSFwoMYX3/d93ua8R+gKYy4vCOOvvAaUme50yezMWsbJ9lVCdGvDOLvH+zPgNkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k0IFcFcj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LQ9F5Cg0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R9ItME000772;
	Tue, 27 Feb 2024 14:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=CzBaebvMhqZzOFPEvbSvT+o+JIFYh1SNDBJbWx43F14=;
 b=k0IFcFcjSGCkOQrp2y7FG7MtP2wabuPYYGdcmcpcX9w1hRbmsh/6vEZcnJbknOwTg0NX
 IaB6FlTI7iQ5ItNbR8Vj0I8Tbq4COObbeqjmaVODCo1xSfkBpTnJ0yQtzVt0Uuwu2PwB
 jEurVzh2FSrWr/0OYyTzyPLmRYwpOrHCWNMQVpCcbkXBPVECa4lPl2T9bujlrwQZ/Oaj
 1JODmvugSwjD1WzTt/TFAeQMGiWF0iJMA/yUAr+eorkHIH8TfnVaJr8fm+CCIi6JNXsq
 kSjUihgkY8qKLxZN6GGJi0i7kFUbPmhLjFLLZzikXGwPa6rGML/ZtaD9YncymHxmqVa1 UQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784fj7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 14:39:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41REJwDr009779;
	Tue, 27 Feb 2024 14:39:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w796p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 14:39:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pizre77+sfb9HUachbQnslPWi7umPlrwGVVXicSXWdCvqWJfGRjkAu7vktpPheYG3fYXU3bbNI1gMEfjmMlcQP0lVpxlEYJ6OMUOiO59v8YPrTeB/VICMTzpefWDHrlJ+ocDGG2cPcGlOCkqu9Ma4cWGcCtR7QDrktAOF7UonI+w8XMmaG/hn1Ahm3I/Qh54HkkLph2tEBnua0CTXo23iPnRXDD3EJwArGAqnfI9UKx61uy5nIQbM4iWNex/b2xW1dt/JAIsbeQq6m7LtEtFGQsvJlb7cXX/7MjzqoHR7LJ64IcGhNmnifKlASLHNDFKzon1aupY/dBQelH0WpuH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzBaebvMhqZzOFPEvbSvT+o+JIFYh1SNDBJbWx43F14=;
 b=ks/EW15eP7KL+0rxu/b+gFVvTfsfSkss/0YCSnUgiZJjKl2gK8pcN8aw4c5qj1FVUZrYgGTxgNv19BPGfgFOqxi/fciXgqBdET1eSS0Sc2uSw8XAHcn9IqC1O6UH8C+wVq2MLvMHcg7uYzmoRXgwh+DUqxkio1gzCEwsEiLKZMK7xYg/bundIGhgLl2v8aWmjzM9upDXyKYL8kUZlm/tLyI1e8k20bFGOsIeAp8StsDOCCXQidLop4ymmlKCQyjQl+7droLLY9OH4M7SZKHmW2oKkyL5BzeV6MVgdWKnXL2XO0xeBpMnWIPSPMrcrISamIy0RGYx1r9lFoabgEYZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzBaebvMhqZzOFPEvbSvT+o+JIFYh1SNDBJbWx43F14=;
 b=LQ9F5Cg0xItdRBbZZgJ4pLgu1srs/DjUecoOHSDex5ZymERahbZDVqnLz0iZSvbIwNDck7k4FpH3rfGiCD0uArIZTCnqqW87+h+zYWXPRo80CCK7b0fLP+7exFsEtJ1q9x3vORpYbqbEimRKZHsg+9aYbR/JjUmwVTzVjGDkk4s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5203.namprd10.prod.outlook.com (2603:10b6:208:30d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 27 Feb
 2024 14:39:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7316.037; Tue, 27 Feb 2024
 14:39:48 +0000
Date: Tue, 27 Feb 2024 09:39:39 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Dan Shelton <dan.f.shelton@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: long-term stable backports of NFSD patches
Message-ID: <Zd30Kwa8s5qlTRdG@manet.1015granger.net>
References: <ZdyedKSSsIARB4ZC@manet.1015granger.net>
 <CAAvCNcA0KKFF15b9wYTdRcAWTt9udg5K148FoS1MooVANJTKSA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAvCNcA0KKFF15b9wYTdRcAWTt9udg5K148FoS1MooVANJTKSA@mail.gmail.com>
X-ClientProxiedBy: CH2PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:610:58::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: dfaa202c-a7e3-46f4-010a-08dc37a1f22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6S+hnFYI5SsHpsVxqW4r/JOvl9PRg8TYOeyOqbKpGkKAOB2GTZ380miXASlRsPVam1xKkuuakDZLn6I734D0i+spYCPaXt+2l32yLv4SbA2EHWC7zQGWx/CblzKOEpQrhXRsPhFFgC2zKL4+8CYMLqGEwrV9flWMJQQ8hT1jrYeJH23KZ2F4EvftQTEVhtEifzpP9TtwZPzY+I19BjVuuEohiAh2NrgFi+5EdJKgJWHkSk/E3M04d1N7MJ0coqRSeIW3wPy8fcdcXnWZR/y8DgOR76cSiE6j/pRcsOx9hAQa/gev0QO6O+e0Ikap0OMuSD+v4RWxBG0TB977zEObAoma9xxMoYT931KuGKEjhMebOh9Ta0HC0sYp/bJ+TjIs+r4SBBJJdh8e+RQBbUc7dWOrxE/jTbDPdSK9g7Oc9vabIbr5dFGNLX+VfjFb0gI/HnhFa5w50vg4po81Ccpz7fNd+NMhsR5NXXAVv0DXAmWpGJ4hlWqL2anAf740w5sfqaUBSmNtVWLImRQ9JRNIBwJi0RnmXRQwH11ButQOfnhpdVVyOptyuB/znvjE+55L0dJEWNwqO0FK2hQ8tAeoP7OMAeuIFZCFR6JB0yHHyboCfMD6fGH7LADsLCvznGml
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1ntgpA7zSm7iuxUCP+7HmrAYf7nhyVDEWa5CttrDK7Md8loSORd0KzxvzBS+?=
 =?us-ascii?Q?BzzK8itvVK3N4QQ1ZOZPyLYXTP34Ij9AmQa42YlAp/4DgX0zYyDcZpMnrETD?=
 =?us-ascii?Q?MvmS6zj0PWWKdAQ25M+uVj/WXULaMbl/Cg88PTM8Tf18kjOtZtsYO34Hht55?=
 =?us-ascii?Q?igNpmgz7QLoVQJOeK/T55OAlkxfqkOkQraRB3R8XMkcKRn3zgcd/pqV1ggo/?=
 =?us-ascii?Q?sLUYmj2G42zGDWp5ptKliRlYrJfSCZsvx7dsB1280NF/rMxLWAhAceq66zDj?=
 =?us-ascii?Q?dVnnf6khdx4zMrkaU5l1HQOrqOTDXWLoquEBdRySnTAOOY2H2FIEM6DxXHw/?=
 =?us-ascii?Q?gKAt0Hvt/U1BxNN91IqROmnWHwWiiZMuViplXVKFvn9vQXicGji0o5rzFLuJ?=
 =?us-ascii?Q?lZbSCb+OdDXxT0RB/QpnB4+flKQ+IPitjAsRSd1Da82qyrv1pvXWkNya3oiO?=
 =?us-ascii?Q?976/V9Sr2W3ILEU+KpONnn83VFSJgNlBjBqC236zNFH6l5s9modsGrQyar12?=
 =?us-ascii?Q?i/lUw38v5rawHRS4eVNoRnzWtBy4b3kkje6Me9+UmYGJWGsuU6YJSCs0ogL8?=
 =?us-ascii?Q?jfBVNk3r9zna49yWa58Fpw9dlGsOW8S6UoC6yoWJpQe4/bT760zMxtHQyXxd?=
 =?us-ascii?Q?DPjsXJlB9DND2YHmJRvel0hUMGZ9dXGk+SkDIYqGuTfrX90essz3GZz1a5jC?=
 =?us-ascii?Q?yeHzHuPI7oqXKmx39M4p3Rzlve+W6mc6YpiOnsqJJsXNOBtNoC6nuJOP6VO6?=
 =?us-ascii?Q?l8zH9KITEAPOjtk9qTGIOrbvE7Ge+b2Ms7QJzVbntg+d6yuovBj80clsKVFD?=
 =?us-ascii?Q?+/5HGIPc+PtxcgxL4TyFo5uxlNMa1yH8xZu5xc34DAiNm1gSJqJuJcxm0Nvx?=
 =?us-ascii?Q?fPjmW6GbvQQLvSunjP+F2ZfAFRwFgDVz1tfeL1awIz/2dP/fD3FSt4TaneW6?=
 =?us-ascii?Q?upT6ha2El8ccPFCeqC1QI2k34pQVRlRrsNdyS+rdzzGPG4J3ZrQGXryDMpks?=
 =?us-ascii?Q?6kFZv1qBme3KVjKHJW9h2Gw4x4+NQljbiwmvB60qN3r5FYOZLP8gRRdvv1VG?=
 =?us-ascii?Q?vTpJ+XdMo+G/QTU9zpretidvYTvCFhyOrE7kKIVyzSmwVjUCY8m4sIQyGNMn?=
 =?us-ascii?Q?Yehs5ANOj9etm4BtH7pZPlgX74eoplgdwwQbwM+RcI9mIMb7ZTwLZk6r1D66?=
 =?us-ascii?Q?2QQIsvFhc9FXJYkjcvhFuDfOteHtHdKCCqDm50m3TydK55lkEdCJ9qKXw5Wf?=
 =?us-ascii?Q?cdbujVT+UizsFBuoZTmVokEpfmyfheJq/E9KidWWnAOfDDpSnSflTZ2QP1Qe?=
 =?us-ascii?Q?8RC0voZosKqRdhlZCE2p3ay//Lv5O4viZK6LfLZN5e1uOuV+smVl8JxL0ARO?=
 =?us-ascii?Q?DAfN1BJ52wxxZqfnCBplcoBsZ7PzajdjEBSdHINwDft2HYsHTaFHojxtHzXm?=
 =?us-ascii?Q?yBfDJ0qXyx2G9BujQE9tdSoMXiR7XVYDXd1jmDDlQtS0HuzBOvVhoPQndH2K?=
 =?us-ascii?Q?N7NCKtupFsx0+Ena1c/a6ciH5wwF8/IBU2cdgp/OaoLVxPZOPta8alS8zfx1?=
 =?us-ascii?Q?YMi+ZqnJ62v2HNlNYAe4kq8kGoScTYN+Czie5hnxqA84TPktQpoN+pnZTzRF?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HYmMYRngOBsue+Z/GJaUEclQU9wCSPf41kkHEiMqeXWtVxRj5pZUhCH4p6RPk0iHodwudBDktUh0TPlBzvEC79FGQAn7WtgBcP11PeEmDuSN8OjVpGP51MOMVd6TIe2n4S7MNbB9czmDmmNP41z9sm09koLi2t+syMgOM57w+dVWu9sUjjgW15wm49lfd5VlTk9F2fEy8P+XwL2wrzZcWoh1eE+mRM9OcNuLOnnPqaFQ75XXYaQqJCFObddlnalTUGzLYXWqhj13UWC2mCjf/qc5IBbBbNuW119EgR201o/MOyGjSeRw1pzX8+doOMOTQ5W/jB7rpcNyErZxANiFj0D+eyR3/O6FmmDFRQUXxoTCihfTluk/0XYUofmQjbMgRgfA5rsK/10v4QbaMUHnt/t+nAPhkUK4tdYgw/Bs5I44tVF4hlfyivY/dKjcZRbFdEVdWsYMbMXFy1DOnnDb5KCnntzOwqoQUu4GR+oG8kT2Am4t5AhiTiYHHNV2bFGSOJPJHD6MNQH0aBXSlZc4BCj8CK9kl5b6CkKLUlXXbDlubXf1DnaveQEC8KA5e/xw7GJQRQ/0Ni3t33oh8ym/d0EBOr0XUjzN3+7UYuqZDeo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfaa202c-a7e3-46f4-010a-08dc37a1f22c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 14:39:48.1033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9e2vCWi4JDxrpFHP6y9FNy0DmUrR3D9CsQ412B40XHvpZH4CDFZeU8VjrOE7yNzT1S6n5u7YJJT61cNjG+GEVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270113
X-Proofpoint-GUID: 5cFo3J_2grC3PupXJ4HtQJiRuxZitOt_
X-Proofpoint-ORIG-GUID: 5cFo3J_2grC3PupXJ4HtQJiRuxZitOt_

On Tue, Feb 27, 2024 at 06:57:43AM +0100, Dan Shelton wrote:
> On Mon, 26 Feb 2024 at 15:21, Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> > It's apparent that a number of distributions and their customers
> > remain on long-term stable kernels. We are aware of the scalability
> > problems and other bugs in NFSD in those kernels.
> >
> > Therefore I've started an effort to backport NFSD-related fixes to
> > long-term stable kernels.
> >
> > I consulted with GregKH and Sasha to ask their preferences about how
> > this should be done. They said a full subsystem backport is
> > preferred. Here's a status update.
> >
> > ---
> >
> > I've pushed the NFSD backports to branches in this repo:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> >
> > If you are able, I encourage you to pull these, review them or try
> > them out, and report any issues or successes.
> >
> >
> > LTS v6.1.y
> 
> Where is LTS v6.6.y?

The purpose of this effort is to address NFSD filecache issues
present until v6.2.  v6.6.y, having been released after v6.2,
already has all these fixes, thus there is no need for this effort
to modify it.

Once each of v6.1.y, v5.15.y, and v5.10.y is completed and tested, I
will pass the backported patch series to Greg and Sasha to apply to
the public LTS kernels they maintain.

That will make these backports available to the distributions that
continue to use the public LTS kernels, and enable Greg and Sasha
to continue applying upstream fixes to these kernels automatically.

-- 
Chuck Lever

