Return-Path: <linux-nfs+bounces-2678-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DED489A438
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 20:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A471F237AC
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB46F171646;
	Fri,  5 Apr 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AI8FLxtJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YkHXENhn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197F1CA87
	for <linux-nfs@vger.kernel.org>; Fri,  5 Apr 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341971; cv=fail; b=MNdYchVd7H/DvlZ3uHzjDBf/AhSlStZtR4QsSmeX5z7a03G0oxuQrAKpEXxJ9zzOJdgM/gYKC8yCIkptSgk/yY62jzUFsRt9yElQ9kW4Taa8KMRGDdYByF6Mx9T8CumKOJWtEZoTCLMIwO0/NmArLMzYuws7iQeAyEWQtlvk/b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341971; c=relaxed/simple;
	bh=2NTQdCzGyAWGsFzEx+3RMWa8yG9pteVtZG08qSOZfrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rWrYiZu6ppkenPsPzhb+Thx5WhmGn80JGg7dGMCxEgNIUvjWW5DdSuyTX7zR5LN3/ydQRIbaYEgwmj2+GVRb0FBsExE5e9rYwI9WVPGJeklbXN1FvsucILaSPKYFHqBPdwfdWAcad6kPBckp6rqJPcq9JUO7gBxQdHQ3d7DBweo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AI8FLxtJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YkHXENhn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435F3rHA010395;
	Fri, 5 Apr 2024 18:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=C5Xb+h7VJnDPcDww/Dx5FLctQaqjcovqc9C/i2Eu81c=;
 b=AI8FLxtJJGJ8YEJVASvum5/hRm/s78e5brrFw9yCh7XNdx7L28p7wmR9bcJalPvgjZDD
 4XLHDuuXscje/EJKIS/benIKxHcqVzD7Wyrt0GlYyWZxA6ap0MzWITtNQxjsncUHYyHO
 urmH0gQ4F9XXARZLg9DlV8szk5HWOo0U+pZ98mZZoCs0eUSAiiJugaOmFRP2oe5qthmq
 UambSnC4xsiUc0Wfqae8P6KSgPeubeM0aNrFrBNMfNbpS0emY+x9jK892b807INyF1oB
 SzBWFkunLP7N7pqsOQKtqXBgEWEk36sL+dH8x9V7LK7O/gXR5Us6Qp3uzvNeGkFAEIgB qQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9emvv5x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 18:32:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435ISVuq024253;
	Fri, 5 Apr 2024 18:32:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9empggs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 18:32:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEpziQDOYCtU1aXtrKdqNQ6x/VQHKT9L5n6i8tW5Q3csSjZnPL93kBj/1fiyjNmeRaSpsubNDPn0dBG+eKohauRvr5qyHqSpUYFLO7UUiXWHLmIx9WkpnJfnU+V3geCgx5f5gnE+VFOuyysvCsXOxMmvUJYgq/38vJe4WFAagtDv/+G+WmsIpd1OHuiRGdmdVdxXWU15HZr/+mzb5YEgjqFbheWQ7BU/k/60x7hhMf4wpWVMQj+5lfixkZCkzYhp3pc8RhqfW2YbNCYEUgpD1UGJj3UP/eN7j6y1cvxVjgBF05GBNCEAru8hq0HEeAa6vnmOERLHdJplvnqwKyb4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5Xb+h7VJnDPcDww/Dx5FLctQaqjcovqc9C/i2Eu81c=;
 b=Pvhwl/s9uspZI4Pg3NHlvpeliK8mgwD2LzkJLqRFy4XPLQeij+nI4sYH11VPLZmxjpNNJITsip34hsAjJd+Gf8aApJzhboBYBI+uWxyH7qnyWlLO/REydjDRRRH1wyWPr+HZHjaSpeA4/9VUP4y+Xg+GFZBm2t+SQmQxJsdrEkivczbxwk/EjHJHu/VqkBrIuWtDHX+nSo9wFykWw1aCcYSO93txeFG01VQj7EJekbeFyRwdx9kqfJG4g4MinSa620q7gxrAxnzX0KbTF5N1ubCIz4JhZLkyvzvNCjfaFfeZwoYKwsY4kPue1GsUJPvtI03yvAJDyF1IAvGMT0ykSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5Xb+h7VJnDPcDww/Dx5FLctQaqjcovqc9C/i2Eu81c=;
 b=YkHXENhngZuO8TtSpsnk0rMc9Mhan3xtUMi/N84u1tjUL7mdx4j3hVBaOMkpCW7G4UNey4vkCEcoSSPSTH2qGzG1gY4dRm6BIkVOv5Dl0GLVR4K6uXCShcrO/BkRn/vVLA3Ilrn3/mZGthJOw5qBL8wskYrTaNpjgn30dnN0lWE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7343.namprd10.prod.outlook.com (2603:10b6:8:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.47; Fri, 5 Apr
 2024 18:32:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 18:32:20 +0000
Date: Fri, 5 Apr 2024 14:32:18 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFSD: trace export root filehandle event
Message-ID: <ZhBDsqxNnj+b5iRg@tissot.1015granger.net>
References: <20240328161654.1432-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328161654.1432-1-chenhx.fnst@fujitsu.com>
X-ClientProxiedBy: CH0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:610:11a::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7343:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3mkLL2jAu4TTWAGVjoksouddbk0KlJmgsz/8gw4PfvCkiH2WSEmu5LUO8zVCAYBPy5zPMEMBZzBm56o7NOSk+zyPDQ6g2s+hHaawrBt8Kf9iNhNfRkh9P+J8GZPlXNZRqVmheBrlasyDc+befzwV/jeC3DAZEQHp3esfHTuLqkzMpXwiNlmUdZ1k6yud7C1uZ7yvHHSEtvDiwdDsYSu8FIb1MQXIENgEqdJ7KtQFqYrFhy4KRAGz5ErWP/xq3OrA9YVle467U0kSf4A8N6lG270bzF6yM1ahaaIqKfbnksL/A3CMJIYo6rpzUYqZhQYweuCnt5AbzD90tBQZiRiHYFV488FPINAoyUvGqttQSUpaCWS95pY8m2qDfzTVxMyrCucdga5DdpnqC0hFglTXd6Efq1u3+7zHCITlZXQMOnEhNYomFiSVPqlBAZiWvbv/Q6MT+F6gjCH5INbnVjrJOdCVB1ydsS4hRpS1CV3Z9DWKmyPWt/F0gtjl5hqErb33pdSgLz0m6G6zb9GnH7iwpT04eWzaEcncBKyQ9FF549q37DQraoggJyRVxv9yggZM3mBLbAm7/LcOzo/8UZ8i5v9buFe5lhJB5hGQ/8g8HNslUHsJi/pnKwB232l06lrBmj8xcXYCTMRceP72v5zB8Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eCey56/6g0GGEDT3zepxDcI7J09AMMKSTgsPqCVnLbzL8u/69nYYHTFYbBIm?=
 =?us-ascii?Q?fHlOMzcUwWAC208q3Ql863tUPMvGdbd6ZhMcNxt5pLNlRZa2h4FxnnEcfqFm?=
 =?us-ascii?Q?+zxNoHxgxxixNnX5pidqZn5wXw01yMSR/X0eSEHCnGgvt3tAJ5uHeDmORCSa?=
 =?us-ascii?Q?J6D27M/1+8PiuNAUVw8bVAUdOgKuFDqxcC5B8LAIOiT47oLTVZ1hCM7serLy?=
 =?us-ascii?Q?hvHr8JisxcbjI3JRU6MVkxw5CYFtnWiuxbRij/vfB/HlzLKnrpNK3c3BNh2D?=
 =?us-ascii?Q?pseoeDbf4lg4phVmkiLCwSxk3w80mn+g4a+c81eQ7gh6r9LAvdK5xO3EFeFE?=
 =?us-ascii?Q?k7UHJZjsx2AI1vbpbM9UDN48/lr8DPaHtXg0IFekVGfGBx6X8Z5a6oR16+y7?=
 =?us-ascii?Q?T/4KzMYHUQ/l6KKP1gt/mD5bu8RjgnL6t2W7zEVySxFPTi3KgYSxAkM6khLk?=
 =?us-ascii?Q?IPETAO9tVdvkUr99cRR7uPkaD5K1aKdxQ1T9qzY6MjmvbmeISXedlxPFL1+l?=
 =?us-ascii?Q?NY5CaP5F0wXzlNdbKCX4ptjfMUyorBs1y09rwIYF4UnLAk5LdiHmucWyNvn8?=
 =?us-ascii?Q?dcUZ7Uuhyx9da9IA4BeWrQbG0+UnuL6+EgL7CYL3FUaZxKINYBoKHHl+KbbM?=
 =?us-ascii?Q?C4y75sZdYLqPwYtiTlU+B9PEh+7wR092uU58M4VC1hKjyHApoSsoWDOvL7to?=
 =?us-ascii?Q?bwbwA501bQkpX9uga9s5LWDRZdMfQe+eoWsd6RGOQfupikEpWhdCfSW0fcUg?=
 =?us-ascii?Q?vbxHqwxK2fEe8Ztl1u/+iukOpOT3iIhx+eQnvQBO08REfcdrA0NMBiDfPNBi?=
 =?us-ascii?Q?UgwV5qLXIp0rzIJ/7JloTQMdALxwFGTSSv4dHCH4DNDzEQYiFOk2D0nlHLC6?=
 =?us-ascii?Q?VfoA2R5j4PzrFNOVpJEquo3a8fgJ4aInjVaaokM2CXtwIkoY+vvX4dLYy471?=
 =?us-ascii?Q?KYD72VbaAZjmz5J7k8n0dwJwG68zWxdNDAtWeuFRKKeWnXW5HiZD4Q+JSS37?=
 =?us-ascii?Q?kc9k/p7Tmn0hR3CIkxoHjm9695BXm+1f6McKYhzDkZIjXcTJvaTqe/dpsS8s?=
 =?us-ascii?Q?lq5kiUnZjGNOX/eI8K6ZRcfwQzns2WzDgPk6JmAiD6NdsEx2mgiJbZ3cnqcL?=
 =?us-ascii?Q?WAiyHajUn86lIvuslMqTG29YrYiR+gdlXpnH5zwW5CUg3nYmDYkdzmiVn0bk?=
 =?us-ascii?Q?UiUpFq3YQn9nnLB14FRKtFiuonDMls9dBiJ936BFoMAUgWEM4BkdUy6w0Wbe?=
 =?us-ascii?Q?Sd6ZtCLQf+6/EEujAvmXACWC19M+5j+8Jdqb6YCuWOaqqpSRD/T1Ovk2G4N4?=
 =?us-ascii?Q?8sPiizje6n7N3MhAVXWAtRduY/QwzsklkF8Kt5uRkzpSi2/vG+a+kw1vppDt?=
 =?us-ascii?Q?T6w0DZrrf7OLUW1z4TtMvPn7N/pornDnqSaIDMMjeQT58Xn44R4DwXbWlQkn?=
 =?us-ascii?Q?CTHblwxyTpARxjfOjJiaMfGrgtUH2xYqNwJyI6aD/laDLDy4r+LNlOoBtP4+?=
 =?us-ascii?Q?jwprtaIByjEIQkvNZtMALrGLfDrxfK9m7SdXkACOQ7j3c86rkcicqtaYIF6d?=
 =?us-ascii?Q?O4ZRpLwjqmRjsCD+cNtmIFtnTVrUXqeztoeZ9zfk/DilDmK8xO+WDnO+FULP?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JuDTa+9UTEU3kDiWmrZvx2HMwbbkHJQGmjSgwNC9ZNRWBFbbHUFNMOqVMUMpqBOPcCmvOrOLVFKvCVbuNHE4U3Bi+KHWbikb00MosPdLdoQ9bNI/K98xUTzd6RJjIPFb+yemExMVAXFZJYzWPDl0QJ5SWRLZx8AJibNM5IPfW83LXGFuwhyFRtZ+9074j/pF3AN/NFv5a6Wdal6bTvY8pX8T4ZpjIU+BsxASYe61N2Mn9iL1pCQTuQZ+Sl3fc+hdCrp5HhVav9STtJYosJPCos4IRu/tsnuMBZWpo4XgGoSe9p6kp4SOzfXN6WS+nDUwLiN6HWto9IKStdG3tEO9QGdMSfaghPfu314S1ShkIWeC95djuiExsn9KzUAusuLOl/C6krhNGcTpTykUsfkPKMhC4eloMzCU5JRDpyUT9nMQpHofrq7v1jpO1EBDnaX3HOJBnDZUowgA+7t+WdLxlNyUfPSzE8m50PNxjd3d1DHpv7BXvl1uK+ZdrBNbQUdsiM7eLCHPYTWduSEqmI9Dy3vWfK0EL2alSNrMeYT4cuerQ074efACI7MqmkbT60dqFzl/WifKSF3DYGHFGB24mVsWDCzZFmXNl2kWTi1D+fY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd4af90-3fdc-407f-b2c3-08dc559ebac3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 18:32:20.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSpHidHwQyabjPvtvsafmtP0bhGfYoFAgP9AEcxEbcujWE6IFfQqPnOw367eD75gCMdSdDMTIOQ8pak2b76tZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404050130
X-Proofpoint-GUID: IfBTaACIj4onxmMkBf8fITR-Fwroo-w-
X-Proofpoint-ORIG-GUID: IfBTaACIj4onxmMkBf8fITR-Fwroo-w-

On Fri, Mar 29, 2024 at 12:16:54AM +0800, Chen Hanxiao wrote:
> Add a tracepoint for obtaining root filehandle event

I've had a chance to look at this more closely. It turns out we've
already got trace_nfsd_ctl_filehandle().

So let's only remove the dprintk call site in exp_rootfh().


> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
> v2:
> 	remove dentry address record
> 	add netns inum entry
> 	trace ex_flags
> 
>  fs/nfsd/export.c |  4 +---
>  fs/nfsd/trace.h  | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 7b641095a665..63acd1564eab 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1027,15 +1027,13 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
>  	}
>  	inode = d_inode(path.dentry);
>  
> -	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%ld)\n",
> -		 name, path.dentry, clp->name,
> -		 inode->i_sb->s_id, inode->i_ino);
>  	exp = exp_parent(cd, clp, &path);
>  	if (IS_ERR(exp)) {
>  		err = PTR_ERR(exp);
>  		goto out;
>  	}
>  
> +	trace_nfsd_exp_rootfh(net, name, clp->name, inode, exp);
>  	/*
>  	 * fh must be initialized before calling fh_compose
>  	 */
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 1cd2076210b1..adac651e398d 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -396,6 +396,47 @@ TRACE_EVENT(nfsd_export_update,
>  	)
>  );
>  
> +TRACE_EVENT(nfsd_exp_rootfh,
> +	TP_PROTO(
> +		const struct net *net,
> +		const char *name,
> +		const char *clp_name,
> +		const struct inode *inode,
> +		const struct svc_export *exp
> +		),
> +	TP_ARGS(net, name, clp_name, inode, exp),
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(unsigned int, netns_ino)
> +		__string(clp_name, clp_name)
> +		__string(s_id, inode->i_sb->s_id)
> +		__field(unsigned long, i_ino)
> +		__array(unsigned char, uuid, EX_UUID_LEN)
> +		__field(int, ex_flags)
> +		__field(const void *, ex_uuid)
> +	),
> +	TP_fast_assign(
> +		__assign_str(name, name);
> +		__entry->netns_ino = net->ns.inum;
> +		__assign_str(clp_name, clp_name);
> +		__assign_str(s_id, inode->i_sb->s_id);
> +		__entry->i_ino = inode->i_ino;
> +		__entry->ex_flags = exp->ex_flags;
> +		__entry->ex_uuid = exp->ex_uuid;
> +		if (exp->ex_uuid)
> +			memcpy(__entry->uuid, exp->ex_uuid, EX_UUID_LEN);
> +	),
> +	TP_printk(
> +		"path=%s domain=%s sid=%s/inode=%ld ex_flags=%d ex_uuid=%s",
> +		__get_str(name),
> +		__get_str(clp_name),
> +		__get_str(s_id),
> +		__entry->i_ino,
> +		__entry->ex_flags,
> +		__entry->ex_uuid ? __print_hex_str(__entry->uuid, EX_UUID_LEN) : "NULL"
> +	)
> +);
> +
>  DECLARE_EVENT_CLASS(nfsd_io_class,
>  	TP_PROTO(struct svc_rqst *rqstp,
>  		 struct svc_fh	*fhp,
> -- 
> 2.39.1
> 

-- 
Chuck Lever

