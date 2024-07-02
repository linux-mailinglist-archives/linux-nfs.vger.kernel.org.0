Return-Path: <linux-nfs+bounces-4524-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84965923E30
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 14:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A832A1C2111A
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E944115B0F0;
	Tue,  2 Jul 2024 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l0XJFcs7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cJWmkcIN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235E1448E1
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924996; cv=fail; b=JjewB4s8idKr6wUuzujdaVygmblGnC5jvdMRrfv5z7JUkSmGKhqxoxi651lBNDGLSIARer7eJ/8YL3E7WbR6KV72Lqmo32Yw/t1tj1x5VwUTt9UpfBdj7f1LZExfkKPv6ZZ0mIGDuSPETLw+6VhZMm2jlU3fANsNFrPzm8XlpBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924996; c=relaxed/simple;
	bh=tb+/He11DIdLR74cFVOQchna+w0ei0aYAxDLtW9b5Yk=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=SlgqOkJ9ax0mgwJyAd356N1+n4elzdirMFrpahbY4lCp8BJtttCizEoUnoONVV0e2JAIHZQGAYMmFOVyhFnxHSvcYM91IHEU5g/75G8VUhVaFmbzEMQmgSPDDZKw0eK9gyOTHi4Nv+y8PJpELBJDL5ejwZMBSBDJ4o7xCDmKSqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l0XJFcs7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cJWmkcIN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4625MUit030662;
	Tue, 2 Jul 2024 12:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:content-type
	:content-id:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=tb+/He11DIdLR74cFVOQchna+w0ei0aYAxDLtW9b5Yk=; b=
	l0XJFcs7s4Xqi73Od7YNoyVDrm+kFigfBK5IfWAV1fKL8Y5OiVX2fXwG8AxlfHLq
	ITzgn8tOmZ2zDQl+b4rjXL457uleURHJtJIXsZkU06XaW82trOx3cQKfrfqxtLB4
	R/vGHZ3+pwK197K3lca9RcnYEJTi8qJWPWu9cS5XDoyVqoAk+iGKNbP9AvhQMIha
	KvKsfc2/Q3YN4RqfL9INKpv/A9zy6JDgX6P71qeXN5w+AATJ4O3t0j+PmDMNjG6b
	29GWu31n6/EjWLJ7hWH1mBnjz6A9KgyQ7AtG15rpm7lL6qJ8BgH4zhZvhDCj8Q2Q
	6aQUzW0V2vvaSfRCDUYR9Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attds85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 12:56:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 462Bo4jQ022838;
	Tue, 2 Jul 2024 12:56:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q7hryp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 12:56:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTG8wY8QY7A3aijVP7g9yns8MHgX9BKGoBcC10R7uJbEuntZCARIllZ3WuEZir8+SUEhASHBAGVp8agC5706LoQs54D5eHE4ct84EXKrY7edHtqyphzYZfY/EKNhEw06ZJZJxxXdpnQ1L4PwoQX+NuoqPMIvlS9jC0HAklcHTMDoHronMwcwEP0iC5W6PY0B/mU7a0SH8sn/p/iyT1cVNXx4/DpFbKzBZYZ4aNct4VY6NID2DaSPPX9mazK2z7SKCj4bLQ4hsfDYcnss0XOF2N3TIOH24aaSYWedGigyHhNHaQIE0LxTW3aU54rxmarFzpRMl5vloGPy7MHihV/BZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb+/He11DIdLR74cFVOQchna+w0ei0aYAxDLtW9b5Yk=;
 b=JrxFzhVMQXVGCdN+SWD/T+1PBFUHaFsYyEHHX1mvRBPGA5bjK+7gZtwfwJ5eyUWhPyTxNKh0ILltXEiMXnnl1a7YgHCfeQzv3YU/rzFf2WqaDupkG74Ak5vvhXJ/iLxTyJexypcbYihY9x/I+SH4zIpEV6ACwYTg/Tcoo4vigp03ahr4HPsn4yVv8kQGu3pMHjd1jua8rMUQJwHp50H2hB6w9Ruq192UswXyeKCcBmLKYkeJUNHaspOZffv9O/BN27ZZ2PzU7kTLgg1cvtD3jB9pPTE/2S/cuqECtNEpcmY8TFXmeEqx8WT9JongzOl/dfWWPG2PDiZhXT14uVRwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb+/He11DIdLR74cFVOQchna+w0ei0aYAxDLtW9b5Yk=;
 b=cJWmkcINq0JtINW60WcbdNLB9Qam4T/gKj9PSXmlQQqHDR3FrUfqzT67eSBNSQ9IiCGxDntEp3ikuX+qtmmHw/pQOY5sT4iO75+P9Ki20OQ3oz7YlHHzeqshDU46VFgOocj7wOV8B8QatuCOQIJGLDw8FdT0A5LdnM1U7kxNfxs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB8103.namprd10.prod.outlook.com (2603:10b6:8:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 12:56:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 12:56:22 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Anna Schumaker <anna@kernel.org>,
        Trond Myklebust
	<trondmy@hammerspace.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Fwd: [PATCH net v2] net, sunrpc: Remap EPERM in case of connection
 failure in xs_tcp_setup_socket
Thread-Topic: [PATCH net v2] net, sunrpc: Remap EPERM in case of connection
 failure in xs_tcp_setup_socket
Thread-Index: AQHayXi20fKufczNVkW3hiPfAUfk2w==
Date: Tue, 2 Jul 2024 12:56:22 +0000
Message-ID: <96E88543-F7C3-4CD9-B3EF-CBF25D76B500@oracle.com>
References: <39757894-2C57-4DD6-AF93-25EA35C87C3D@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB8103:EE_
x-ms-office365-filtering-correlation-id: 1357cb2d-0de1-4147-173c-08dc9a965ff4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?STBvTTh4NTIvZnExNXBTWW91N0p3ajRvaUNqcUNLUTlPWGZ6bWhncG9QNjFq?=
 =?utf-8?B?SEZZZmJyc25vbktIS3dHNzdjNUE2Zk1yS01Va21xTUlLYWRPY1pYU01yTEt3?=
 =?utf-8?B?U2pQa0hxbm1tMG42U3p0ZlRSbmkvMlRlOURNS0pHQnRTUmx3SC9aczVHMzdm?=
 =?utf-8?B?VWN6cW1yb1VIaWQ5QUx2TTJmSUt0emZYS0k5Y3pocWU5b0VhVnR4RTAvcmpy?=
 =?utf-8?B?NG9Na3FHb3g5ZHFNb1IvUFlpek94d29jT3hNZjBYcFcwMkpTa3d4NjRTTkdh?=
 =?utf-8?B?a2luTUlGSUlNQ1hxK1FyNysxa2ZidDZMNjFMWG1HUStoM0R3TWIxSk5tL3JF?=
 =?utf-8?B?S0ZpbnUwUzdIdlZrek1JRktBSzRVQUw0QVhJR2VwVkhlc1hIL2tHak95YkR1?=
 =?utf-8?B?bVVIUVFjWkpnRVlXWmROcERmVXZKeGgrZi9SMzVSSjhrZU9WcEZHMnVqdm13?=
 =?utf-8?B?ZGpiOFFac0pWODZ3anZxQkJFOUVLdThNbzNwVlFYNW93K3p3c1Bwb0xVUEhv?=
 =?utf-8?B?REhxZWdiZ2VVdTlIRzZGQW5BNmZCVVlhcHNDaUdxdStHWmxOR1RKYzdldjNk?=
 =?utf-8?B?VkhTekh0bmVjTnEyZFhIMlBWcUZRaHpIZ3loalJnNnBhVUI1RitZTTE3Vk5B?=
 =?utf-8?B?QzNURU5YK2UwRjdlQW9GSzhWdVYzVXVjNUFzOXM2TXRqUVQxbjlrdkN4Q1Vu?=
 =?utf-8?B?MGFNQkdIVXRMRmRENGNjVXM0YytQNGhLeTB5VjlLVVVTaDl2a1VHWm0rTFJx?=
 =?utf-8?B?V0ZJZ1F0WVJwbDFlRGJnNnViK2ZSenhqKzFjNitFaWpjeDFVeWNua2EvUUF6?=
 =?utf-8?B?U2RQR1JTYS9WVXNHdVhLY09leEVPMTk1OStRejVJd0c4TDVZQ3FDSkpsT0tn?=
 =?utf-8?B?U2N6SUF5c3dxWmJBWXJIVGxnZzA1WlU0QlA0d0drYzZTdmhYSFdRd0l3VDN0?=
 =?utf-8?B?c2R4U3hHNmhtdnBwMlVGdFV5U1BQTTh2ZUZTWlRNbm9TcjYybEtJaHJTc1Ay?=
 =?utf-8?B?dGtLK2w5UDgyeE10MndlcnBxQ0E4ZkM2ZjRJR21QcllXRGlQTnNoMVl2bEpD?=
 =?utf-8?B?eGRqbWpOK0g5U2JlNjF6SjhZaVNLRFFUUi8yQ0M2TUxBN2MxMVhkMUlCYXh1?=
 =?utf-8?B?b1ppY2VxZFh0Q3lITSsrRWJRQ21RYlB6b1lnazRDemc2S29ZQytnQUs1WENG?=
 =?utf-8?B?L21YYnNUbjlBNWpvVFhPcTY2TWF5WE4wWXB4T3hVTzB5SXAzS1dmMVMyQytL?=
 =?utf-8?B?VFhnTGVVOStlaXVuMXZnSkJhQmx1V21NZ0NLZ2pJOW1Eb211dThtai9FQVR5?=
 =?utf-8?B?U0RDNjBabjhkd0FGL3FPWmFvU043R0Fuc1ZRQkVYZnZNbmt0UXhmSEVmZjNN?=
 =?utf-8?B?K2pHenl4blVsNEFZMit4S09KZ1ZmNUl3ejd5RVV4V25wQ2FCa0NrTEtkVXdk?=
 =?utf-8?B?QnpkYmVrUGt0K2hOM1c4bHVicGw5cEowTk44U2tmTDRGZnVTTXF5OGVPbDdQ?=
 =?utf-8?B?c2tqV1krcEdoRjhxTlNWU0dDdzBuZTVSK01yKzlYbnFUenY0MzZnM3E1eDhv?=
 =?utf-8?B?NXlmejFGaHhPTW5FeVZWbDMwK3ZjYVRNMXNxU09oRDVRWW5pTVJaWTRPZlRT?=
 =?utf-8?B?ZTNpTWtXQzlSVmNhNmI1eTEwcnJLT3pUNW9LcHZDNjNnTDVMWmRCNWxIVFJj?=
 =?utf-8?B?NjNmUDhjMGtNUkJsa0hKS1Z1aWxiMkJGWU9mZFdTMzVzUTFiS0Q1M1Baa2Jv?=
 =?utf-8?B?NVJCeWFXb2VxSC9YTVROU0VRbWpoc2k4U2lNaEUzTXNBWkxKWm9CZEI5clhx?=
 =?utf-8?Q?jX0LhB1nZBinrnIHZwSGzjjoLqWE4amgl50v0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d1BYZVRwVjg2NGJiQzVRVWIrZjUwZFVRMGM0MDVyenJZUXFqMjI4RGRIbWFM?=
 =?utf-8?B?aHYrdHRjaHNxTDd3T2FsS1JiRFYyTTR6QzVEbW9VOWxlRXR5QlVRd3lTelJt?=
 =?utf-8?B?UDBiSGVabjJ1anMybzJKT2NMeFhEVVY5TFY1VlNsVlAwbWRNeDBKeGtmMTdT?=
 =?utf-8?B?b2VqK3htMzJib3d2ZVpHajVxeVdhd0VWQjB5dWpYZnBrV3c0VTJGdVUvd2xB?=
 =?utf-8?B?L3J4ZTEvOGhNcXdMN3laTjlYUVptNy9Oek8zRDF2aDFLMU9hMGZybjJjVzZp?=
 =?utf-8?B?azdMYjZkY1N3VFQ3ZTFZYVFHdUppVytkVXN1YzBzbGNzWENwcEFWNFk0RVFM?=
 =?utf-8?B?SE9IMzVQeFFjUG13Q0JVK2cyZEpsQ1lpMmpoa0ZFeXF2Tk9ITmZ0QVFObWo1?=
 =?utf-8?B?bHdlWE52a2xTdTZEVDl1NElXTFM3ZGgwY2E4dnRQdDlNaGRMK3lxdlZFSnUv?=
 =?utf-8?B?NEw2RXhCU1hjbXJESG9ZR0hTcVJrTDBCZ2t5cHVzQUp4MFA0bm1GbjhxUnNr?=
 =?utf-8?B?NCtEYWVjclhrVjhRRW9Fc2U4bnB2cWp5R1JybXpVM3NQeFNobm95SFdqYUtR?=
 =?utf-8?B?UHVFZldpMTUrRlV1OWh6UUxuZjZabjE2cDRqb1V0TTVBQ3g5UHpIakZxRVJn?=
 =?utf-8?B?TmZsMlNoSkpmKzJrQUp3UGwrSE5yeW8vQXc3VTVTRTdLd0c1TUJNU0l5VEpO?=
 =?utf-8?B?K0ljRlkrQ0ZXUXhvUklVRFFGRGRaQ2RrenVtVXZWSWFERitFalgwVS9oWnlB?=
 =?utf-8?B?MHJVc3B5SklKR0doRUFpck1nK2J4SHhLQUpNRFNDRTRWS0N3clF3YTdYVXpH?=
 =?utf-8?B?TyswZFdnZi9DTEFjWlp2ZlVVelQycXdTRDlhMldjQTcyMmFIQUh2d25jVUU4?=
 =?utf-8?B?TmFrTEp1V0lNSmtuWU83bzRPVUhoUUxqQTF4QXFlZjMzWjRzeTlYb2Vqdy9F?=
 =?utf-8?B?MDR1c3NaVC9pR3gwbzZUNXhtVFFqWVhtZHAxTmNBNWJtZG9GUldCQ0F4K2dz?=
 =?utf-8?B?djZBTk5iM2tKbGQ1c0NBZ1E5ek9zT1VnRlVVekpZN25uZC9BMFI2bUNGdDFJ?=
 =?utf-8?B?ZTFiOFRBcXNPQkZ1NDRMMnlsWGNMa2xNbjh0T25IbE5VbFptUjhBM1lJeEJI?=
 =?utf-8?B?K1hlKytESjZ2emkxaXlvWVRpdG4yOE9GblpqeGhEMmJ3NkFzU1RlV0tCQXdo?=
 =?utf-8?B?SHhDeHUzRWtZeUVLZGFNdFpTRERBVXd3WG1qaENvMWhhTm1JcVFZR2djWjRL?=
 =?utf-8?B?THQ5bHVkVFlSRFZ6NE9OUFltL29RU1dydW11NzJlWXFpS0NacmtkeE4vRlBI?=
 =?utf-8?B?SFNrT05pRXdQcE5PZWswb2xwMERZM1IyaEltR1g4NFA4bG5SSStWR3Evd0hj?=
 =?utf-8?B?MmRYdS9oT2RlVjNPZkd4akxPR2tHbm01WHM3bFJ2SFlIRDBSeHg1Q0Mxdjll?=
 =?utf-8?B?V1ZleS9jMVNwZjF6TFhVcXRSYU8wNzF0bExaalROMi80bHVLY1RBcGpUbXhz?=
 =?utf-8?B?cWxqZzcwNExoaHF5UWhrcTZmSDdOQWpwMVNGaFU2N29zU1dyKzZYTGR6VGx4?=
 =?utf-8?B?dEdHUXlSYndQa1FXRnNwZmdvdXFiMDh4a2hNSTJTWTY0RmdZQkV4Z3l5akFu?=
 =?utf-8?B?Q2tsNllVcGJWMVZmR2ZvbC83MmZFTUMzKzEvcURmVkdaVHNIeVYzNEdYdXE1?=
 =?utf-8?B?NHMvcGZLci9YZXIrTGJJeXZxcjBtU2laNEpxWEl2bm5EZTl0RFZXcksxK0pv?=
 =?utf-8?B?VkRPSXBHTm9wbGlieXFSTG1JMDFwbXdSdVdaOW04VElLTGQrNnk4dkZwWEdw?=
 =?utf-8?B?TzFhQ2FGeXlGelYwekdFdlI2RnB6L3F0ZGJHY05vSnNENlhGMzBPaHFIRmNE?=
 =?utf-8?B?dXZ4c0ZWT3B3R1ZkOHpGMktwSzRhbFU5U2lsUlFTOHgrSURaSkdNa095OEda?=
 =?utf-8?B?THZ4Q0NuYzMvdmI0VXdRaW9BQWt4cUcyMDcwY1V3V1YrdmVHK1JwZ0NjYk5N?=
 =?utf-8?B?SmxESlBKc3VGbDUrNWtCLzA5cFkvazFMVTlhOGlhV2hJdmlCMlBtTzZxTjhN?=
 =?utf-8?B?U1ZXb2thZFYweFV4YUtwM2w4WkFzem9HTytVdGgwRjY3QWhsNWFtV1pTVHBG?=
 =?utf-8?B?VkJtOG83Tm8vWStqMndlUXQzUWVvRVhEL05ZUG9TQTFZR3VCanhES2ZJclE0?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4883C3362A10314495F36B9132B3B18F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HiVfGEISDlEZxTr5jlIb3ds4Xy660NqVRMAOYEElOisVj/ucnk9XbvjGm1rxC/0hfy7r1hFTZs+Cj/rqUrTMWzUbKWu6Qh2Xr2NQFgL67tvTw1SZRzVpFfM4b1wYfJWqg2Lxd/1+M2G+2yr2UI2dtDx4EzmPQ4oUofwNF4GvgMQYdrS9qCWG8SV8o0JdE5cXduSe06Mmqofy76DmWLIAnjtiDQ/EgIfaU6cunc4BdeBQYtwv9iA2p55ijNHUsFLyHsh6cLeCROISsSjJ9S8UR4356SQBsPiiEqbGVuU9Jd4O9XLF62cYRaV7YkPrmpEiMWQtTOwXRA+OfqzkG5xl9mvTVLXsER9Yg4SjB4gw1PmDDFUv/u8OtMC9xTbZbo8YgFkSLxLOwCpbp6nUC5JrjU0KYWQiJ2/r1y+qt1DWQqWueqw9+hy+BeXac+JRSx3HG8YTVsjO07RXPh643TRcRMj32TA+EFMjpaREECFjbRKmzhEiTnbqaOvRgtP9/7srbgaol+JYaQC63MCRBtNgJGbJlItYgIiMdzA3AvvApuTu4RShea+QgRjbk+0D+pH7RmZdU9ADfZdALsxgNJOQovQfcPAN1/yhJ3Pcn2U5nMg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1357cb2d-0de1-4147-173c-08dc9a965ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 12:56:22.5285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IcwBS05RGEajLng2FAqPLHUeD6iN/MAKuFeT+JqJyK78qejM5svjL4fBgZTLrGJSJI2nP5O/ekaGBTSRYr3Ctg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_08,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407020096
X-Proofpoint-GUID: cW9hf_V7QyuA6K51nkRWGphi2DYEdLdL
X-Proofpoint-ORIG-GUID: cW9hf_V7QyuA6K51nkRWGphi2DYEdLdL

DQoNCj4gQmVnaW4gZm9yd2FyZGVkIG1lc3NhZ2U6DQo+IA0KPiBGcm9tOiBDaHVjayBMZXZlciA8
Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQgdjJdIG5l
dCwgc3VucnBjOiBSZW1hcCBFUEVSTSBpbiBjYXNlIG9mIGNvbm5lY3Rpb24gZmFpbHVyZSBpbiB4
c190Y3Bfc2V0dXBfc29ja2V0DQo+IERhdGU6IEp1bHkgMSwgMjAyNCBhdCAxMDowNDoxMeKAr0FN
IEVEVA0KPiBUbzogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiBDYzogRGFuaWVs
IEJvcmttYW5uIDxkYW5pZWxAaW9nZWFyYm94Lm5ldD4sIEpha3ViIEtpY2luc2tpIDxrdWJhQGtl
cm5lbC5vcmc+LCBOZWlsIEJyb3duIDxuZWlsYkBzdXNlLmRlPiwgSmVmZiBMYXl0b24gPGpsYXl0
b25Aa2VybmVsLm9yZz4sIE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPiwgRGFp
Lk5nb0BvcmFjbGUuY29tLCBUb20gVGFscGV5IDx0b21AdGFscGV5LmNvbT4sIG5ldGRldiA8bmV0
ZGV2QHZnZXIua2VybmVsLm9yZz4sIGJwZkB2Z2VyLmtlcm5lbC5vcmcsIExleCBTaWVnZWwgPHVz
aWVnbDAwQGdtYWlsLmNvbT4NCj4gDQo+IA0KPiANCj4+IE9uIEp1bCAxLCAyMDI0LCBhdCA2OjU3
4oCvQU0sIFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+PiANCj4+IE9u
IEZyaSwgSnVuIDI4LCAyMDI0IGF0IDAxOjE5OjQ5UE0gLTA0MDAsIENodWNrIExldmVyIHdyb3Rl
Og0KPj4+IE9uIEZyaSwgSnVuIDI4LCAyMDI0IGF0IDA2OjMxOjIzUE0gKzAyMDAsIERhbmllbCBC
b3JrbWFubiB3cm90ZToNCj4+Pj4gV2hlbiB1c2luZyBhIEJQRiBwcm9ncmFtIG9uIGtlcm5lbF9j
b25uZWN0KCksIHRoZSBjYWxsIGNhbiByZXR1cm4gLUVQRVJNLiBUaGlzDQo+Pj4+IGNhdXNlcyB4
c190Y3Bfc2V0dXBfc29ja2V0KCkgdG8gbG9vcCBmb3JldmVyLCBmaWxsaW5nIHVwIHRoZSBzeXNs
b2cgYW5kIGNhdXNpbmcNCj4+Pj4gdGhlIGtlcm5lbCB0byBwb3RlbnRpYWxseSBmcmVlemUgdXAu
DQo+Pj4+IA0KPj4+PiBOZWlsIHN1Z2dlc3RlZDoNCj4+Pj4gDQo+Pj4+IFRoaXMgd2lsbCBwcm9w
YWdhdGUgLUVQRVJNIHVwIGludG8gb3RoZXIgbGF5ZXJzIHdoaWNoIG1pZ2h0IG5vdCBiZSByZWFk
eQ0KPj4+PiB0byBoYW5kbGUgaXQuIEl0IG1pZ2h0IGJlIHNhZmVyIHRvIG1hcCBFUEVSTSB0byBh
biBlcnJvciB3ZSB3b3VsZCBiZSBtb3JlDQo+Pj4+IGxpa2VseSB0byBleHBlY3QgZnJvbSB0aGUg
bmV0d29yayBzeXN0ZW0gLSBzdWNoIGFzIEVDT05OUkVGVVNFRCBvciBFTkVURE9XTi4NCj4+Pj4g
DQo+Pj4+IEVDT05OUkVGVVNFRCBhcyBlcnJvciBzZWVtcyByZWFzb25hYmxlLiBGb3IgcHJvZ3Jh
bXMgc2V0dGluZyBhIGRpZmZlcmVudCBlcnJvcg0KPj4+PiBjYW4gYmUgb3V0IG9mIHJlYWNoIChz
ZWUgaGFuZGxpbmcgaW4gNGZiYWM3N2QyZDA5KSBpbiBwYXJ0aWN1bGFyIG9uIGtlcm5lbHMNCj4+
Pj4gd2hpY2ggZG8gbm90IGhhdmUgZjEwZDA1OTY2MTk2ICgiYnBmOiBNYWtlIEJQRl9QUk9HX1JV
Tl9BUlJBWSByZXR1cm4gLWVycg0KPj4+PiBpbnN0ZWFkIG9mIGFsbG93IGJvb2xlYW4iKSwgdGh1
cyBnaXZlbiB0aGF0IGl0IGlzIGJldHRlciB0byBzaW1wbHkgcmVtYXAgZm9yDQo+Pj4+IGNvbnNp
c3RlbnQgYmVoYXZpb3IuIFVEUCBkb2VzIGhhbmRsZSBFUEVSTSBpbiB4c191ZHBfc2VuZF9yZXF1
ZXN0KCkuDQo+Pj4+IA0KPj4+PiBGaXhlczogZDc0YmFkNGU3NGVlICgiYnBmOiBIb29rcyBmb3Ig
c3lzX2Nvbm5lY3QiKQ0KPj4+PiBGaXhlczogNGZiYWM3N2QyZDA5ICgiYnBmOiBIb29rcyBmb3Ig
c3lzX2JpbmQiKQ0KPj4+PiBDby1kZXZlbG9wZWQtYnk6IExleCBTaWVnZWwgPHVzaWVnbDAwQGdt
YWlsLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogTGV4IFNpZWdlbCA8dXNpZWdsMDBAZ21haWwu
Y29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQm9ya21hbm4gPGRhbmllbEBpb2dlYXJi
b3gubmV0Pg0KPj4+PiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vY2lsaXVtL2NpbGl1bS9pc3N1
ZXMvMzMzOTUNCj4+Pj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYnBmLzE3MTM3NDE3
NTUxMy4xMjg3Ny44OTkzNjQyOTA4MDgyMDE0ODgxQG5vYmxlLm5laWwuYnJvd24ubmFtZQ0KPj4+
PiAtLS0NCj4+Pj4gWyBGaXhlcyB0YWdzIGFyZSBzZXQgdG8gdGhlIG9yaWcgY29ubmVjdCBjb21t
aXQgc28gdGhhdCBzdGFibGUgdGVhbQ0KPj4+PiAgY2FuIHBpY2sgdGhpcyB1cC4gXQ0KPj4+PiAN
Cj4+Pj4gdjEgLT4gdjI6DQo+Pj4+ICAtIFBsYWluIHJlc2VuZCwgYWRkaW5nIG1vcmUgc3VucnBj
IGZvbGtzIHRvIENjDQo+Pj4+IA0KPj4+PiBuZXQvc3VucnBjL3hwcnRzb2NrLmMgfCA3ICsrKysr
KysNCj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPj4+PiANCj4+Pj4gZGlm
ZiAtLWdpdCBhL25ldC9zdW5ycGMveHBydHNvY2suYyBiL25ldC9zdW5ycGMveHBydHNvY2suYw0K
Pj4+PiBpbmRleCBkZmMzNTNlZWE4ZWQuLjBlMTY5MTMxNmY0MiAxMDA2NDQNCj4+Pj4gLS0tIGEv
bmV0L3N1bnJwYy94cHJ0c29jay5jDQo+Pj4+ICsrKyBiL25ldC9zdW5ycGMveHBydHNvY2suYw0K
Pj4+PiBAQCAtMjQ0MSw2ICsyNDQxLDEzIEBAIHN0YXRpYyB2b2lkIHhzX3RjcF9zZXR1cF9zb2Nr
ZXQoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPj4+PiB0cmFuc3BvcnQtPnNyY3BvcnQgPSAw
Ow0KPj4+PiBzdGF0dXMgPSAtRUFHQUlOOw0KPj4+PiBicmVhazsNCj4+Pj4gKyBjYXNlIC1FUEVS
TToNCj4+Pj4gKyAvKiBIYXBwZW5zLCBmb3IgaW5zdGFuY2UsIGlmIGEgQlBGIHByb2dyYW0gaXMg
cHJldmVudGluZw0KPj4+PiArICAqIHRoZSBjb25uZWN0LiBSZW1hcCB0aGUgZXJyb3Igc28gdXBw
ZXIgbGF5ZXJzIGNhbiBiZXR0ZXINCj4+Pj4gKyAgKiBkZWFsIHdpdGggaXQuDQo+Pj4+ICsgICov
DQo+Pj4+ICsgc3RhdHVzID0gLUVDT05OUkVGVVNFRDsNCj4+Pj4gKyBmYWxsdGhyb3VnaDsNCj4+
Pj4gY2FzZSAtRUlOVkFMOg0KPj4+PiAvKiBIYXBwZW5zLCBmb3IgaW5zdGFuY2UsIGlmIHRoZSB1
c2VyIHNwZWNpZmllZCBhIGxpbmsNCj4+Pj4gKiBsb2NhbCBJUHY2IGFkZHJlc3Mgd2l0aG91dCBh
IHNjb3BlLWlkLg0KPj4+PiAtLSANCj4+Pj4gMi4yMS4wDQo+Pj4+IA0KPj4+IA0KPj4+IEhpIERh
bmllbCAtDQo+Pj4gDQo+Pj4gSSBrbm93IHRoaXMgaXMgbm90IGRvY3VtZW50ZWQgaW4gTUFJTlRB
SU5FUlMsIGJ1dCBjaGFuZ2VzIHRvDQo+Pj4gbmV0L3N1bnJwYy94cHJ0c29jay5jIGdvIHRvIEFu
bmEgU2NodW1ha2VyIGFuZCBUcm9uZCBNeWtsZWJ1c3QsDQo+Pj4gY2M6IGxpbnV4LW5mc0B2Z2Vy
Lg0KPj4gDQo+PiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byB1cGRhdGUgTUFJTlRBSU5FUlMgYWNj
b3JkaW5nbHk/DQo+IA0KPiBJIGNhbiBkbyBpdCwgb2YgY291cnNlLCBidXQgSSdkIGxpa2UgdG8g
ZGlzY3VzcyB0aGlzDQo+IHdpdGggdGhlIE5GUyBjbGllbnQgbWFpbnRhaW5lcnMgdG8gZW5zdXJl
IHRoZXkgYWdyZWUNCj4gb24gaG93IHRoZSBmaWxlcyBhcmUgZGl2aWRlZCBiZXR3ZWVuIHRoZSB0
cmVlcy4NCg0KUmVjZWl2ZWQgYSBzdWdnZXN0aW9uIHRvIHB1dCBtb3JlIGRldGFpbCBpbiBNQUlO
VEFJTkVSUyBhYm91dA0KaG93IG5ldC9zdW5ycGMvIGlzIGRpdmlkZWQgYmV0d2VlbiB0aGUgdHdv
IE5GUyB0cmVlcy4gQ3VycmVudGx5DQp3ZSBoYXZlOg0KDQpORlMsIFNVTlJQQywgQU5EIExPQ0tE
IENMSUVOVFMNCg0KVDogICAgICBnaXQgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMv
dHJvbmRteS9saW51eC1uZnMuZ2l0DQoNCkY6ICAgICAgaW5jbHVkZS9saW51eC9zdW5ycGMvDQoN
CkY6ICAgICAgaW5jbHVkZS91YXBpL2xpbnV4L3N1bnJwYy8NCkY6ICAgICAgbmV0L3N1bnJwYy8N
Cg0KDQpLRVJORUwgTkZTRCwgU1VOUlBDLCBBTkQgTE9DS0QgU0VSVkVSUw0KDQpUOiAgICAgIGdp
dCBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2VsL2xpbnV4
LmdpdA0KDQpGOiAgICAgIGluY2x1ZGUvbGludXgvc3VucnBjLw0KDQpGOiAgICAgIGluY2x1ZGUv
dWFwaS9saW51eC9zdW5ycGMvDQpGOiAgICAgIG5ldC9zdW5ycGMvDQoNCldoaWNoIGlzIGNvbnNp
ZGVyZWQgdW5oZWxwZnVsIGZvciBkcml2ZS1ieSBjb250cmlidXRpb25zLg0KDQpBdCBsZWFzdCBm
b3IgTkZTRCwgd2UgY291bGQgbWFrZSBpdDoNCg0KRjogaW5jbHVkZS9saW51eC9zdW5ycGMvc3Zj
Kg0KDQpGOiBuZXQvc3VucnBjL3N2YyoNCkY6IG5ldC9zdW5ycGMveHBydHJkbWEvc3ZjKg0KDQpB
bnkgb3RoZXIgdGhvdWdodHMgb3Igc3VnZ2VzdGlvbnM/DQoNCg0KLS0NCkNodWNrIExldmVyDQoN
Cg0K

