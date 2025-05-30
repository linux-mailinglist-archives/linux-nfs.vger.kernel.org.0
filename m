Return-Path: <linux-nfs+bounces-12000-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E5DAC907A
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 15:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524394E2935
	for <lists+linux-nfs@lfdr.de>; Fri, 30 May 2025 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3BB21FF30;
	Fri, 30 May 2025 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B20gQ3kE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K7zZlvJ8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154A21517C
	for <linux-nfs@vger.kernel.org>; Fri, 30 May 2025 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612663; cv=fail; b=t0Z5xffL9t6GX62MqzDgGEbKkMQsgr080vV628BbBrDcrWE+L58JP4uJUOPpmE4P57m1oclGnqmrqoohTpbj04f5GAOxNc3UwWgZ+Rq28BPkQyTNrxe+VOJXgdipG817p3ygR7OqkRcXTrU8ex69lDt/943hjiTZmAL0dRhO+Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612663; c=relaxed/simple;
	bh=Ej0vePDsJVOwUMNRhDsZ/UPjWy8wuqhGATeca+EL/10=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E9SMhijXBgkLBoaeF/yf2b9LYZxoyzM61ERvykZWCZIu6GBHC2prQTCLHT581ACfz8vOVF9ZvzF8VLxwV0sjAr9VbVT6nEnlVLoB+LR0b6T9VE/GnDA07POTGr22RX1SNh+lBWlEFWFf81gJ+MkpcpGl5a5MHix8cNYEx7NHw14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B20gQ3kE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K7zZlvJ8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UAsvnb009387;
	Fri, 30 May 2025 13:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K0FUQ3/58+IKZailxVu4/XPo/OfegMJF0mQE3qS8fZ0=; b=
	B20gQ3kEbm2pD8eQpmYavNzCuaT1bYOWTUyV4NCL99+2TTFameDALHjdlOJus1WX
	y9zq0YU+yqgaCmb5zbw1Q+ftptWB4ZDE/vZyk0nRz7uZxytiZQILDgdCg5MNucHD
	r0qdDM1lHHNaC52r74NEhMXQm+tEdYOLlvfS4yYHck4qLSEJg2haTRi4HDzMkKmm
	j/cHufyrWnd6Djkncstg+i2sTodY7lSSIUKI40ZHx494o7tS5z24mfx58CMdsgJN
	ejbdX4rMXx5JthYGzKnQyVUgiq7tA/tVRk4w4A9x2jxAy43Wl5L40Wxv5DUuKN3i
	2fUOndygJB29kVwn3tzDHw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2jbvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 13:43:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54UD4W3G026722;
	Fri, 30 May 2025 13:43:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jd9k9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 13:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atHHZf+20vb+AB7IiGxuPEMp5+lu5pKFI3wak+2pkxbbonCJVmzmr4Y64rl8G9/EAY2mKGwmcMH4FjXg/aHrxhXxlLEt9ex51VNgyuIMmb2XjxdFCKup9h1cWoLu+99rEGYoIRASKdXU6eInrEdJCy0DFz5Bwn41cT0HImGQ8qgsp+jmLO+EImzg9pO1VKUdff0sjliPmGnLhOTMGlkX7PQxNGNLyT+6yvNkQ4xKKzZGNL6f2dZvfF0J7okLoRAtNHefJ8UZUuL1ONgVygUSabVC0leKF0TTPnCDf6hmNOQQ0AZcDcoiT5s19Im2fRJ7B6adgItQLCnlQ1+ZB7DNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0FUQ3/58+IKZailxVu4/XPo/OfegMJF0mQE3qS8fZ0=;
 b=n/SfrDpqfcm2IebjH6H0n9sgoHh5tjywBF+bEBCUoW453m1jCHktbujRuUZrKwLVtq9fLStJb/S/A0oa9wzrEbrGJYdo2hCmMPfUaEfHRsA0Wkvh2pm92OIJE6V4HDuYPAd9QO4Oy2QQxbU0C+lupmoPDftiDEbpCHRLSENkYL1Z+y9eBX+YANetbLDzCcp1m4AKGPwFWovoXwzkj5K8Z9M6wWXGZbsJPR2nEJfmaXyM3LvOE81Pqo6y2W8tMpnV1ebv0HrqbCwgU1t2JMqJG3j2W7VGytiBHqYD3xhmG0B4e7WadTJ9j0BbG/3I2Sbu1wa7Lj7aL2eWSQwaLke0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0FUQ3/58+IKZailxVu4/XPo/OfegMJF0mQE3qS8fZ0=;
 b=K7zZlvJ85vpofU1Riw3FMULhWPVmJ6OryAHQZyL2rryjBDY0mQ0aqNWt5/JWBXMUO/n7rfKA2QEvntQy8xvJwFD9mT+BM2O/q6Nu44MO8wzfg3geQimMlv0ObW8SG5JsrOMVCfprb6ffdyqHYz7yP/7KhC3ORfsDQ7jtLCex+/0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4181.namprd10.prod.outlook.com (2603:10b6:610:ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Fri, 30 May
 2025 13:43:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8746.035; Fri, 30 May 2025
 13:43:47 +0000
Message-ID: <fe381f90-eecc-4909-abae-205a369e6121@oracle.com>
Date: Fri, 30 May 2025 09:43:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: `rcu: INFO: rcu_sched self-detected stall on CPU` and spinning
 kworker `rpciod`
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-nfs@vger.kernel.org, it+linux-nfs@molgen.mpg.de,
        Jeff Layton <jlayton@kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>
References: <76a841e5-4e3d-4942-9a4b-24f87d6b79a5@molgen.mpg.de>
 <ZqVjVEV5IF_vz4Eq@eldamar.lan>
 <47222A7B-6B89-4260-AA16-EA7E7EAFBD68@oracle.com>
 <ZqjaX_uJqsJiCpam@eldamar.lan>
 <7ccb2a39-bb32-47f8-8366-b4d09895593f@molgen.mpg.de>
 <ZsBhuwLnejLo6iip@eldamar.lan>
 <6BEEE588-B7B0-40C0-BE91-4919A71ED052@oracle.com>
 <Z5z3hBaZtUM0BQ1H@eldamar.lan> <Z590k-vpFiGl0OOZ@eldamar.lan>
 <196a87b2-94ce-46bc-b6a0-c9c65f4ab34c@oracle.com>
 <747af7d6caf2ac79d828b8299e0db23c5a1824b2.camel@kernel.org>
 <32831df4-ca9e-4069-b18a-9e2bb700dd27@molgen.mpg.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <32831df4-ca9e-4069-b18a-9e2bb700dd27@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:610:4d::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: 120faaae-57ae-49fb-5306-08dd9f800076
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SURBSzJVQUdmNDlRc05IcXhobEc5cWJjTjdSQVJtMnBKNExJTGtoa1ZoU0ZZ?=
 =?utf-8?B?M2xLb2tlWWZNQXlDekxkOVNRWjlKclExZmJidVdrRmF0aGxZQUg3bkR5em56?=
 =?utf-8?B?bkxNNXNDMXFwdkFtODZBQ09SMjBrVDJnY0pIQVdPQmRDOFFReStBVTlSYU14?=
 =?utf-8?B?YkN5T0NFR0N3cVJNNGZ2WkJUMjFkdjRnK2NDN2U3N2FTK0d4OXZUMjdLUVpF?=
 =?utf-8?B?cnVRRnhWNit2UzdsNURRaUNwSXhNZE5UMUtlVEp0SUV0VFZQRzl4VjRiazFH?=
 =?utf-8?B?aUk4ZmtzUkF0dytLSHUrMjdaR0U1L3d0WFpGVzlZc1FRK3pzenNSNnFmdFMy?=
 =?utf-8?B?SFN6c0MraW5Qa0VhcEVFbnV0NmN0U0JwSXM3NFFvSk9zRTlhSEFsYWNaenZC?=
 =?utf-8?B?eGZhN0pucFl6MUt1enE0MUd2ZXdreGlGWHdOSXRIRDFnMnorMXB5c09qSWM4?=
 =?utf-8?B?MS9aZkk4UVNDcTNoYmRUSjJ3R2dvWGF6c1Q5MXE3QnpnZ1JUWTBpQ2dMUEdX?=
 =?utf-8?B?SVJwd0ZXaC9VWGc0NGVzbG9WRFZzejRpRSs5QWZyT0JxbmltdzRSNXZNQS9Y?=
 =?utf-8?B?SFZUZjdHV2NzSGpIM3p2MjR3RkIwakYwa3NLSFI1NnFjWHVDVzBYeUVjYWJO?=
 =?utf-8?B?ZTBxVmJib2Y0ZmNpYVhrMVRkTi9zRXlKMzBTN1FxdG0rNTRTeGQ3KzBmNTdx?=
 =?utf-8?B?MU4zRGFRSDBqZkJFREdwT2JkcHVjY25qYzRuenVuQTJKc2VhZUtDMXNRRklU?=
 =?utf-8?B?WDBxdTBON2g4TDFOZVlERzF5QkljbktEdXF2dXRtV2pZdlJ3cTM5V2tIcFJH?=
 =?utf-8?B?YlRGTURwRzIvZDA4RzhRN0NMU3d0NW1xT3JYajZNYW03eTZEZjRhSmZvelY4?=
 =?utf-8?B?bzRvb2N0N21YMjdXZExiOHRyS2xFeS9hWk1CWE1ZY2dpTVc4UTVrek5ZS0NN?=
 =?utf-8?B?K2JUZlQwQzFUMktGV2t5V2tiTEE5MU9jdStJMWlVUWRCc0VDVnJzdFc2NkQr?=
 =?utf-8?B?RVkxaXlEbzkweHF3aDhrQ1IrcTJqTjg2K0M2WVBEd3FjTDNpOElyZzdjRXR0?=
 =?utf-8?B?YkFtdHg4ZHJqR0JEMmJjcmM5MlVRRytkZ2trU2cxVzVqeUVjaDE3cWtVWlpz?=
 =?utf-8?B?bjhDM1ZnVTA0eExXQmtKWXBiTkh6MFpJR0wxZU5mQUI2dGE2ZW9Ld2FaTWJL?=
 =?utf-8?B?UE05UzJicUsxZk1IbDRTQWtqT0FnaUgvV1gyTWRlbUFCUW9Rb1dEaEgzL0JE?=
 =?utf-8?B?N3Q4YTNTaGppTGwvQTRlTHBtU244TnNlVWpURVhJdjg3czVuVnlYa0pkQUJK?=
 =?utf-8?B?NVZLNERKRWd1c2d4c3pEM21NUFNQZHAxS3BUVVZhaWxoTnBSOVBVZFJNcGJs?=
 =?utf-8?B?VVRweWRTalUzQ2JteUF2dDNMSmNvbm9VWnBMUzV1bGdueldRelY5L1dHRHls?=
 =?utf-8?B?ZmRmOCtVa2t3dnpIc0crR2lHQVJzZjd6Ymlpa3h1TEhWbE5Rc0gwSU1DR2t6?=
 =?utf-8?B?SnEwZUJvQTBza1pEaWFjS2xZUVg2L1hyVFNMbm1zR0pvR0JEcE8wVTBrTWJB?=
 =?utf-8?B?cmdJQVBQK3dpdjA1R0lGQk02THFsS2pSdnI0b1BCSDNlNllvLzlyN0FyazVz?=
 =?utf-8?B?YlBoSGVkMW9jUGFxeGh5TmNxdVhSRnR4L21qSzFya3l6Rjd4ckJFd2ZXa0h4?=
 =?utf-8?B?dTVKMVNjTnVKWHNjSUVrRTk4UGxoU1MwSzZScVcxUTh0bTdldnRSWDNLN1B3?=
 =?utf-8?B?eEtTUGhsZXA5T0ZWcnkyR3kzNGhYblgyUVlYRjMrdlFTNEVqZVppemM4MUN4?=
 =?utf-8?B?SEpkTkp0OHBTb0V0c3FOQ3RPaWsxdE5RM2c0YTI5NnZwSWIvN3FyaUh3WlQ2?=
 =?utf-8?B?WTNtQlhrMzNRTjRmalBWYms2ZzdwaWJiektuMC9jNWh4MTIvNEFia3d6QXJR?=
 =?utf-8?Q?F0PkqpgosnM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ckR6ZDJUQ04vL0pGL0FoMlE2ZHBLd2JpekpNZ3Q1OXAzc0FCZFhRT3pBZGxV?=
 =?utf-8?B?UUZ1ZHMxeUp1V1BlTVYvUXNPaHc1d2Z3cGo5aThRMVBkVWNsU3VnOXErcUpH?=
 =?utf-8?B?OFZuRHNtRFV3b2Evd2o2Y2V4SFhPK1cvdGgvWTBSVmJKWVVjYldrT0QyZERY?=
 =?utf-8?B?UjVncGVHTUVGWlRLeHdua2VFSktpektCTmFEZVhLdm5uQjVhM1FoTzJFZm4w?=
 =?utf-8?B?QUdGTTBiOVJXanNGWVJLSGhCQUs4UmdXSWlrZGhtQW93dUtaK041ck90cGhQ?=
 =?utf-8?B?V2lUQXZrd1VUelE0YkZWNFQzbjY1Q0pKN1JhNEZzakxLRUo4dUpJTUs4U3k1?=
 =?utf-8?B?ZG05cmI0VWV2OWtFR2ZjL0hzd1plcFpla0FqZS9sMkhrOW8vRU50dnZSYTVi?=
 =?utf-8?B?eW9XaHJvT1BkUExuMlN1d0lQNE5kMFowQmIzTE5NRENWdC9sMmE5bmlJRndW?=
 =?utf-8?B?RTQ1NWE3bnVCSytZVjJwbzBIU1RNTHFKdVNWcVk1WGVIZU0xR2JxNXEzL3RE?=
 =?utf-8?B?dmJDQWtwT20xZmZyaHRSemVjUmNMcTJzckh6RVVZQVVSMzBxaEt1SU5obnRU?=
 =?utf-8?B?Y2FGaGFlc1RLRTA1RHM1UU5zM2p3a1NqMFhCN2tmYmhCTU9lSCtXd0U0czZx?=
 =?utf-8?B?R0pTSU5vZ0dvZjN0WklxenQrcE54Qmsra0I1d2NUUmwrbzlxS1dSYzZVOHJY?=
 =?utf-8?B?YnZNREZnUlJFQzk2NXhxdi9NYUlOVm9iQkFFT1NuaWlqRmtETFA2NGZxRFBB?=
 =?utf-8?B?SC9IWjdhS1JqRzRiMTJRbXFkU29YK0MvdWg5Um9aSHlnU0NLSTZ6RFVmWmg3?=
 =?utf-8?B?cUppUGMzdzYySDZTY2JLdUpEbmtPZ0dtV2doL1dnb2xseGlnNDUxcWw2Y0l4?=
 =?utf-8?B?RFJXeHh6ZDhYRXhzY0NZdmdHaDd1Y0N1RmdYUHcwTzNmalhVK2UxYTV0SktH?=
 =?utf-8?B?aFJ0d3JpRlN2cldaeVU5a3RUaHI4Q2pCRUdtOVBXaUlDa0U1ZDFNVWY5U202?=
 =?utf-8?B?MjdWRHU1a1NoNUhRYmI3VEdoZk1PUURuTlBmcW05Yk9nc3JLblZDK2VGQUoy?=
 =?utf-8?B?NlZBbCtUOFBRS1dIcTJQbkUrdHhMaWtNOXU0SVZ5ZFdRWndKMm9YTHA0MzJI?=
 =?utf-8?B?bDRCRVNFZ3NreTlsazBrNmswN2FGZCtEWUNDYlNUd3g1M1E5bUhtMVBvNE55?=
 =?utf-8?B?SVFxL0xYT3RZWmtDVS94TncyZkhRUkZ4bzJyYmxMZ3pib3d1SEQ2ckRlRlVF?=
 =?utf-8?B?Ly9wdEhEWFd6Z3BJbkhsc1QyM1VXK2I5ZVQ2Mnl0QXdCTm5pNWFtdHlPY240?=
 =?utf-8?B?ejV3R0R3bVpOa3hYUDJiV2NZckh6YjZrWUtac1lYN0dBbTMyOHpmSk9VODBI?=
 =?utf-8?B?Ny9OUHc5ZXBEbUQ3UDhLcHAyL3NnQ1BzajliOFNlSlBaTnVabzEzNHFtcWNX?=
 =?utf-8?B?alZJcktOT3RkWWdTY3pDd0FBaDFJSVJpdjU5SnRUK3VrQ2ZMUHJVRFZ3bzVm?=
 =?utf-8?B?dS92bU45dS9jT3lkWmY5MmlFWmM5VTluUzQxeUlHYXByeVBGNXhtdnRSblVw?=
 =?utf-8?B?OU8vbGxOM2M1ZkIxVWpqc3VBRzd2bEh4b213SnozSnFsNDRRY3FsVm9LWFNT?=
 =?utf-8?B?aW1QeG5rYlFlMHBJK0lHNEY5Z0JsSVFYV0VQdVNsZ0R3TUgxSmhNM1NLL1NP?=
 =?utf-8?B?Y01jdXlIQ29IdGR5d09pN3ZLQ0haRnlKNWI5dWlyZWxKQ0VnQjB2Yi94cUxJ?=
 =?utf-8?B?YTdmbVJNeVZFeHgzaTJkVURsZjhHbW5CbXdPZzhRbHJzVzJZL3VMbmNXcjNw?=
 =?utf-8?B?OFpidUo0SS96TUNwZW0rK2Jacks4Qk4wZ1lWMnRPRTZ3SFQ4Y2N0NTA2RG5h?=
 =?utf-8?B?Q0dNb1RuR0tMMUxmVkpLeXhzUGpidHJUU09TUUlQUXE2ZndydndmUnEwTmUx?=
 =?utf-8?B?NTlSZlBXZDRGOHBuY1U4RnhsS1B2TVlDcnhsOTl1M3hWaW5yYWpLSmMxbVli?=
 =?utf-8?B?Y0hyT1ZHWXU5cmJ6aGlabnNxR21pZmh6ZGkzUmpGR0M2VU8vVFNCVFBsR0t2?=
 =?utf-8?B?eWlTajZsbWV2bk1sS2R3bVU0RDUwQUQ0UUsyT0xlK3hnUktDeU9XaWZqL1ZB?=
 =?utf-8?Q?BCsN3EQH4JM//CnhxxGhVCTAA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2qpKcVPGMLZL6Uh0t6q5EZXW6nOfadbk8Ztni22TAB+JQHZ13Y3iBRJZHZ2I4yUCCXCnN7WomINlep1skvC57Q2npo8Q73F0dMG+7P5XS0Syud3PU+af90zYaW5Z1x01hKrn0528WgPKC3AwpONYOO7aqZHqAo2KMW4JFFKywuSE56WEIuIprCiEOuLR28LhrRYmW9Ybd9KQ/s+dc50/iu3qQ045anbquCytz/JgyKgNCDgLL+jAzA7YRBqz88mr8CqusqAJrm4DPKRk008HGmNNhjsrPq0NX9+wLJmidx1nlT2l5HDaDeHa2kskiWwPZLZx7j3zYBtn23IRp39L4RdrL8lbFUf9uvjU7AUbOs7lDQGiAHoSA7EkWgowLZqj/f69JTHdmv17oHWN7N8SDT9rOcCnMJpUznQgRIoW9/XDNebtp6a5dOwcaC1NHYNY9Bm6NZGAG6Wn/9Zb3HZ7S8bexxhu0nNZmTuMwpqrMVHV5+X0Msh38r/eQ7EP/WIvgOW4N6QZJQOmJHATv1052FRa/NI/7slLFF96ro3ynnryVPDjBTgDbjfDZKbMAk/d9OCbhMAlDnbNPXw25GjhZ0ytiLv1BFBMFQ7mgNd1/80=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120faaae-57ae-49fb-5306-08dd9f800076
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 13:43:47.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elbUcUgbQU73k9rZ5at30lGgwborLC407kHz2AZUQmeqKDXMdUYBk92YgNftvCbxAV4qcQH5GuN+jGSJWGQLiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDEyMCBTYWx0ZWRfX6OYT9GI6C/yY UtIfqZuvI49sIC7hPAFHKV1hENqa2d+LEg2XcO2pJSSz2P+WWEZjmIoUCeE8Q/DW2XgmB7wkUIl 0KyhruQAJoR/J49LuCSntQQ+CPvJUD/ezJ4aigzM9GS2pCj+p1cF7a4zcXWaZea/gPwwatPibNb
 7oK2MxpZkLIqiGGrhN+7AqBw+h+dzQ3PTXrx7fO4XOhqpGIJnRDv1b1vWe5mrcsxNMvPwfGYQYD U4mjjQGb1fgHcrOsurm6Jy/uibaqWJ//V7xT2++LL4xEtmLC+40sbdakgtrVcANcvdcmuP+7Afa +8kdiyTxtFPKt646ircBBfXNq5CQT24hdnDoXasK0cNFSNG2FimjpJIxKzraUCyj0hnUIvNZN7a
 OKcaZHfmLDk2y9nkdrJn2tnwMNbh6AWLV1Odm5BHEhJvB4X9+Cikz7PBhAzeKC4FqcKNTgtl
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=6839b61d b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=xNf9USuDAAAA:8 a=yPCof4ZbAAAA:8 a=i9YpJUE8ZMrppMjt_7UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7GvZVjTvG2yIfwUL5gmzo18XcfEZKaSQ
X-Proofpoint-GUID: 7GvZVjTvG2yIfwUL5gmzo18XcfEZKaSQ

On 5/26/25 12:31 PM, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Sorry for being unresponsive for so long.
> 
> 
> Am 02.02.25 um 17:51 schrieb Jeff Layton:
>> On Sun, 2025-02-02 at 11:18 -0500, Chuck Lever wrote:
>>> On 2/2/25 8:35 AM, Salvatore Bonaccorso wrote:
> 
>>>> On Fri, Jan 31, 2025 at 05:17:08PM +0100, Salvatore Bonaccorso wrote:
> 
>>>>> On Sat, Aug 17, 2024 at 02:52:38PM +0000, Chuck Lever III wrote:
>>>>>>
>>>>>>> On Aug 17, 2024, at 4:39 AM, Salvatore Bonaccorso
>>>>>>> <carnil@debian.org> wrote:
>>>>>>>
>>>>>>>
>>>>>>> On Tue, Jul 30, 2024 at 02:52:47PM +0200, Paul Menzel wrote:
> 
>>>>>>>> Am 30.07.24 um 14:19 schrieb Salvatore Bonaccorso:
>>>>>>>>
>>>>>>>>> On Sat, Jul 27, 2024 at 09:19:24PM +0000, Chuck Lever III wrote:
>>>>>>>>>>
>>>>>>>>>>> On Jul 27, 2024, at 5:15 PM, Salvatore Bonaccorso
>>>>>>>>>>> <carnil@debian.org> wrote:
>>>>>>>>
>>>>>>>>>>> On Wed, Jul 17, 2024 at 07:33:24AM +0200, Paul Menzel wrote:
>>>>>>>>
>>>>>>>>>>>> Using Linux 5.15.160 on a Dell PowerEdge T440/021KCD, BIOS
>>>>>>>>>>>> 2.11.2
>>>>>>>>>>>> 04/22/2021, a mount from another server hung. Linux logs:
>>>>>>>>>>>>
>>>>>>>>>>>> ```
>>>>>>>>>>>> $ dmesg -T
>>>>>>>>>>>> [Wed Jul  3 16:39:34 2024] Linux version
>>>>>>>>>>>> 5.15.160.mx64.476(root@theinternet.molgen.mpg.de) (gcc (GCC)
>>>>>>>>>>>> 12.3.0, GNU ld (GNU Binutils) 2.41) #1 SMP Wed Jun 5
>>>>>>>>>>>> 12:24:15 CEST 2024
>>>>>>>>>>>> [Wed Jul  3 16:39:34 2024] Command line: root=LABEL=root ro
>>>>>>>>>>>> crashkernel=64G-:256M console=ttyS0,115200n8 console=tty0
>>>>>>>>>>>> init=/bin/systemd audit=0 random.trust_cpu=on
>>>>>>>>>>>> systemd.unified_cgroup_hierarchy
>>>>>>>>>>>> […]
>>>>>>>>>>>> [Wed Jul  3 16:39:34 2024] DMI: Dell Inc. PowerEdge
>>>>>>>>>>>> T440/021KCD, BIOS 2.11.2 04/22/2021
>>>>>>>>>>>> […]
>>>>>>>>>>>> [Tue Jul 16 06:00:10 2024] md: md3: data-check interrupted.
>>>>>>>>>>>> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got
>>>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ee580afa
>>>>>>>>>>>> xid 6890a3d2
>>>>>>>>>>>> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got
>>>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000d4d84570
>>>>>>>>>>>> xid 3ca4017a
>>>>>>>>
>>>>>>>> […]
>>>>>>>>
>>>>>>>>>>>> [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got
>>>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000028481e8f
>>>>>>>>>>>> xid b682b676
>>>>>>>>>>>> [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got
>>>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000c384ff38
>>>>>>>>>>>> xid b5d5dbf5
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] rcu: INFO: rcu_sched self-
>>>>>>>>>>>> detected stall on CPU
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] rcu:  13-....: (20997 ticks this
>>>>>>>>>>>> GP) idle=54f/1/0x4000000000000000 softirq=31904928/31904928
>>>>>>>>>>>> fqs=4433
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  (t=21017 jiffies g=194958993
>>>>>>>>>>>> q=5715)
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] Task dump for CPU 13:
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] task:kworker/u34:2   state:R 
>>>>>>>>>>>> running task stack:    0 pid:30413 ppid:     2 flags:0x00004008
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] Workqueue: rpciod
>>>>>>>>>>>> rpc_async_schedule [sunrpc]
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] Call Trace:
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  <IRQ>
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  sched_show_task.cold+0xc2/0xda
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  rcu_dump_cpu_stacks+0xa1/0xd3
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  rcu_sched_clock_irq.cold+0xc7/0x1e7
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? trigger_load_balance+0x6d/0x300
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? scheduler_tick+0xda/0x260
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  update_process_times+0xa1/0xe0
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  tick_sched_timer+0x8e/0xa0
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? tick_sched_do_timer+0x90/0x90
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  __hrtimer_run_queues+0x139/0x2a0
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  hrtimer_interrupt+0xf4/0x210
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] 
>>>>>>>>>>>> __sysvec_apic_timer_interrupt+0x5f/0xe0
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] 
>>>>>>>>>>>> sysvec_apic_timer_interrupt+0x69/0x90
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  </IRQ>
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  <TASK>
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] 
>>>>>>>>>>>> asm_sysvec_apic_timer_interrupt+0x16/0x20
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] RIP: 0010:read_tsc+0x3/0x20
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] Code: cc cc cc cc cc cc cc 8b 05
>>>>>>>>>>>> 56 ab 72 01 c3 cc cc cc cc 0f 1f 44 00 00 c3 cc cc cc cc 66
>>>>>>>>>>>> 66 2e 0f 1f 84 00 00 00 00 00 0f 01 f9 <66> 90 48 c1 e2 20
>>>>>>>>>>>> 48 09 d0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] RSP: 0018:ffffc900087cfe00
>>>>>>>>>>>> EFLAGS: 00000246
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] RAX: 00000000226dc8b8 RBX:
>>>>>>>>>>>> 000000003f3c079e RCX: 000000000000100d
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] RDX: 00000000004535c4 RSI:
>>>>>>>>>>>> 0000000000000046 RDI: ffffffff82435600
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] RBP: 0003ed08d3641da3 R08:
>>>>>>>>>>>> ffffffffa012c770 R09: ffffffffa012c788
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] R10: 0000000000000003 R11:
>>>>>>>>>>>> 0000000000000283 R12: 0000000000000000
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024] R13: 0000000000000001 R14:
>>>>>>>>>>>> ffff88909311c000 R15: ffff88909311c005
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ktime_get+0x38/0xa0
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ?
>>>>>>>>>>>> rpc_sleep_on_priority+0x70/0x70 [sunrpc]
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  rpc_exit_task+0x9a/0x100 [sunrpc]
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  __rpc_execute+0x6e/0x410 [sunrpc]
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  rpc_async_schedule+0x29/0x40
>>>>>>>>>>>> [sunrpc]
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  process_one_work+0x1d7/0x3a0
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  worker_thread+0x4a/0x3c0
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? process_one_work+0x3a0/0x3a0
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  kthread+0x115/0x140
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ? set_kthread_struct+0x50/0x50
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  ret_from_fork+0x1f/0x30
>>>>>>>>>>>> [Tue Jul 16 11:36:40 2024]  </TASK>
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] rcu: INFO: rcu_sched self-
>>>>>>>>>>>> detected stall on CPU
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] rcu:  7-....: (21000 ticks this
>>>>>>>>>>>> GP) idle=5b1/1/0x4000000000000000 softirq=29984492/29984492
>>>>>>>>>>>> fqs=5159
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  (t=21017 jiffies g=194959001
>>>>>>>>>>>> q=2008)
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] Task dump for CPU 7:
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] task:kworker/u34:2   state:R 
>>>>>>>>>>>> running task stack:    0 pid:30413 ppid:     2 flags:0x00004008
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] Workqueue: rpciod
>>>>>>>>>>>> rpc_async_schedule [sunrpc]
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] Call Trace:
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  <IRQ>
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  sched_show_task.cold+0xc2/0xda
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  rcu_dump_cpu_stacks+0xa1/0xd3
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  rcu_sched_clock_irq.cold+0xc7/0x1e7
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? trigger_load_balance+0x6d/0x300
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? scheduler_tick+0xda/0x260
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  update_process_times+0xa1/0xe0
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  tick_sched_timer+0x8e/0xa0
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? tick_sched_do_timer+0x90/0x90
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  __hrtimer_run_queues+0x139/0x2a0
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  hrtimer_interrupt+0xf4/0x210
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] 
>>>>>>>>>>>> __sysvec_apic_timer_interrupt+0x5f/0xe0
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] 
>>>>>>>>>>>> sysvec_apic_timer_interrupt+0x69/0x90
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  </IRQ>
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  <TASK>
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] 
>>>>>>>>>>>> asm_sysvec_apic_timer_interrupt+0x16/0x20
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] RIP: 0010:_raw_spin_lock+0x10/0x20
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] Code: b8 00 02 00 00 f0 0f c1 07
>>>>>>>>>>>> a9 ff 01 00 00 75 05 c3 cc cc cc cc e9 f0 05 59 ff 0f 1f 44
>>>>>>>>>>>> 00 00 31 c0 ba 01 00 00 00 f0 0f b1 17 <75> 05 c3 cc cc cc
>>>>>>>>>>>> cc 89 c6 e9 62 02 59 ff 66 90 0f 1f 44 00 00 fa
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] RSP: 0018:ffffc900087cfe30
>>>>>>>>>>>> EFLAGS: 00000246
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] RAX: 0000000000000000 RBX:
>>>>>>>>>>>> ffff88997131a500 RCX: 0000000000000001
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] RDX: 0000000000000001 RSI:
>>>>>>>>>>>> ffff88997131a500 RDI: ffffffffa012c700
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] RBP: ffffffffa012c700 R08:
>>>>>>>>>>>> ffffffffa012c770 R09: ffffffffa012c788
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] R10: 0000000000000003 R11:
>>>>>>>>>>>> 0000000000000283 R12: ffff88997131a530
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024] R13: 0000000000000001 R14:
>>>>>>>>>>>> ffff88909311c000 R15: ffff88909311c005
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  __rpc_execute+0x95/0x410 [sunrpc]
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  rpc_async_schedule+0x29/0x40
>>>>>>>>>>>> [sunrpc]
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  process_one_work+0x1d7/0x3a0
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  worker_thread+0x4a/0x3c0
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? process_one_work+0x3a0/0x3a0
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  kthread+0x115/0x140
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ? set_kthread_struct+0x50/0x50
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  ret_from_fork+0x1f/0x30
>>>>>>>>>>>> [Tue Jul 16 11:37:19 2024]  </TASK>
>>>>>>>>>>>> [Tue Jul 16 11:37:57 2024] rcu: INFO: rcu_sched self-
>>>>>>>>>>>> detected stall on CPU
>>>>>>>>>>>> […]
>>>>>>>>>>>> ```
>>>>>>>>>>>
>>>>>>>>>>> FWIW, on one NFS server occurence we are seeing something
>>>>>>>>>>> very close
>>>>>>>>>>> to the above but in the 5.10.y case for the Debian kernel after
>>>>>>>>>>> updating to 5.10.218-1 to 5.10.221-1, so kernel after which
>>>>>>>>>>> had the
>>>>>>>>>>> big NFS related stack backported.
>>>>>>>>>>>
>>>>>>>>>>> One backtrace we were able to catch was
>>>>>>>>>>>
>>>>>>>>>>> [...]
>>>>>>>>>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got
>>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 000000003d26f7ec
>>>>>>>>>>> xid b172e1c6
>>>>>>>>>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got
>>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000017f1552a
>>>>>>>>>>> xid a90d7751
>>>>>>>>>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got
>>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 000000006337c521
>>>>>>>>>>> xid 8e5e58bd
>>>>>>>>>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got
>>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000cbf89319
>>>>>>>>>>> xid c2da3c73
>>>>>>>>>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got
>>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000e2588a21
>>>>>>>>>>> xid a01bfec6
>>>>>>>>>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got
>>>>>>>>>>> unrecognized reply: calldir 0x1 xpt_bc_xprt 000000005fda63ca
>>>>>>>>>>> xid c2eeeaa6
>>>>>>>>>>> [...]
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: rcu: INFO: rcu_sched self-
>>>>>>>>>>> detected stall on CPU
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: rcu:         15-....: (5250
>>>>>>>>>>> ticks this GP) idle=74e/1/0x4000000000000000
>>>>>>>>>>> softirq=3160997/3161006 fqs=2233
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:         (t=5255 jiffies
>>>>>>>>>>> g=8381377 q=106333)
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: NMI backtrace for cpu 15
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: CPU: 15 PID: 3725556 Comm:
>>>>>>>>>>> kworker/u42:4 Not tainted 5.10.0-31-amd64 #1 Debian 5.10.221-1
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: Hardware name: DALCO AG
>>>>>>>>>>> S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559
>>>>>>>>>>> 03/19/2019
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: Workqueue: rpciod
>>>>>>>>>>> rpc_async_schedule [sunrpc]
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: Call Trace:
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  <IRQ>
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  dump_stack+0x6b/0x83
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>>> nmi_cpu_backtrace.cold+0x32/0x69
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ?
>>>>>>>>>>> lapic_can_unplug_cpu+0x80/0x80
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>>> nmi_trigger_cpumask_backtrace+0xdf/0xf0
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  rcu_dump_cpu_stacks+0xa5/0xd7
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>>> rcu_sched_clock_irq.cold+0x202/0x3d9
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ?
>>>>>>>>>>> trigger_load_balance+0x5a/0x220
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>>> update_process_times+0x8c/0xc0
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  tick_sched_handle+0x22/0x60
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  tick_sched_timer+0x65/0x80
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ?
>>>>>>>>>>> tick_sched_do_timer+0x90/0x90
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>>> __hrtimer_run_queues+0x127/0x280
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  hrtimer_interrupt+0x110/0x2c0
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>>> __sysvec_apic_timer_interrupt+0x5c/0xe0
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>>> asm_call_irq_on_stack+0xf/0x20
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  </IRQ>
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>>> sysvec_apic_timer_interrupt+0x72/0x80
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>>> asm_sysvec_apic_timer_interrupt+0x12/0x20
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RIP:
>>>>>>>>>>> 0010:mod_delayed_work_on+0x5d/0x90
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: Code: 00 4c 89 e7 e8 34 fe
>>>>>>>>>>> ff ff 89 c3 83 f8 f5 74 e9 85 c0 78 1b 89 ef 4c 89 f1 4c 89
>>>>>>>>>>> e2 4c 89 ee e8 f9 fc ff ff 48 8b 3c 24 57 9d <0f> 1f 44 >
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RSP: 0018:ffffb5efe356fd90
>>>>>>>>>>> EFLAGS: 00000246
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RAX: 0000000000000000 RBX:
>>>>>>>>>>> 0000000000000000 RCX: 000000003820000f
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RDX: 0000000038000000 RSI:
>>>>>>>>>>> 0000000000000046 RDI: 0000000000000246
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: RBP: 0000000000002000 R08:
>>>>>>>>>>> ffffffffc0884430 R09: ffffffffc0884448
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: R10: 0000000000000003 R11:
>>>>>>>>>>> 0000000000000003 R12: ffffffffc0884428
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: R13: ffff8c89d0f6b800 R14:
>>>>>>>>>>> 00000000000001f4 R15: 0000000000000000
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>>> __rpc_sleep_on_priority_timeout+0x111/0x120 [sunrpc]
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  rpc_delay+0x56/0x90 [sunrpc]
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  rpc_exit_task+0x5a/0x140
>>>>>>>>>>> [sunrpc]
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ?
>>>>>>>>>>> __rpc_do_wake_up_task_on_wq+0x1e0/0x1e0 [sunrpc]
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  __rpc_execute+0x6d/0x410
>>>>>>>>>>> [sunrpc]
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel: 
>>>>>>>>>>> rpc_async_schedule+0x29/0x40 [sunrpc]
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  process_one_work+0x1b3/0x350
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  worker_thread+0x53/0x3e0
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ?
>>>>>>>>>>> process_one_work+0x350/0x350
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  kthread+0x118/0x140
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ?
>>>>>>>>>>> __kthread_bind_mask+0x60/0x60
>>>>>>>>>>> Jul 27 15:25:15 nfsserver kernel:  ret_from_fork+0x1f/0x30
>>>>>>>>>>> [...]
>>>>>>>>>>>
>>>>>>>>>>> Is there anything which could help debug this issue?
>>>>>>>>>>
>>>>>>>>>> The backtrace suggests an issue in the RPC client code; the
>>>>>>>>>> server's NFSv4.1 backchannel would use that to send callbacks.
>>>>>>>>>>
>>>>>>>>>> Since 5.10.218 and 5.10.221 are only about a thousand commits
>>>>>>>>>> apart, a bisect should be quick and narrow down the issue to
>>>>>>>>>> one or two commits.
>>>>>>>>>
>>>>>>>>> Yes indeed. Unfortunately was yet unable to reproduce the issue in
>>>>>>>>> more syntentic way on test environment, and the affected server in
>>>>>>>>> particular is a production system.
>>>>>>>>>
>>>>>>>>> Paul, is your case in some way reproducible in a testing
>>>>>>>>> environment
>>>>>>>>> so that a bisection might be give enough hints on the problem?
>>>>>>>> We hit this issue once more on the same server with Linux
>>>>>>>> 5.15.160, and had
>>>>>>>> to hard reboot it.
>>>>>>>>
>>>>>>>> Unfortunately we did not have time yet to set up a test system
>>>>>>>> to find a
>>>>>>>> reproducer. In our cases a lot of compute servers seem to have
>>>>>>>> accessed the
>>>>>>>> NFS server. A lot of the many processes were `zstd` on a first
>>>>>>>> glance.
>>>>>>>
>>>>>>> So we neither, due to the nature of the server (production
>>>>>>> system) and
>>>>>>> unability to reproduce the issue under some more controlled way
>>>>>>> and on
>>>>>>> test environment.
>>>>>>>
>>>>>>> In our case users seems to cause workloads involving use of wandb.
>>>>>>>
>>>>>>> What we tried is to boot the recent kernel from 5.10.y series
>>>>>>> avaiable
>>>>>>> (5.10.223-1). Then the issue showed up still. Since we disabled
>>>>>>> fs.leases-enable the situation seems to be more stable). While this
>>>>>>> is/might not be the solution, does that gives some additional hits?
>>>>>>
>>>>>> The problem is backchannel-related, and disabling delegation
>>>>>> will reduce the number of backchannel operations. Your finding
>>>>>> comports with our current theory, but I can't think of how it
>>>>>> narrows the field of suspects.
>>>>>>
>>>>>> Is the server running short on memory, perhaps? One backchannel
>>>>>> operation that was added in v5.10.220 is CB_RECALL_ANY, which
>>>>>> is triggered on memory exhaustion. But that should be a fairly
>>>>>> harmless addition unless there is a bug in there somewhere.
>>>>>>
>>>>>> If your NFS server does not have any NFS mounts, then we could
>>>>>> provide instructions for enabling client-side tracing to watch
>>>>>> the details of callback traffic.
>>>>>
>>>>> The NFS server acts as well as NFS client, so tracing more
>>>>> back-channel related will I guess just load the tracing more.
>>>>>
>>>>> But we got "lucky" and we were able to trigger the issue twice in last
>>>>> days, once NFSv4 delegations were enabled again and some users started
>>>>> to cause more load on the specific server as well.
>>>>>
>>>>> I did issue
>>>>>
>>>>>     rpcdebug -m rpc -c
>>>>>
>>>>> before rebooting/resetting the server  which is
>>>>>
>>>>> Jan 30 05:27:05 nfsserver kernel: 26407 2281   -512 3d1fdb92       
>>>>> 0        0 79bc1aa5 nfs4_cbv1 CB_RECALL_ANY a:rpc_exit_task
>>>>> [sunrpc] q:delayq
>>>>>
>>>>> and the first RPC related soft lookup slapt in the log/journal I was
>>>>> able to gather is:
>>>>>
>>>>> Jan 29 22:34:05 nfsserver kernel: watchdog: BUG: soft lockup -
>>>>> CPU#11 stuck for 23s! [kworker/u42:3:705574]
>>>>> Jan 29 22:34:05 nfsserver kernel: Modules linked in: binfmt_misc
>>>>> rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache bonding quota_v2
>>>>> quota_tree ipmi_ssif intel_rapl_msr intel_rapl_common skx_edac
>>>>> skx_edac_common nfit libnvdimm x86_pkg_temp_thermal
>>>>> intel_powerclamp coretemp kvm_intel kvm irqbypass
>>>>> ghash_clmulni_intel aesni_intel libaes crypto_simd cryptd ast
>>>>> glue_helper drm_vram_helper drm_ttm_helper rapl acpi_ipmi ttm
>>>>> iTCO_wdt intel_cstate ipmi_si intel_pmc_bxt drm_kms_helper mei_me
>>>>> iTCO_vendor_support ipmi_devintf cec ioatdma intel_uncore pcspkr
>>>>> evdev joydev sg i2c_algo_bit watchdog mei dca ipmi_msghandler
>>>>> acpi_power_meter acpi_pad button fuse drm configfs nfsd auth_rpcgss
>>>>> nfs_acl lockd grace sunrpc ip_tables x_tables autofs4 ext4 crc16
>>>>> mbcache jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq
>>>>> async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1
>>>>> raid0 multipath linear md_mod dm_mod hid_generic usbhid hid sd_mod
>>>>> t10_pi crc_t10dif crct10dif_generic xhci_pci ahci xhci_hcd libahci
>>>>> i40e libata
>>>>> Jan 29 22:34:05 nfsserver kernel:  crct10dif_pclmul arcmsr
>>>>> crct10dif_common ptp crc32_pclmul usbcore crc32c_intel scsi_mod
>>>>> pps_core i2c_i801 lpc_ich i2c_smbus wmi usb_common
>>>>> Jan 29 22:34:05 nfsserver kernel: CPU: 11 PID: 705574 Comm:
>>>>> kworker/u42:3 Not tainted 5.10.0-33-amd64 #1 Debian 5.10.226-1
>>>>> Jan 29 22:34:05 nfsserver kernel: Hardware name: DALCO AG S2600WFT/
>>>>> S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
>>>>> Jan 29 22:34:05 nfsserver kernel: Workqueue: rpciod
>>>>> rpc_async_schedule [sunrpc]
>>>>> Jan 29 22:34:05 nfsserver kernel: RIP: 0010:ktime_get+0x7b/0xa0
>>>>> Jan 29 22:34:05 nfsserver kernel: Code: d1 e9 48 f7 d1 48 89 c2 48
>>>>> 85 c1 8b 05 ae 2c a5 02 8b 0d ac 2c a5 02 48 0f 45 d5 8b 35 7e 2c
>>>>> a5 02 41 39 f4 75 9e 48 0f af c2 <48> 01 f8 48 d3 e8 48 01 d8 5b 5d
>>>>> 41 5c c3 cc cc cc cc f3 90 eb 84
>>>>> Jan 29 22:34:05 nfsserver kernel: RSP: 0018:ffffa1aca9227e00
>>>>> EFLAGS: 00000202
>>>>> Jan 29 22:34:05 nfsserver kernel: RAX: 0000371a545e1910 RBX:
>>>>> 000005fce82a4372 RCX: 0000000000000018
>>>>> Jan 29 22:34:05 nfsserver kernel: RDX: 000000000078efbe RSI:
>>>>> 000000000031f238 RDI: 00385c1353c92824
>>>>> Jan 29 22:34:05 nfsserver kernel: RBP: 0000000000000000 R08:
>>>>> ffffffffc081f410 R09: ffffffffc081f410
>>>>> Jan 29 22:34:05 nfsserver kernel: R10: 0000000000000003 R11:
>>>>> 0000000000000003 R12: 000000000031f238
>>>>> Jan 29 22:34:05 nfsserver kernel: R13: ffff8ed42bf34830 R14:
>>>>> 0000000000000001 R15: 0000000000000000
>>>>> Jan 29 22:34:05 nfsserver kernel: FS:  0000000000000000(0000)
>>>>> GS:ffff8ee94f880000(0000) knlGS:0000000000000000
>>>>> Jan 29 22:34:05 nfsserver kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>>>>> 0000000080050033
>>>>> Jan 29 22:34:05 nfsserver kernel: CR2: 00007ffddf306080 CR3:
>>>>> 00000017c420a002 CR4: 00000000007706e0
>>>>> Jan 29 22:34:05 nfsserver kernel: DR0: 0000000000000000 DR1:
>>>>> 0000000000000000 DR2: 0000000000000000
>>>>> Jan 29 22:34:05 nfsserver kernel: DR3: 0000000000000000 DR6:
>>>>> 00000000fffe0ff0 DR7: 0000000000000400
>>>>> Jan 29 22:34:05 nfsserver kernel: PKRU: 55555554
>>>>> Jan 29 22:34:05 nfsserver kernel: Call Trace:
>>>>> Jan 29 22:34:05 nfsserver kernel:  <IRQ>
>>>>> Jan 29 22:34:05 nfsserver kernel:  ? watchdog_timer_fn+0x1bb/0x210
>>>>> Jan 29 22:34:05 nfsserver kernel:  ?
>>>>> lockup_detector_update_enable+0x50/0x50
>>>>> Jan 29 22:34:05 nfsserver kernel:  ? __hrtimer_run_queues+0x127/0x280
>>>>> Jan 29 22:34:05 nfsserver kernel:  ? hrtimer_interrupt+0x110/0x2c0
>>>>> Jan 29 22:34:05 nfsserver kernel:  ?
>>>>> __sysvec_apic_timer_interrupt+0x5c/0xe0
>>>>> Jan 29 22:34:05 nfsserver kernel:  ? asm_call_irq_on_stack+0xf/0x20
>>>>> Jan 29 22:34:05 nfsserver kernel:  </IRQ>
>>>>> Jan 29 22:34:05 nfsserver kernel:  ?
>>>>> sysvec_apic_timer_interrupt+0x72/0x80
>>>>> Jan 29 22:34:05 nfsserver kernel:  ?
>>>>> asm_sysvec_apic_timer_interrupt+0x12/0x20
>>>>> Jan 29 22:34:05 nfsserver kernel:  ? ktime_get+0x7b/0xa0
>>>>> Jan 29 22:34:05 nfsserver kernel:  rpc_exit_task+0x96/0x140 [sunrpc]
>>>>> Jan 29 22:34:05 nfsserver kernel:  ?
>>>>> __rpc_do_wake_up_task_on_wq+0x1e0/0x1e0 [sunrpc]
>>>>> Jan 29 22:34:05 nfsserver kernel:  __rpc_execute+0x6d/0x410 [sunrpc]
>>>>> Jan 29 22:34:05 nfsserver kernel:  rpc_async_schedule+0x29/0x40
>>>>> [sunrpc]
>>>>> Jan 29 22:34:05 nfsserver kernel:  process_one_work+0x1b3/0x350
>>>>> Jan 29 22:34:05 nfsserver kernel:  worker_thread+0x53/0x3e0
>>>>> Jan 29 22:34:05 nfsserver kernel:  ? process_one_work+0x350/0x350
>>>>> Jan 29 22:34:05 nfsserver kernel:  kthread+0x118/0x140
>>>>> Jan 29 22:34:05 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>>>> Jan 29 22:34:05 nfsserver kernel:  ret_from_fork+0x1f/0x30
>>>>>
>>>>> I can try to pick on top of the kernel the change Chuck mentioned to
>>>>> me offlist, which is the posting of
>>>>> https://lore.kernel.org/linux-nfs/1738271066-6727-1-git-send-email-
>>>>> dai.ngo@oracle.com/,
>>>>> and in fact this could be interesting. If the users keep doing the
>>>>> same kind of load, this might help understanding more the issue.
>>>>>
>>>>> As we suspect that the issue is more frequently triggered after the
>>>>> switch of 5.10.118 -> 5.10.221, this enforces more the above, which
>>>>> says it fixes 66af25799940 ("NFSD: add courteous server support for
>>>>> thread with only delegation"), which is in 5.19-rc1, but got
>>>>> backported to 5.15.154 and 5.10.220 as well.
>>>>
>>>> Unfortunately not. The system ran slightly more stable with that
>>>> patch on, and
>>>> there was a nfsd hang inbeween here, within a series of
>>>>
>>>> [...]
>>>> Feb 02 03:22:40 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 5d31fb84
>>>> Feb 02 03:22:40 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 9ec25b24
>>>> Feb 02 03:23:09 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 9fc25b24
>>>> Feb 02 03:23:12 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 5e31fb84
>>>> Feb 02 03:23:24 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid a0c25b24
>>>> Feb 02 03:23:24 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 5f31fb84
>>>> Feb 02 03:23:31 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000fe9013df xid 756103e9
>>>> Feb 02 03:23:31 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000471650a0 xid ef4f583e
>>>> Feb 02 03:23:33 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 000000008f30d648 xid 1ec77a2e
>>>> Feb 02 03:23:35 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid d0b95b44
>>>> Feb 02 03:27:43 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 7d31fb84
>>>> Feb 02 03:27:44 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid bec25b24
>>>> Feb 02 03:27:44 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid e0be7eef
>>>> Feb 02 03:28:07 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid bfc25b24
>>>> Feb 02 03:28:09 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid e1be7eef
>>>> Feb 02 03:31:41 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid f96ccce2
>>>> Feb 02 03:31:44 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid 06ba5b44
>>>> Feb 02 03:31:49 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 9531fb84
>>>> Feb 02 03:31:51 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid f7be7eef
>>>> Feb 02 03:31:52 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000471650a0 xid 2550583e
>>>> Feb 02 03:31:53 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid d5c25b24
>>>> Feb 02 03:31:53 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000fe9013df xid ab6103e9
>>>> Feb 02 03:31:53 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 000000004111342b xid 9da4f045
>>>> Feb 02 03:32:32 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid d8c25b24
>>>> Feb 02 03:32:32 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid fabe7eef
>>>> Feb 02 04:18:12 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid a1c35b24
>>>> Feb 02 04:18:12 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 000000009715512e xid 29a849e3
>>>> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000fe9013df xid 786203e9
>>>> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000471650a0 xid f150583e
>>>> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid c66dcce2
>>>> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 000000008f30d648 xid 21c87a2e
>>>> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 0000000053af79cb xid 49da29a2
>>>> Feb 02 04:18:13 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 6132fb84
>>>> Feb 02 04:49:18 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid 2ebb5b44
>>>> Feb 02 04:49:21 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid 226ecce2
>>>> Feb 02 04:49:22 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid fdc35b24
>>>> Feb 02 04:49:22 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000f83dcedd xid 1fc07eef
>>>> Feb 02 05:01:25 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 25c45b24
>>>> Feb 02 05:09:27 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000ca92d20a xid 51c45b24
>>>> [...]
>>>> Feb 02 05:34:46 nfsserver kernel: INFO: task nfsd:1590 blocked for
>>>> more than 120 seconds.
>>>> Feb 02 05:34:46 nfsserver kernel:       Tainted: G            E    
>>>> 5.10.0-34-amd64 #1 Debian 5.10.228-1~test1
>>>> Feb 02 05:34:46 nfsserver kernel: "echo 0 > /proc/sys/kernel/
>>>> hung_task_timeout_secs" disables this message.
>>>> Feb 02 05:34:46 nfsserver kernel: task:nfsd            state:D
>>>> stack:    0 pid: 1590 ppid:     2 flags:0x00004000
>>>> Feb 02 05:34:46 nfsserver kernel: Call Trace:
>>>> Feb 02 05:34:46 nfsserver kernel:  __schedule+0x282/0x870
>>>> Feb 02 05:34:46 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
>>>> Feb 02 05:34:46 nfsserver kernel:  schedule+0x46/0xb0
>>>> Feb 02 05:34:46 nfsserver kernel: 
>>>> rwsem_down_write_slowpath+0x257/0x4d0
>>>> Feb 02 05:34:46 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
>>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel: 
>>>> ext4_buffered_write_iter+0x33/0x160 [ext4]
>>>> Feb 02 05:34:46 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
>>>> Feb 02 05:34:46 nfsserver kernel:  do_iter_write+0x80/0x1c0
>>>> Feb 02 05:34:46 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel:  elfcorehdr_read+0x40/0x40
>>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0
>>>> [sunrpc]
>>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
>>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel:  ? kthread+0x118/0x140
>>>> Feb 02 05:34:46 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>>> Feb 02 05:34:46 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
>>>> Feb 02 05:34:46 nfsserver kernel: INFO: task nfsd:1599 blocked for
>>>> more than 120 seconds.
>>>> Feb 02 05:34:46 nfsserver kernel:       Tainted: G            E    
>>>> 5.10.0-34-amd64 #1 Debian 5.10.228-1~test1
>>>> Feb 02 05:34:46 nfsserver kernel: "echo 0 > /proc/sys/kernel/
>>>> hung_task_timeout_secs" disables this message.
>>>> Feb 02 05:34:46 nfsserver kernel: task:nfsd            state:D
>>>> stack:    0 pid: 1599 ppid:     2 flags:0x00004000
>>>> Feb 02 05:34:46 nfsserver kernel: Call Trace:
>>>> Feb 02 05:34:46 nfsserver kernel:  __schedule+0x282/0x870
>>>> Feb 02 05:34:46 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
>>>> Feb 02 05:34:46 nfsserver kernel:  schedule+0x46/0xb0
>>>> Feb 02 05:34:46 nfsserver kernel: 
>>>> rwsem_down_write_slowpath+0x257/0x4d0
>>>> Feb 02 05:34:46 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
>>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel: 
>>>> ext4_buffered_write_iter+0x33/0x160 [ext4]
>>>> Feb 02 05:34:46 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
>>>> Feb 02 05:34:46 nfsserver kernel:  do_iter_write+0x80/0x1c0
>>>> Feb 02 05:34:46 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel:  elfcorehdr_read+0x40/0x40
>>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0
>>>> [sunrpc]
>>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
>>>> Feb 02 05:34:46 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
>>>> Feb 02 05:34:46 nfsserver kernel:  ? kthread+0x118/0x140
>>>> Feb 02 05:34:46 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>>> Feb 02 05:34:46 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
>>>> Feb 02 05:34:46 nfsserver kernel: INFO: task nfsd:1601 blocked for
>>>> more than 121 seconds.
>>>> Feb 02 05:34:46 nfsserver kernel:       Tainted: G            E    
>>>> 5.10.0-34-amd64 #1 Debian 5.10.228-1~test1
>>>> Feb 02 05:34:46 nfsserver kernel: "echo 0 > /proc/sys/kernel/
>>>> hung_task_timeout_secs" disables this message.
>>>> Feb 02 05:34:46 nfsserver kernel: task:nfsd            state:D
>>>> stack:    0 pid: 1601 ppid:     2 flags:0x00004000
>>>> Feb 02 05:34:46 nfsserver kernel: Call Trace:
>>>> Feb 02 05:34:46 nfsserver kernel:  __schedule+0x282/0x870
>>>> Feb 02 05:34:46 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
>>>> Feb 02 05:34:46 nfsserver kernel:  schedule+0x46/0xb0
>>>> Feb 02 05:34:47 nfsserver kernel: 
>>>> rwsem_down_write_slowpath+0x257/0x4d0
>>>> Feb 02 05:34:47 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
>>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel: 
>>>> ext4_buffered_write_iter+0x33/0x160 [ext4]
>>>> Feb 02 05:34:47 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
>>>> Feb 02 05:34:47 nfsserver kernel:  do_iter_write+0x80/0x1c0
>>>> Feb 02 05:34:47 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  elfcorehdr_read+0x40/0x40
>>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0
>>>> [sunrpc]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? kthread+0x118/0x140
>>>> Feb 02 05:34:47 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>>> Feb 02 05:34:47 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
>>>> Feb 02 05:34:47 nfsserver kernel: INFO: task nfsd:1604 blocked for
>>>> more than 121 seconds.
>>>> Feb 02 05:34:47 nfsserver kernel:       Tainted: G            E    
>>>> 5.10.0-34-amd64 #1 Debian 5.10.228-1~test1
>>>> Feb 02 05:34:47 nfsserver kernel: "echo 0 > /proc/sys/kernel/
>>>> hung_task_timeout_secs" disables this message.
>>>> Feb 02 05:34:47 nfsserver kernel: task:nfsd            state:D
>>>> stack:    0 pid: 1604 ppid:     2 flags:0x00004000
>>>> Feb 02 05:34:47 nfsserver kernel: Call Trace:
>>>> Feb 02 05:34:47 nfsserver kernel:  __schedule+0x282/0x870
>>>> Feb 02 05:34:47 nfsserver kernel:  ? rwsem_spin_on_owner+0x74/0xd0
>>>> Feb 02 05:34:47 nfsserver kernel:  schedule+0x46/0xb0
>>>> Feb 02 05:34:47 nfsserver kernel: 
>>>> rwsem_down_write_slowpath+0x257/0x4d0
>>>> Feb 02 05:34:47 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
>>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel: 
>>>> ext4_buffered_write_iter+0x33/0x160 [ext4]
>>>> Feb 02 05:34:47 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
>>>> Feb 02 05:34:47 nfsserver kernel:  do_iter_write+0x80/0x1c0
>>>> Feb 02 05:34:47 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  elfcorehdr_read+0x40/0x40
>>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0
>>>> [sunrpc]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? kthread+0x118/0x140
>>>> Feb 02 05:34:47 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>>> Feb 02 05:34:47 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
>>>> Feb 02 05:34:47 nfsserver kernel: INFO: task nfsd:1610 blocked for
>>>> more than 121 seconds.
>>>> Feb 02 05:34:47 nfsserver kernel:       Tainted: G            E    
>>>> 5.10.0-34-amd64 #1 Debian 5.10.228-1~test1
>>>> Feb 02 05:34:47 nfsserver kernel: "echo 0 > /proc/sys/kernel/
>>>> hung_task_timeout_secs" disables this message.
>>>> Feb 02 05:34:47 nfsserver kernel: task:nfsd            state:D
>>>> stack:    0 pid: 1610 ppid:     2 flags:0x00004000
>>>> Feb 02 05:34:47 nfsserver kernel: Call Trace:
>>>> Feb 02 05:34:47 nfsserver kernel:  __schedule+0x282/0x870
>>>> Feb 02 05:34:47 nfsserver kernel:  schedule+0x46/0xb0
>>>> Feb 02 05:34:47 nfsserver kernel: 
>>>> rwsem_down_write_slowpath+0x257/0x4d0
>>>> Feb 02 05:34:47 nfsserver kernel:  ? trace_call_bpf+0x76/0xe0
>>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd4_write+0x1/0x1a0 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel: 
>>>> ext4_buffered_write_iter+0x33/0x160 [ext4]
>>>> Feb 02 05:34:47 nfsserver kernel:  do_iter_readv_writev+0x14f/0x1b0
>>>> Feb 02 05:34:47 nfsserver kernel:  do_iter_write+0x80/0x1c0
>>>> Feb 02 05:34:47 nfsserver kernel:  nfsd_vfs_write+0x17f/0x680 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  nfsd4_write+0xd0/0x1a0 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  elfcorehdr_read+0x40/0x40
>>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_dispatch+0x15b/0x250 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? svc_process_common+0x3e1/0x6e0
>>>> [sunrpc]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd_svc+0x390/0x390 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? svc_process+0xb7/0xf0 [sunrpc]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? nfsd+0x91/0xb0 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? get_order+0x20/0x20 [nfsd]
>>>> Feb 02 05:34:47 nfsserver kernel:  ? kthread+0x118/0x140
>>>> Feb 02 05:34:47 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>>> Feb 02 05:34:47 nfsserver kernel:  ? ret_from_fork+0x1f/0x30
>>>
>>> This is a totally different failure mode: it's hanging in the
>>> ext4 write path. One of your nfsd threads is stuck in D state
>>> waiting to get a rw semaphor.
>>>
>>> Question is, who is holding that rw_sem and why?
>>
>> It looks like ext4_buffered_write_iter() takes the inode_lock, so it's
>> probably the inode->i_rwsem that it's waiting on. Unfortunately all
>> sorts of things take that lock so it's hard to speculate about the
>> cause of it being stuck. Consider triggering a sysrq-w if this occurs
>> again, which would tell us something about the contended locks.
>>
>>
>>>> This happend a couple of times again and "recovered", but got
>>>> finally stuck
>>>> again with:
>>>>
>>>> Feb 02 10:55:25 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 00000000b31acdd9 xid 1639fb84
>>>> Feb 02 10:55:26 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 000000004111342b xid 24acf045
>>>> Feb 02 10:55:27 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 0000000035c718f5 xid 89c15b44
>>>> Feb 02 10:55:28 nfsserver kernel: receive_cb_reply: Got unrecognized
>>>> reply: calldir 0x1 xpt_bc_xprt 000000004563c9e7 xid 8c74cce2
>>>> Feb 02 10:55:50 nfsserver kernel: rcu: INFO: rcu_sched self-detected
>>>> stall on CPU
>>>> Feb 02 10:55:50 nfsserver kernel: rcu:         14-....: (5249 ticks
>>>> this GP) idle=c4e/1/0x4000000000000000 softirq=3120573/3120573 fqs=2624
>>>> Feb 02 10:55:50 nfsserver kernel:         (t=5250 jiffies g=4585625
>>>> q=145785)
>>>> Feb 02 10:55:50 nfsserver kernel: NMI backtrace for cpu 14
>>>> Feb 02 10:55:50 nfsserver kernel: CPU: 14 PID: 614435 Comm: kworker/
>>>> u42:2 Tainted: G            E     5.10.0-34-amd64 #1 Debian
>>>> 5.10.228-1~test1
>>>> Feb 02 10:55:50 nfsserver kernel: Hardware name: DALCO AG S2600WFT/
>>>> S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
>>>> Feb 02 10:55:50 nfsserver kernel: Workqueue: rpciod
>>>> rpc_async_schedule [sunrpc]
>>>> Feb 02 10:55:50 nfsserver kernel: Call Trace:
>>>> Feb 02 10:55:50 nfsserver kernel:  <IRQ>
>>>> Feb 02 10:55:50 nfsserver kernel:  dump_stack+0x6b/0x83
>>>> Feb 02 10:55:50 nfsserver kernel:  nmi_cpu_backtrace.cold+0x32/0x69
>>>> Feb 02 10:55:50 nfsserver kernel:  ? lapic_can_unplug_cpu+0x80/0x80
>>>> Feb 02 10:55:50 nfsserver kernel: 
>>>> nmi_trigger_cpumask_backtrace+0xdb/0xf0
>>>> Feb 02 10:55:50 nfsserver kernel:  rcu_dump_cpu_stacks+0xa5/0xd7
>>>> Feb 02 10:55:50 nfsserver kernel:  rcu_sched_clock_irq.cold+0x202/0x3d9
>>>> Feb 02 10:55:50 nfsserver kernel:  ? timekeeping_advance+0x370/0x5c0
>>>> Feb 02 10:55:50 nfsserver kernel:  update_process_times+0x8c/0xc0
>>>> Feb 02 10:55:50 nfsserver kernel:  tick_sched_handle+0x22/0x60
>>>> Feb 02 10:55:50 nfsserver kernel:  tick_sched_timer+0x65/0x80
>>>> Feb 02 10:55:50 nfsserver kernel:  ? tick_sched_do_timer+0x90/0x90
>>>> Feb 02 10:55:50 nfsserver kernel:  __hrtimer_run_queues+0x127/0x280
>>>> Feb 02 10:55:50 nfsserver kernel:  hrtimer_interrupt+0x110/0x2c0
>>>> Feb 02 10:55:50 nfsserver kernel: 
>>>> __sysvec_apic_timer_interrupt+0x5c/0xe0
>>>> Feb 02 10:55:50 nfsserver kernel:  asm_call_irq_on_stack+0xf/0x20
>>>> Feb 02 10:55:50 nfsserver kernel:  </IRQ>
>>>> Feb 02 10:55:50 nfsserver kernel: 
>>>> sysvec_apic_timer_interrupt+0x72/0x80
>>>> Feb 02 10:55:50 nfsserver kernel: 
>>>> asm_sysvec_apic_timer_interrupt+0x12/0x20
>>>> Feb 02 10:55:50 nfsserver kernel: RIP:
>>>> 0010:mod_delayed_work_on+0x5d/0x90
>>
>> mod_delayed_work_on() disables IRQs and then calls down into the
>> workqueue code to modify a wq job. If that took too long then you'd see
>> an rcu_sched warning like this.
>>
>>>> Feb 02 10:55:50 nfsserver kernel: Code: 00 4c 89 e7 e8 34 fe ff ff
>>>> 89 c3 83 f8 f5 74 e9 85 c0 78 1b 89 ef 4c 89 f1 4c 89 e2 4c 89 ee e8
>>>> f9 fc ff ff 48 8b 3c 24 57 9d <0f> 1f 44 00 00 85 db 0f 95 c0 48 8b
>>>> 4c 24 08 65 48 2b 0c 25 28 00
>>>> Feb 02 10:55:50 nfsserver kernel: RSP: 0018:ffffaaff25d57d90 EFLAGS:
>>>> 00000246
>>>> Feb 02 10:55:50 nfsserver kernel: RAX: 0000000000000000 RBX:
>>>> 0000000000000000 RCX: 000000003e60000e
>>>> Feb 02 10:55:50 nfsserver kernel: RDX: 000000003e400000 RSI:
>>>> 0000000000000046 RDI: 0000000000000246
>>>> Feb 02 10:55:50 nfsserver kernel: RBP: 0000000000002000 R08:
>>>> ffffffffc08f6430 R09: ffffffffc08f6448
>>>> Feb 02 10:55:50 nfsserver kernel: R10: 0000000000000003 R11:
>>>> 0000000000000003 R12: ffffffffc08f6428
>>>> Feb 02 10:55:50 nfsserver kernel: R13: ffff8e4083a4b400 R14:
>>>> 00000000000001f4 R15: 0000000000000000
>>>> Feb 02 10:55:50 nfsserver kernel: 
>>>> __rpc_sleep_on_priority_timeout+0x111/0x120 [sunrpc]
>>>> Feb 02 10:55:50 nfsserver kernel:  rpc_delay+0x56/0x90 [sunrpc]
>>>> Feb 02 10:55:50 nfsserver kernel:  rpc_exit_task+0x5a/0x140 [sunrpc]
>>>> Feb 02 10:55:50 nfsserver kernel:  ?
>>>> __rpc_do_wake_up_task_on_wq+0x1e0/0x1e0 [sunrpc]
>>>> Feb 02 10:55:50 nfsserver kernel:  __rpc_execute+0x6d/0x410 [sunrpc]
>>>> Feb 02 10:55:50 nfsserver kernel:  rpc_async_schedule+0x29/0x40
>>>> [sunrpc]
>>>> Feb 02 10:55:50 nfsserver kernel:  process_one_work+0x1b3/0x350
>>>> Feb 02 10:55:50 nfsserver kernel:  worker_thread+0x53/0x3e0
>>>> Feb 02 10:55:50 nfsserver kernel:  ? process_one_work+0x350/0x350
>>>> Feb 02 10:55:50 nfsserver kernel:  kthread+0x118/0x140
>>>> Feb 02 10:55:50 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
>>>> Feb 02 10:55:50 nfsserver kernel:  ret_from_fork+0x1f/0x30
>>>>
>>>> Before rebooting the system, rpcdebug -m rpc -c  was issued again,
>>>> with the
>>>> following logged entry:
>>>>
>>>> Feb 02 11:01:52 nfsserver kernel: -pid- flgs status -client- --
>>>> rqstp- -timeout ---ops--
>>>> Feb 02 11:01:52 nfsserver kernel: 42135 2281      0 8ff8d038       
>>>> 0      500  1a6bcc0 nfs4_cbv1 CB_RECALL_ANY a:call_start [sunrpc]
>>>> q:none
>>>
>>> This is also different: the CB_RECALL_ANY is waiting to start, it's not
>>> retransmitting.
>>>
>>>> The system is now again back booted with fs.leases-enable=0 to keep
>>>> it more
>>>> "stable".
>>>
>>> Understood, but I don't yet see how this new scenario is related to
>>> NFSv4 delegation. We can speculate, but here's nothing standing out in
>>> the collected data.
>>
>> Agreed. It looks like there are bigger issues than just nfsd here.
> 
> We were not brave enough to test any recent Linux kernels on our file
> servers, and stayed with the unaffected 5.15.131.
> 
> Were you able to pinpoint the issue? I understand, there are patches
> available. Savatore writes something about `fs.leases-enable=0`. We
> could give 6.12.29 another try, but would like to integrate possible
> patches beforehand, so any hints are appreciated.
> 
> If the problem still exists, we’d be willing to get quotes for contract
> work to fix this.

We believe the issue was addressed by backporting 036ac2778f7b ("NFSD:
fix hang in nfsd4_shutdown_callback"). That fix is available from
v6.12.16 onward.


-- 
Chuck Lever

