Return-Path: <linux-nfs+bounces-2211-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C7A87210C
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 15:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7F61F225DE
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 14:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C05585C74;
	Tue,  5 Mar 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q+MK0OTY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LBa8QL2H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C15676A
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647365; cv=fail; b=nG0FdvULtq72tZIVoNLhz5bwztuNtbmb87LbXjo5Ve8cuS1IpsfoBGvnrSbxUfwvduQzQkyyQksqQ+/Wxr8hf+mYrdCU/JfROvtGJCDxxH9nQGYfWqai7tFoGUhoRYv4LaidSut/gj24UPOBmjz2DWUx6bjLH4lfB2HiXO2blUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647365; c=relaxed/simple;
	bh=PGJSKoOeeyQ20flkHhxUYDMSKXgiiyzX6E2La6G1gKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cuIkotEw4Fj5GZQPj/g89xHv32en2cwP4/ypCR3DXhczp6gnrdRzsXvwzgTs7J7CIM5zmdUYQ1hqEIxtbnTWOtt3UdIriiNdQ4GfeWb1Kl1LxOtx8kL7L7j39VXEUVQf+oe/0wFaxNfUwqTlpG+nHBFxu0kvaBC2VfVx7HH4QcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q+MK0OTY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LBa8QL2H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425DaehO027424;
	Tue, 5 Mar 2024 14:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=oW4ntoXWUjcWgtymA91yCD0O50dBwhboZQpAlYM74dI=;
 b=Q+MK0OTY1rL60phBb5vFPd3sVWe1HUlNp0BVf/Dq9MT81sgR1C4Pb2Z3XRUJ1AmvDOIM
 bYxV+WgeKjpEmGYIEL0AHiP1oaTJOWyiD2HFC0DUDydDZrR9oRJ3f1F527hVnPcWQvbA
 +HrciZcjd4cXNSKHTd4k1RQ28sMSFKChV3t9XTAB+WMvuERmlFtQNajR0WtAaIV1VU8b
 3DdwoUMXsDv7zGoEVWKfk8cO48ceLcabgUEs9cn5mm26jTdhTmUmoL3unaqTjKQq5vuz
 ieXr7rHGDmjNM1OLdfjcdNjZaO62FpkZMGJF1XOQaLKL6WJVr0nwD3/nbEaONe7+tmdf MQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv0be7pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 14:02:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425Cvat6027521;
	Tue, 5 Mar 2024 14:02:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj83d4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 14:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGYNrOjdXS7hsir0F3PUsur1rc9YSTnfBeBv2y51PZqGZTe8X/bNi7UYXYnVAqa9a+qQMZef3oKukKaipN8/xz/WWrD44WeZUcNWGA8gkq8atrWdIxmfccmeAUOfS7++da3JkElYti7qoAmtOFq62tTyJoMOo+76pazfEAY/0Nm++xpm/px586/A7y9FPXF3RLfCGayTEQoJMH24+FS53SwvYyZ55xPehmje9XjuKR2ACfgbIgplfeK725dLItYdm57bAqQmJTbMGy0rwPe+O5g5zxKXKNoPPY6uAra/vKYF8O0d86iIRir/YLSvknDPWeIDyEBGKvoFPaR+Fi7n7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW4ntoXWUjcWgtymA91yCD0O50dBwhboZQpAlYM74dI=;
 b=VV/UCY8vTlw7LtoRraw1czRPFrdDjE10d+TWsS9uhCYlKqpfpraXDoIiszKZYx865xXfBuvelxySopGgbg3xHHEM1Pxe8nxO06njkWrESJUfXgh4SCpVXOKLXt8cHTnyWBqyXKeHI4rFifeUqZOG4Wfpw8n3XNXzEo7OWAPoi0rXykE1bqtl8W8gqKdO/s1eGph9pra/rpXKWBsokZirgPUAEuhX6VaYXvTTH7dN/kfas+UUXP4UFEDRNBcu/Hlbf/wlhHFSc8YpRdSzwzcuYTey5KuURG9xokmEN+3NJo68pdM09MbIegWikmHYLLtQtR5lWFSMNuezieBhLG574g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW4ntoXWUjcWgtymA91yCD0O50dBwhboZQpAlYM74dI=;
 b=LBa8QL2Hvcr/90TdcVS2ZlcFpijz9ygnpf9PU7X9DPB/iPVhFydR+x27mo3fcRXuqoKels2BqeyvnokpXPBxkWET72UULhj0cu5z1VwLmCYbe4k+anv78nTJ1K0/OkM2mgY2GiJS/6uEamsj6OQl3XGeZ/i6AERSRdfHEee6KFM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5051.namprd10.prod.outlook.com (2603:10b6:610:c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 14:02:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 14:02:28 +0000
Date: Tue, 5 Mar 2024 09:02:25 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "aglo@umich.edu" <aglo@umich.edu>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: enable nconnect for RDMA
Message-ID: <Zecl8WT1MAXQq0N0@manet.1015granger.net>
References: <20240228213523.35819-1-trondmy@kernel.org>
 <ZeTC2h59TXUTuCh_@manet.1015granger.net>
 <CAN-5tyH2dkLbt9dMau46ebrU=PfvLgo2=mr8u3_C1gUnAGM_ow@mail.gmail.com>
 <51189037-DD10-4806-8596-D4374067FDFB@oracle.com>
 <c88bda54d8eb5a78a94b426e23cc8048d804927c.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c88bda54d8eb5a78a94b426e23cc8048d804927c.camel@hammerspace.com>
X-ClientProxiedBy: CH5P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 7493d17e-130a-4435-8582-08dc3d1ce483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XPIM0J6hWjcAKOC4ujn/FCNoHNohK7EvPXD6uoYGLLBq3qt6wp4X1N/qOmGRK3/qxDbqW8uRiSaS0WbX8n9Oy7HgwkwPNDkCrPwTJWtfkSnHYWp89VrCtGub/WnbMLLzsAiQz6+vJzXXY3mtn77kv6+JwUsyH5KCiO9nn10Dp7ragHgGSsdRj962VmUuEnCyn5hBLPQx6KEHzRnGbOdjdW5r9zV4sGldxBRp3N/4PJc9zKDWw4O1edf6p/zPofYJ8RS9viXdBxPnvZBjIp8S548t9mRs6iucroO9DNvoEfReWfJkxzgIaET07VDKfcbzYhktLfN6COn1l8OQRFimCk7RLQzXcHRzqiQg/7o9wK/pBGpPlltoTJFgDmspZ2gMjMj/PkobRYb8/g9j/+cvzh+kG8MjvDGafGJzXaLCifTNop4eIpyMPI0/K23lSIoqLi2JJLZtJAsphVXNHmIx2gi/zktw2YyJH8Ou8KMKkqp3o9tEdEYpX8GWLZupnY2xJM03R/uELSCYLEmnJv+m+m/fRxlg4bwVIfKvpTng6augjmjDQLbYdcKrZ5XqKiFQlzB3aeXisr9+1ToRQXIo9T515ySKdrCH9lhKS5vi2Rj2nV1OMnr0ylV+2h6M58a4OXHB6M8DNlq61Wqz5aWAD5KJJKJ+AjBPgUGiMs06g+E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2dnNVo5eU5OdnYwYm1JWklBZ2NGRGkxakJYYkdqazgyOHhMckF6em05Q2Jl?=
 =?utf-8?B?T0s0MEFYRnc4NEFZdTdXYWhUMDdSMjJuNGNEWmozWGJOZUU2eWJOY0NVVUty?=
 =?utf-8?B?dDZKdmd0VTRqSktZS2xZNnZYRlFLb2pnOVpLenFZdjVRNjlLb29QaC9YWDZo?=
 =?utf-8?B?OVNtMktPT3F6NkxRS2drYnlFUGlqRFFxOXQxRzhtWk9qdlBWRDhBc1o1bkYy?=
 =?utf-8?B?Z0ROcG5mNjk5MFFNclFLbGY5N2REYkJGYmxmOXRESWhKQnh0U1VHUGtvOThT?=
 =?utf-8?B?K1UyajcvdUxsNG56VkJLdnpZb3ZUWVZOd3A0TWJVdytPSGFLYTBsOFhIQW5U?=
 =?utf-8?B?OXVzUmhVYTJKbmlpOEI4VHVaL2lxUkl1R2JZQkRVZWlMZnRHeDgrbDZaSS80?=
 =?utf-8?B?MW1DT2kwQWh1bUhGS2YwOWZyKzJJNEx3aXI4WE9WNVpVSjhOK1ovekpwSVB0?=
 =?utf-8?B?Ym4xaEpqeXFDNFhxQyt5dVpRdjNtSGl4YnQrNGtRbHdRb3VLUkFRK2l5YUpB?=
 =?utf-8?B?VXpTcWlsd1ZVZmMwYVAvWXRqaVpocy9uOEkzUFJnVy9qdHZKVGdmQWFjZWFr?=
 =?utf-8?B?U3ZtZ09uSTZsMjE3b0VrTk43VFhlcTRwY1NmTzVPVXdFejlud0hONVZKd0ZZ?=
 =?utf-8?B?VmFwVnpSNC9CS3pZSTcvZ1hHNkw1aG1UYmpEbk0vbmRJZ0tyN252Y08zOTZ4?=
 =?utf-8?B?OHJiM29WWFptVitFL3NoOGlGK0IySnNBVDRrdk5mZTNqV0NwVUxlcEJUajRt?=
 =?utf-8?B?anM3b3RTTUpwL1NsSDZ6Rm4rLzl0a1BVSm1XNmk2ZG1iZDJ5OHNoOEVFQTQ4?=
 =?utf-8?B?dlRsNkdMaENJU1p6bDNIc3Bqdm50OXd3U0UybE81aW1WUzVJeGJwRUp3dHFu?=
 =?utf-8?B?SEdzSXdsRlFSczNZRStkU3VCZElpWU1BUjBPbVlFSXpqZGxRZkw3czVWblBM?=
 =?utf-8?B?NjVqQ0RZVzR0akM0SlpodFRXSkh4YlAwb3RhNEl5UkMwbTFmT1J1RWpEK0Za?=
 =?utf-8?B?T1g0M1hudzAxbitrTFpDM3ZjazlCM3BzenQ2MkN4WjZYYXpEa245TUdVNTg2?=
 =?utf-8?B?MjBrQ1Jram5WQ0tFR1JMMzcwcTRycitCT0pJTUZlUTBhMzU1Zm5UTnF2Rzlr?=
 =?utf-8?B?d3lObDM5TjdQOWdHRzFGQkkyWWJCTmZvVEVBS080eGZUeEd3UlkzZExxNWZW?=
 =?utf-8?B?WVFiTHlOdkduK21KZ2xvTDY1L2cwWTBicXlEQUltNHBBYW8wRmQyTWE1dmJi?=
 =?utf-8?B?U2ZQUU1NVGt4d2M0Q0ErcHNWUDZRUVp5MTRwczNEck5Ca3FEQ1lPaCtDelIw?=
 =?utf-8?B?VE85SlBYNjFWSm5uYnBjMHlveHplclBoZkg0aHhScEtzK3VWZ3JCNUdWNHVB?=
 =?utf-8?B?aHZqMlJacWJjZlhMN1JXME80cGVWS0laZ3JZSHo3dEluWnh4K2hENG95L3JQ?=
 =?utf-8?B?ZVc4ZTZJcVoxaG5OY3BQdUw4WWJHY2srb3NFc1gvNFA4NU9pd1J1TkpNME5H?=
 =?utf-8?B?UlhjeFIxSmdGaTZ6WDYzcVJYZGhsM1VYVzB0UzU1NzBWR0c5cDN3Z3E4cXRQ?=
 =?utf-8?B?dEZQOHFRem9JMlNyQ1A5NVVSY0d1U3pBR25tVlpmL1VoRGorczFoWkkwMTBX?=
 =?utf-8?B?bkE3aWkxa1ROTWxtOXFSVlhqTEU3c25pZkJrV2xNb2VHK1NWV1ZhdW9ieC8z?=
 =?utf-8?B?QWhTTVFQWGQ5UlpPeG95QzZ3SGNXdnJKWUxtU25GUDhYT0IzUnVReDFJTWJO?=
 =?utf-8?B?QlRMNWJZUk5yZzF5UjVzUWpQZDNnei8yTG45cVk4VXJ0Z0ZjMlVQVUt2VkpV?=
 =?utf-8?B?TVladmdpVFYwaW9XK1BIWXo0MXpVSWgvVWxSYVFSWlNtQW0xeWJHdnk4cmF0?=
 =?utf-8?B?WmhhZm1xaFk3K3BmNEtnRENLaTk0TGgza0pxeVBMTTdqNmh2aVplZXpTRUhP?=
 =?utf-8?B?RVB5Q2hITnhHWk5Od1EwOGY1RnJ2ak1GWSs0enUyZ1I1TVNkUnVkbjVMMXlT?=
 =?utf-8?B?QkdISExib3p2RVNyNkozVXVPWS9SNmtSb012VVBlRVVTVnZqeExoTHdYRVlZ?=
 =?utf-8?B?Rkx6S3NQRjJCQnowTjlTWmV3VW5ITE1DZDI2NUlYSmM2WE5tSHYydnhoRmww?=
 =?utf-8?B?ZzRONEFBYTdQOENxTkNycG9FWThCSTc1NVMxbWo1M0c1dHMyV1k2OURWYS93?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Nq5mavYB7KgTp3WoM6jzM2j06ucAsjuSYEQc51LIGcH4YWgqZwWL8LzhFIjjm5x7/jMQ5nSPz++TthCu/Ow90x8C7aIvc2MVACK/LFOUG+n4j2zP9jIUgvFQNFynWFy3WFRP64OQXfPeuiy+eie5QOrKjiRaMKifftgDIqiK47r3lZyxiNFQnhrS8TaUc7ShGK4NtWsf3dzU3VogWPQLDlQoiyTKjT/GvM50iiPsrEDDWxWOA17uiaDygDQttAIsgoKLYu0P49VG+h/qNO2E2PKvdx0AK68U/XCXhpozQgqRePBeUxwu0kdV5AbmRAXsbG9yCi73saiQtmB6wXVgMyfjnQEQ3C7ISkac1XaqKGC6njA5E8xR0fVU0jwXQAc/iVWVvpRENGarmdfPot0ZtoQWjAIqhz7q9LxXB2nH5mHD4EACYGRURrgvFY3VzCJua5SW36IDj0bIDZp210Wacd6okzO/v/MpYYVCVDVRkVjd+L/IT+o2UsSSWIPWjzf9jyoRlFE1EQRosUsMS4WXDpJeZd4OHv+3k3a6n7qDWktD8Mfhp3VJKJeu5pIFsnQ1OUXspL17bbwR5O0U5ZbofPlH1H+ahZUHgR5k9eh5MFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7493d17e-130a-4435-8582-08dc3d1ce483
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:02:28.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w29M46JjGqejUVBsLPhiJ8WWLlc/dbJNxhytb82MohZ/nz0I451dVgBFT3Nq60xpNbvXcKISgFLqEIDrJIXtnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_11,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050113
X-Proofpoint-ORIG-GUID: L89eLBJs6poi3iw8sO6i12XR_ejmmAVP
X-Proofpoint-GUID: L89eLBJs6poi3iw8sO6i12XR_ejmmAVP

On Mon, Mar 04, 2024 at 11:08:00PM +0000, Trond Myklebust wrote:
> On Mon, 2024-03-04 at 19:32 +0000, Chuck Lever III wrote:
> > 
> > 
> > > On Mar 4, 2024, at 2:01 PM, Olga Kornievskaia <aglo@umich.edu>
> > > wrote:
> > > 
> > > On Sun, Mar 3, 2024 at 1:35 PM Chuck Lever <chuck.lever@oracle.com>
> > > wrote:
> > > > 
> > > > On Wed, Feb 28, 2024 at 04:35:23PM -0500,
> > > > trondmy@kernel.org wrote:
> > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > > 
> > > > > It appears that in certain cases, RDMA capable transports can
> > > > > benefit
> > > > > from the ability to establish multiple connections to increase
> > > > > their
> > > > > throughput. This patch therefore enables the use of the
> > > > > "nconnect" mount
> > > > > option for those use cases.
> > > > > 
> > > > > Signed-off-by: Trond Myklebust
> > > > > <trond.myklebust@hammerspace.com>
> > > > 
> > > > No objection to this patch.
> > > > 
> > > > You don't mention here if you have root-caused the throughput
> > > > issue.
> > > > One thing I've noticed is that contention for the transport's
> > > > queue_lock is holding back the RPC/RDMA Receive completion
> > > > handler,
> > > > which is single-threaded per transport.
> > > 
> > > Curious: how does a queue_lock per transport is a problem for
> > > nconnect? nconnect would create its own transport, would it now and
> > > so
> > > it would have its own queue_lock (per nconnect).
> > 
> > I did not mean to imply that queue_lock contention is a
> > problem for nconnect or would increase when there are
> > multiple transports.
> > 
> > But there is definitely lock contention between the send and
> > receive code paths, and that could be one source of the relief
> > that Trond saw by adding more transports. IMO that contention
> > should be addressed at some point.
> > 
> > I'm not asking for a change to the proposed patch. But I am
> > suggesting some possible future work.
> > 
> 
> We were comparing NFS/RDMA performance to that of NFS/TCP, and it was
> clear that the nconnect value was giving the latter a major boost. Once
> we enabled nconnect for the RDMA channel, then the values evened out a
> lot more.
> Once we fixed the nconnect issue, what we were seeing when the RDMA
> code maxed out was actually that the CPU got pegged running the IB
> completion work queues on writes.
> 
> We can certainly look into improving the performance of
> xprt_lookup_rqst() if we have evidence that is slow, but I'm not yet
> sure that was what we were seeing.

One observation: the Receive completion handler doesn't do anything
that is CPU-intensive. If ib_comp_wq is hot, that's an indication of
lock contention.

I've found there are typically two contended locks when handling
RPC/RDMA Receive completions:

 - The workqueue pool lock. Tejun mitigated that issue in v6.7.

 - The queue_lock, as described above.

A flame graph might narrow the issue.

-- 
Chuck Lever

