Return-Path: <linux-nfs+bounces-2701-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E0D89B2F0
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Apr 2024 18:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C23E28287A
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Apr 2024 16:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B653B785;
	Sun,  7 Apr 2024 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IEXoi9G+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BY1PoVSk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4451E3B781
	for <linux-nfs@vger.kernel.org>; Sun,  7 Apr 2024 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507379; cv=fail; b=S4y7bmq1yicHm21z++Ra/vbuHSsPiQD2os02sBoHre3zrYxfnPHshyx4q93pWgoanIL4dbnC3mH7FI1WaCi+qGanfThPDzwnaKzptYcEdhDD7TM1fCuZ6+pEurfpqlgjwwsSQ0hbUouTRT1kQ8jtpcmAN2gF+vHf0DkIWOPfIGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507379; c=relaxed/simple;
	bh=suIFoWio6IgwZMACQRN74t05DuyJncdXXfpggWWZEG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sV9T0jgJL6MGm5Rirj28DCz+eJmZB0sHYNfKgqn4dN3SdTOPKx38oVZZ4Ca/EnomX9En8u3cobtxU39r0JjIARJh9LxNQGZvvidcbN1wO/S/ekeo2RnD2W+XWUhkN/x5DILB2ATlgKsEwAIog1DX9hIyDZnmqEMetxfBD5Mj9fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IEXoi9G+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BY1PoVSk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 437CVL1b009039;
	Sun, 7 Apr 2024 16:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=suIFoWio6IgwZMACQRN74t05DuyJncdXXfpggWWZEG8=;
 b=IEXoi9G+qZHhO0tQy5Zq/wbJP5NLuTVMQp/K+OCrDSPjY0OwXKAJN+ul7QXPPRtrnHrH
 wrWYKHV3sBITUSvOHSUd0XBz71SfvpnnPofrIUPfiKAwBNyhe1wz/EMSuVTP4A7N5muh
 MU+F7Ix1XOK5EZpMgi2I8Di0zABMFPo3Cv/Rwnsi6DEEolfq0CuGVcYL5knLud61PegQ
 43jLDHXKhDGP9qClBkmU/8/2KAgSELnBS+6FP7AGMY2//VMD+R5XiW9jmr7QlB+zX92d
 zoGe32tTz3UGNBfBk6IYi2UqdTeABHSTb7XoeIJ18NqrLgmGMkWglNTGp5q3MiKwdxyi 2w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw0219xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Apr 2024 16:29:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 437G6Bn1020038;
	Sun, 7 Apr 2024 16:29:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuam74d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Apr 2024 16:29:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEb4sxN1Un4Up0s4d7QGcTUtgnhccJUAPYuFPUhtdnQ1SoRZd98yzCjvDcge8BW/FNv0W558ICA9kRsvy6jKaidUm2xSm7i6hzLFBpXosbTuPuXXSHMWFp5Rs0LckpYb0IUv2g8zEAL6syes3Uoiv6Wnbe6tz1TLyibiSVuOr4O10dTbnD3RFnJ4C8Eor4AU6ooas9vElMwreIUddlSP4y/ljdM8EnlNGlJzNQ9jliU7ACzT/6eXV94+m1n2kwQWgR2+1N3n5tLN67/G3eaIFUbxUAXHL347Vz421JYTgofRAWJYVvQG8onseMJWNIFysiHuj0YpGRtIGPbKv9b7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suIFoWio6IgwZMACQRN74t05DuyJncdXXfpggWWZEG8=;
 b=UkgbxYCroEuEKtW6v2b3KBTxoVA0Qf1PFxWU7q3P3oVis6ZuGMJxM7v2KLrIYY7qk1RjRhkmmOO0XDlAcvIZdzi7Yd3Vdv56fPg5KPZqy5NTAMz4TvACH7HE03dNh19/Uxnfr5eyrOjLOYQCp9/VvnxPSgvYDiydpV272COw6elEggAx31L6e7zpeHZtuQPGf6ku3+CYRQqpaKEDpI0BcUL8mb1lzGk98zt/7m8uWdCK/o0tWtPPIsspzQI0ri5U53r4fFnM709nh8pvRgf2wmg0r3QdeaSyJXKnm8oTFIyBbsOM5LN36V62lyeJx9fKsm8HxDJEP3I6KZSpTNW+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suIFoWio6IgwZMACQRN74t05DuyJncdXXfpggWWZEG8=;
 b=BY1PoVSkM3fVinXgTEEWyABXrCuFZZ+oNJAbzgSKIyBmmbm6IPKVIjPphmYfaDtxXWOMrwJMKQnl5L66x/owKRebn68TYbXl6az+Uaq4l3jO8UDI0xWbrtqTaoMk5UyHlr8UHWDem4LjSdhioMCbCJk1T9SARe/XQIBZNBiL9pA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5910.namprd10.prod.outlook.com (2603:10b6:208:3d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 16:29:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 16:29:24 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Steve Dickson <steved@redhat.com>, Matt Turner <mattst88@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: nfs-utils' .service files not usable with nfsv4-server.service
Thread-Topic: nfs-utils' .service files not usable with nfsv4-server.service
Thread-Index: AQHah2XBHH2LTAvUvkKLPSeXjh/6i7FbtcQAgAAeSgCAARGjgIAAHPaA
Date: Sun, 7 Apr 2024 16:29:24 +0000
Message-ID: <3138D81C-EAD9-41CD-A32D-DEA4AA002CEE@oracle.com>
References: 
 <CAEdQ38GJgxponxNxkcv+t8mhwRPzOjan58MTBgOL8p9tY=rvTw@mail.gmail.com>
 <79c69668-4f8e-448e-9f50-6977cda662fc@redhat.com>
 <CAEdQ38FOP0_g0FK5DYz954OwfJjLUf2pjQL1CX=VNC60kd8HEw@mail.gmail.com>
 <50d1fcab-ba94-405e-896a-5bbae128998b@redhat.com>
In-Reply-To: <50d1fcab-ba94-405e-896a-5bbae128998b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN0PR10MB5910:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9iNJ+7Hk8c1titfDegMgFE06BnKFA41HzaroXmB2cEIsiUWkRMy1pn/ApeNMjOiFbRWmXY/uZV2FgwflUAI4FMphIu3mZpBYOA3mEUhPG65c6TbYQ95oErq8AgxAjmoB0r50geTmNfnISOSGaPixR0FnwEwVQu+mz6wRFnYvD0JcmLR8WAK9Y4Twxu6Zao2prKAakfzAG0OcCdjqKejWKEv3o6iI6VC8BCVm2WeJjDS2J8IUrPrLWW3Ie3eWGGWss0vE4qGMzI6BlniN2gu4wkc522j/w0XuMniCFOzH0Ye5Zo55QPz6YlyseyVTQ8bUk6GX/ibE/14GNsIpA0Zb6kmDGRoYMqEUWfEhMdzSMB6o6pcGpRs/XqRvhmBAMX9TS1ubN4w05YbY2HdMXZBo43lievhxMwZn3eMqzAQDbTemLyCKvoY8y5yD9tNBIx5F/n/rs5lPPl8cvvRLGTt7gJK61UlLvrt0pqERAuN5lKfY2kWqc4wmZlD5u1aseKfw4rIXa2Srw4oqjaueW9KSm22qUjACibEg+aBa1BpxXnmZO5NXnzIGcxuP4IBXokqKWXbhrlMoC2R8j4S7sVv/DNZB8Rz7uPCnBhZqSG/bubFlln4oNAwJaQfhv72h/XJGJ0E4XHdbvZvIqQ2H7p3XOQhFgafS21daVvmokThqoQY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UzQ3UEJWd0JGd1U1MzNnNC9lSlEzOEc3SzZXTnR3dDcvT1cxSGZmZHA4cGhs?=
 =?utf-8?B?V1dnUVNDRDRENmFpaERDZnlGc2FCYVF2NmFubWZpbk5zTjg5emtVSXY4Mm56?=
 =?utf-8?B?U2x6TE44M3ZQcDZGbE92QkpxajNHYjhCWmRVUFc3Z1lXRTBzN0Q0b3hqR3Zp?=
 =?utf-8?B?THFZc3grL2oyYXRDMkQzWGJLOENKVW01eTYyeDVDaTNGUFR5M2huZE1wejlm?=
 =?utf-8?B?U2NFRlE4bWJDbGZBeGVXbXZMWFRSeTJXU0pRWTlsUXpSZmE2V0tvejE1Mnpx?=
 =?utf-8?B?d3JGM2loMFBNVVZjSGFpTDZ1OUVFVkNmN3MzMlA0eWREZFgwL0RVVThMMUF2?=
 =?utf-8?B?U1pqWWtzUTl3RllEcjcxOWtTRVFHWUlmQ2Exa0VzdGYyTU1FRlV3MnFJYVBM?=
 =?utf-8?B?b2RpaFpKZXMxbEJETWsrbzdybWdYSG5Rcm5CL3hoUUNZYXZyVGRJT2pIMVpo?=
 =?utf-8?B?NnZ3Ti9aVjFrRCsyTCtxeDNJbzd3L3krTmVadUk2L09La0dYeFc1eWJXUHNq?=
 =?utf-8?B?eGd2YllVeVM3ZXV3dUJkTENGOUtPcWwxbUExSEVNNzFXY0taRy9JaURSTE8z?=
 =?utf-8?B?UVJmTGJXRFhmSWM3WVNFa2VQSW5lUnAwempSMXlsRUxaYVcxbGVNSXlqbnJ3?=
 =?utf-8?B?dWwwTC9VRDVoK3JoNFdoa0NBM3ZaZ1VDUmRZVWJidHowZm96N2hjODU1THYr?=
 =?utf-8?B?ZzN2N1EwQ0FmcldUSDhMSndmNm03VjBoS2x5ZitsbWZWQ29yU1BMdU5SQmQz?=
 =?utf-8?B?cllEaDlsbnFlc3kyMmhPSWxnZ1B3eHcrc0dtQnBsWTJDM2dCYStlb0FvanNz?=
 =?utf-8?B?WEhhcmxCRVRZTjNXRE90SzRzWURWSnM3bUxHNi9uVnlmeW1zTkRNeW9scU1w?=
 =?utf-8?B?ZytZdWdHaXpuUlU2TWtVQjVWV1BMMkl3SEF3THVvQ3BlaHlpNmo5M0g2WFdN?=
 =?utf-8?B?VUtBWEh3NTEreVVGM1A3cjF1b1p5Wnkxb1M0VG43VFRjeFhaS3VQZjFwekgv?=
 =?utf-8?B?ekNDUVZvVzlCUEErVlJ4dTBMN2dQSHRzSWNXWEdkYjFGY3MwbklGTWJLbzE3?=
 =?utf-8?B?eHM3Y1dHNjdpQTNyL1R2S1ZLQTJFK1R0ek9RNzBWSytvYnlzOE1RZG9ML2pz?=
 =?utf-8?B?NzRUUFhwbzBKVkNnZ2hEZmxiZjZIZVE1dXFhUjhZZ0lUNXowTTRqQXdlbXpw?=
 =?utf-8?B?WXhpZjJjWk1rcGU4OTJCdjU5NjFYbmdaaUhhS1NLaXJYZVBDQ3FuZUk1Sm1o?=
 =?utf-8?B?V0VnYnI0aFE0eGNabXBESjVIeWJhKytESll4N29rbjdlc0ZWNWRZRU9tK2Vy?=
 =?utf-8?B?WHZDOHR6MU0vbDZPRSt3QlNhTVV3U05lTUJEWC9JOEsyUGl5bHJGbDBUQ2pz?=
 =?utf-8?B?K1hwNXBzZldDSk5iVDFKSkNqbWgwSVZaUEJzRFNyUlVwMDZ1SFlOQ2Ivd0NG?=
 =?utf-8?B?VlBac2hqOTlrMnhqRU9JN1FxSFRHY21XM2w5SE1DODVzTTZnMG94UXREc2Vx?=
 =?utf-8?B?RTRFNEFnaTVzalFPOVc3b2tZUW0zdFRPVktIQXF6dGw4WTYxbmVid1R0V2lz?=
 =?utf-8?B?MTB3cjJ2NUtuL24rTWhjb1NsVkkwbmFWTDA1TlJodUVEdlliYklTcU5yOWc3?=
 =?utf-8?B?WTV2Z21DdE9GNlpLNHFHa2VPdWkxRVRvd1FFYm9aVldISjFiVEpiWmxZNmta?=
 =?utf-8?B?L2hKMXpJMVBKK3VCQmU2NWxaTlZpNGtON3A2TFFPbVhycktyWDdaQmQ5RDJ6?=
 =?utf-8?B?QTlIYmRJL0Y4azVkc2diWjhsYTZJajNiNS9Ldm0yUlBjYW1WeCs4Tm1EVWFJ?=
 =?utf-8?B?YXNPNHZvdmdxOW5McUxFQkI4bUUxZks2ckV2TEgxWndVMGNlckxwSTdjM0w1?=
 =?utf-8?B?d2p5UTNCUTY0bVBYUms2R3oycUVKVWhyWXpiQ2o5S01HcUZpNlYzYURPNHFH?=
 =?utf-8?B?bFZOWkpoeGVtQTBSTFhuNEI0YUZBdno3SzVaTm9HaFViaDZOd2xvUkNxUVBF?=
 =?utf-8?B?NkVwMmZNMVVWcTh6czE1ZzlJVjVESDcyeXhycnpleThrWEpwZkQyU0ptbzFx?=
 =?utf-8?B?a3RoMnNPTktDM2NVSnNhVExoMUlxWlpZSW1SRFhybllmWFVib20vdUtrU3Aw?=
 =?utf-8?B?WUdrMlpBR0xEcTVuRWsyZlRERCtDWUFTOW9IanhuWEZZbldpVFhsVy8vdVln?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1463EE8AE4C01444B86C5FD4A403A759@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	caw19r+h1nLJEiwuiV2lPP6lmAgpktHyxZOsEP0oTX2cQC5GAVC29mWAiKSC4ktd0Ni2xT4nHoow4ThYQ+AS63PZZJWImpDiHbAFG3PghSppv0IkQYjHA0BIOJ1UOHe9bJ/b3s78HvqOlA5bsMiMv6kpnr55J5yVeQX2tuG8uyE0xySZRfzbHv07ryQ/xPBacYg+qoHIDukruqg9B0tPwjfzQ/Uf6RIWq4v+a17asj3ImLJhMQ5FjbcKGyvbS7gwL0CzjQzDqhArNtm9zEcgF1zuClBtB7O58vk3gWH8qLdQt47E3Y6iK5I97ltgbtASSxdkrUBeQlkHJ+r6R06nFQ2zWraE8mXhrr3385HRhiKGsqpRA1ord4rbRp4ZUrdXnpLHgpk+6WYfe2JNdtmHJEfbZoxMz6yNwg+RDJsTstrPx+l7e8Z+h/NTVjQB62EngzxwSk8qw/e3NIQHgevEvHAH7J63GPJcQpImpKRxR555mxH4U9caw0IX/unsGVaBJRN6tUpNjEi8W23ZNyaQDh8px4A15HTFCIq+ZELZOmYeMrDdMArB2tLZ75y/n0gRJ4TL3XJ4ReiSnc+9J0qfObUGH3SxhVKkmdgtDgsYzJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498117cd-a121-4ffe-eb56-08dc571fe334
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 16:29:24.6700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vvu+R7TAClbIymtcFqcV7Ox/Q3nWbjGdb0R3bb0mitNSjnJtSo3n7eQAJQfpu7GUg4V0GM60wpkcSTWNgBgSSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_10,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404070132
X-Proofpoint-ORIG-GUID: 8SPthxWdjyEe_MtL1fS2rRTRSpu-kfAR
X-Proofpoint-GUID: 8SPthxWdjyEe_MtL1fS2rRTRSpu-kfAR

DQo+IE9uIEFwciA3LCAyMDI0LCBhdCAxMDo0NeKAr0FNLCBTdGV2ZSBEaWNrc29uIDxzdGV2ZWRA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiA0LzYvMjQgNjoyNiBQTSwgTWF0dCBUdXJuZXIg
d3JvdGU6DQo+PiBPbiBTYXQsIEFwciA2LCAyMDI0IGF0IDQ6MzfigK9QTSBTdGV2ZSBEaWNrc29u
IDxzdGV2ZWRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPj4+IFVuZm9ydHVuYXRlbHkgdGhlIGlk
ZWEgb2YgaGF2aW5nIGEgbmZzdjQgb25seSBzZXJ2ZXINCj4+PiBkaWQgbm90IGdvIG92ZXIgd2Vs
bCB3aXRoIHVwc3RyZWFtLg0KPj4gV2hpY2ggdXBzdHJlYW0gZG8geW91IG1lYW4/IG5mcy11dGls
cywgTGludXgga2VybmVsPw0KPiBUaGUgTkZTIHNlcnZlciBtYWludGFpbmVycy4uLiB0aGV5IGRp
ZG4ndCBwdXNoIGJhY2sgaGFyZA0KPiBidXQgdGhlIGRpZG4ndCBpdCB3YXMgbmVjZXNzYXJ5Lg0K
DQpJJ20gc3ltcGF0aGV0aWMgdG8gc29tZSBmb2xrcyB3YW50aW5nIGEgbmFycm93ZXIgZm9vdHBy
aW50LA0KYnV0IEkgdGhpbmsgd2UnZCBsaWtlIHRvIGhhdmUgc3VwcG9ydCBmb3IgYWxsIHZlcnNp
b25zDQpwYWNrYWdlZCBhbmQgYXZhaWxhYmxlIGZvciBhbiBORlMgc2VydmVyIGFkbWluaXN0cmF0
b3IsDQpyaWdodCBvdXQgb2YgdGhlIHNocmluay13cmFwLiBDdXJyZW50bHksIG1vc3QgaW5zdGFs
bGF0aW9ucw0Kd2FudCB0byBkZXBsb3kgdjMgYW5kIHY0LCBzbyB3ZSBzaG91bGQgY2F0ZXIgdG8g
dGhlIGNvbW1vbg0KY2FzZS4NCg0KQXMgSSByZWNhbGwsIHRoZSBORlN2NC1vbmx5IG1lY2hhbmlz
bSBwcm9wb3NlZCBhdCB0aGUgdGltZQ0Kd2FzIHByZXR0eSBjbHVua3kuIElmIHlvdSBoYXZlIGFs
dGVybmF0aXZlIGlkZWFzLCBJJ20gaGFwcHkNCnRvIGNvbnNpZGVyIHRoZW0uIEJ1dCBsZXQncyBy
ZWNvZ25pemUgdGhhdCBhbiBORlN2NC1vbmx5DQpkZXBsb3ltZW50IGlzIHRoZSBzcGVjaWFsIGNh
c2UgaGVyZSwgYW5kIG5vdCBtYWtlIGxpZmUgbW9yZQ0KZGlmZmljdWx0IGZvciBldmVyeW9uZSBl
bHNlLCBlc3BlY2lhbGx5IGZvbGtzIHdobyBtaWdodA0Kc3RhcnQgd2l0aCBhbiBORlN2NC1vbmx5
IGRlcGxveW1lbnQgYW5kIG5lZWQgdG8gYWRkIE5GU3YzDQpsYXRlciwgZm9yIHdoYXRldmVyIGNy
YXp5IHJlYXNvbi4NCg0KVGhlIG5mcy1zZXJ2ZXIgdW5pdCBzaG91bGQgYmUgbWFkZSB0byBkbyB0
aGUgcmlnaHQgdGhpbmcNCm5vIG1hdHRlciB3aGF0IGlzIGluc3RhbGxlZCBvbiB0aGUgc3lzdGVt
IGFuZCBubyBtYXR0ZXIgd2hhdA0KaXMgaW4gL2V0Yy9uZnMuY29uZi4gSSBkb24ndCBzZWUgd2h5
IHNjcmV3aW5nIHdpdGggdGhlDQpkaXN0cm8gcGFja2FnaW5nIGlzIG5lZWRlZD8NCg0KLS0NCkNo
dWNrIExldmVyDQoNCg0K

