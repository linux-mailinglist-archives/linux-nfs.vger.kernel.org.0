Return-Path: <linux-nfs+bounces-3845-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2E909255
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 20:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865B61F2152D
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 18:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E53F1474C5;
	Fri, 14 Jun 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jYqd38pS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mbfcsBlS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2BE4409
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390024; cv=fail; b=ZoNVTH7iuDdIfxRAmSU55JqQm7ogDGKAfR6lxT40LW7L7c7dHxpm6UnZ9fiFDQKaYO0rrsq6mQMkXwZ9aBIoRLWxU6/IcKs/3zER4Fmqbez1/KPtvxHmMDRDE9ptiFCB73sgH86Zj18CM7eNDJa24W/E8xhq6dEfqJLlFs6VN54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390024; c=relaxed/simple;
	bh=4nEXywpTf6x0Mw/aWAankHsf2oivoxrwP9O+tCK9kyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dqeq8Ptnqj/chVGWN47gfx9uOIXXNPUhmmfFozbTRLYkT0diVNTCVM1aofUBADkSanBeFs6EblOoEJONzfgANFRZWy68BtirP64F3B5MFkUfqi2JLb2jdB1yhqNv3rP0ohaceVdO9aX68cdqT6DdtPZSYGRr6QCJpSvLKHSLqec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jYqd38pS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mbfcsBlS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EDGwao007152;
	Fri, 14 Jun 2024 18:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=4nEXywpTf6x0Mw/aWAankHsf2oivoxrwP9O+tCK9k
	yY=; b=jYqd38pS8lG6KaXjimik8+bxLE6fu/AEbZRfsQzTMWsDlLPpx7775Vxer
	mIsB0MLc4HrOZmcdqRfGlT+ilKV9eT9McKOXPCtfBF3ZUPEmKAc+wH1NLSI2GNQ9
	/ekYW/T1zqDcIVW+/ciatsCoXYwPJWof+gMHEG/td4aqaWa5GaAIsWTqme6NOG7v
	uTiHcwano/TBX4bauVrXmISbT7J9a9Yn5uyfcaknKpmXCJBiiwxJWBe9r7SL5enJ
	SkDgog7TqiZXBM9NiTAjxkqUbgvquCzGYgmu2J2gs4Mj7SjgiYwy0Ts3UacFs4Ng
	ifCiyCvN6StnS4RPkAbHgytMMYGMQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh19c80f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 18:33:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45EGsPwl020262;
	Fri, 14 Jun 2024 18:33:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync92x9hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 18:33:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNEqqonu7nsjlAGtS21yV3vSYPK5++UPguFca336nrfpbpttpoY3p/L+Az9fdUHaK3hqk8fsSC9bUrI+g4Wm30AzXDp40uRQjNCqOzYgKA7gGGFw3GdoRaCmv9sNtadsLVMlqpixo8FO2LHZvF/a4cvAnrGPgAxc1yJ0mJSApO1wjUQK/t3HdoVLYMNGA2HvzJ9D0tU6LlX/MmnTORJT+6ohPr0zfhKfr/7wn8oV8dDGMlJmuRZHos5mliwflTefGvn8BhjkLr6AU8G6oECoqH1B5gAI8cqKPqV5H6YX37VztwUtpp3qCirb0gdphgP92YIL0KjBX6BOkYZjYxbNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nEXywpTf6x0Mw/aWAankHsf2oivoxrwP9O+tCK9kyY=;
 b=ELIYJJHyDKnwLSNJUAWHYcq0zGHbH4cphnjnAIK4x0n84MaoVuDe1Kv/0rdSM9PnOcCnJqic24gfbDxiiyHs51u8oQleCJxg4NRoyEotE3wp7g/QH0BFGXgElwA/DnLSYc446orH+L9J5ytSc6JlFq9y++DV/MikQ47qC1UwDVOZkfTZQNSYvoQm42jZchIzWVgyc93S+B3FFiz34PhDIZMhEOOkGFyeQCcrh+XyXtPN+B1YMGyDbt8eIP6sUOuLnNSt603xQZYUsdDMTAdtMi5gyUYKo7pONiBRgo69+5RPlYAXkeX9jOLDG+qusXl26igAAI7I1VoDN17/iUCiuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nEXywpTf6x0Mw/aWAankHsf2oivoxrwP9O+tCK9kyY=;
 b=mbfcsBlSDdiBGJKW1VpUhOq4DUVBh9LgtlZ5vYNv0vSvjZ3+h9tcUYcdLPFCmFr6mW/FlNnt9mZfjBHKFr0udXmex9AMeS5WWJR0SVoSBlf/NyoXQLWX+nj2D/e5ysySYElvmFOdYJ8BF5EdSB7F6c1q/GoYkrewDtWDFJ7f2PQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4302.namprd10.prod.outlook.com (2603:10b6:208:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 18:33:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 18:33:02 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: reservation errors during fstests on pNFS block
Thread-Topic: reservation errors during fstests on pNFS block
Thread-Index: AQHavmmwJwrL3nOnBk+LjtpoM19XRLHHda8AgAAS+oCAAAs0gIAAAdcA
Date: Fri, 14 Jun 2024 18:33:02 +0000
Message-ID: <ED7EB3B3-F56A-451F-A639-D30BBA125EE6@oracle.com>
References: <34F83726-2A28-4E29-A40E-A01BED7744EC@oracle.com>
 <Zmxx-H2KrT5QpJ-g@infradead.org>
 <C02C8230-4ACA-4F2D-AC28-B9583ADCADA5@oracle.com>
 <ZmyLSZGWDeaIXdx4@infradead.org>
In-Reply-To: <ZmyLSZGWDeaIXdx4@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4302:EE_
x-ms-office365-filtering-correlation-id: 2363a529-e1fa-4b40-4e48-08dc8ca06cdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aGJnbTZJeEpGMWdOWWFmYnVXa0RrYmpMYlZkVS9CeVdiZHBQbFFRODY5Z1pC?=
 =?utf-8?B?eHpNcnpMYVo5R1F5RkxzaG5JVVh3bmdYR0ZDNm80aDE3a2FYRDQ4UG5VUkEv?=
 =?utf-8?B?QUI0K2RCNVdiMjNsYmNTZFJFb05qeVVReEZDTDJZb0Y4MG9YT0NpZVJyRk9q?=
 =?utf-8?B?MEw1THoyMVVLOXRUZ1NWM0JtbmxJZDJ2NnBkNVZuYmJuT091S3hiVkgvM1FS?=
 =?utf-8?B?MERTVW81RVR0NmxldGRzKzBDTG1TQ21MbURSQno0U3p4dmwrTUYxU1haQTRK?=
 =?utf-8?B?bzM3L2V0Z0ZlQWE3RjRENWlYbTN5bEFkMk1HK2s2MkZ6Z1Z5WHNHR21nSEZh?=
 =?utf-8?B?TjJ5TFhjMmVKbngzSlhHVTFmZHhCUlJkTDVWYVpLVU41d0dwL2w1b1RSaTFW?=
 =?utf-8?B?enk1S1IzZWJseTA5TGxDTEo0VUhWWDlQNnJwcmtsdkZHc1hTM3lxZE94U3Fu?=
 =?utf-8?B?WUc5Z1JhQUdsa1RRZ1R3TzFGanYxVmpUQlgvVEJzbTZGWHA5cC9qMis3R3ZM?=
 =?utf-8?B?Z1FBdFdaT2plbWZESHhBZ00xMjladzlqTldMV1YzTWM3NnN6SG1ML1gyNnlT?=
 =?utf-8?B?c0crWXRFU2tENkU0NE1WSDh4TWJyVFZlOUJxZXVndHFKREZnTUVtYmpETGU2?=
 =?utf-8?B?eE1ZMGN0bitsVlpBNlpzYlc3a1R3S0E4VE5JT2VRc0RHeE1XYnBzZ2UvSyt1?=
 =?utf-8?B?T2trblVuYmNqdVRHc1EwUUFMNVoxSUgxNnV2YmtPWFhzZ1dVL0p1dDBqZzg3?=
 =?utf-8?B?U2ZvNFpud1VhbnJlaDF3UmJBVjBKK2Q1Yk5WMERicTdFRHd1ZG9wek1oOUlR?=
 =?utf-8?B?WTNiR3N6cGd2TFJxMWJNamNHd2xxNGFEOWIwR2hncmFCL0ZhWkZTeVhpZmU1?=
 =?utf-8?B?eDBnSERFU3dicysvb3BNTTN6aHlKWDlVYmZJUEVmNkw4YWJrQ3FOZThaNUxR?=
 =?utf-8?B?MG1WdnR4cmVRMy9mSSt3QVV1QXZWSVZPTnRxbFNWRHl0ak5oUVByS0VyVWt3?=
 =?utf-8?B?aTNGZnRFK0pMWGFQQUdzRXF6M3BJVGgyWkxHWUZoTmhCZ3NzUGkrTnM0cnM5?=
 =?utf-8?B?WEJRWG9FY092eHRPWFFHL3l5a3ZuWHIwWjFmQ01HZTBaeUpPS2w0Rnl5MVBO?=
 =?utf-8?B?UTBaOXBia1RrMXplUGJJZHNuZXBIM1BVdGZlZEllZDRVdHB1cWEvekZTUzNm?=
 =?utf-8?B?ZWtnRWhOMU9WRVg3UTJYZDNDSTlyS3dxZ2FRUFcyVnNHOERXNnN4UUE0OEpY?=
 =?utf-8?B?emJJY21pMC85K0lLbUZ3L1F5bkZPN295b0xWU3lxaTJCZlJEMFZSL3c4ZTRH?=
 =?utf-8?B?ZUFxWWhGcGhvUkcvU0xzTDhsQ2xkWk5BbzZCcE5qVDB0ZXFUMGZFSlA1cm5Z?=
 =?utf-8?B?anI2d0hBMmVyRkkyZ3dXbEpSYnJJMVN0SmF0V1IrbEwwMzFnNjIvQTJ1QXd2?=
 =?utf-8?B?RGEwRkx3a1V4MzduTUc2Nmg4cGdKRDZCWXdGUHJwQ2ZFWUt0aEF3NHBkUXFM?=
 =?utf-8?B?Nnk0OVJXK0ExaTg0RkZQNWYrek9sMzBRL0RyVmFnV01hQkVncGx1cVhWa0hT?=
 =?utf-8?B?elRHSzUrcmNKNGNGc1hlTGRJOG5GWlBZK210QU4zRysxMlJITGhxTkZXd3Rt?=
 =?utf-8?B?bmtxcU43dTBJN2RxV3hNOHYxNkNnVkpnUnFRV1hlZUpsV3R3VjFzZmdaaUgr?=
 =?utf-8?B?QmpRbGVsYlM3NTk3R0xybVJtL1RSQ1hWV2tvcFdjcG9kdCtzWlREN2VRbHRE?=
 =?utf-8?B?ZldDWGZWTWdDaFZGczkyMlA3YnZmN0tBZTV0TmpUZUVlbldjaWZ4NTBLdjZZ?=
 =?utf-8?Q?vYNJIi9l2p5Le1pr1F1LmEZGGRNqFZV5OV7e4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bXlNdnlpcHI3dEplQ2UybGVGdkttbHdTQTE0Q2tEWDloTXl0MlUzL0pucHN0?=
 =?utf-8?B?RklJTWE1b09ST1VZaUUvZTdOMEhjcnB6cWNBTGJTU09NaFlxZ0NrM1l3V0Zr?=
 =?utf-8?B?MWcyZEdZM0pZWW9ya1g1SENQTSs3UWN6aGNmOXRialNTN3JiYjhXTVpMdnNZ?=
 =?utf-8?B?dStHMXdQM3licHBUdFcwdGNmS3RCMWt2SzE4dGVOb0JTa212TTRqeUllcUJl?=
 =?utf-8?B?TkZ3OFVsZlJqQlc0cGlNV2FBemRURFhoUEErYUF5Q1NZdEI4eG0yTWF0NDJp?=
 =?utf-8?B?KzhxOEJFTTVrUk95b0dZUWpqeUxTdDFMQ0NDRkhiT0RkUUI2TC9qZm41a290?=
 =?utf-8?B?b1pubEh2YTlOcmtTdEJYaGVXNEpmR2xXeVBuSUhGL1IrNFNHcjdXSlFMTVBD?=
 =?utf-8?B?eHpwMjZqOUNiYVpWQ1UzSjJteXJGbElvRGNvRDJ0TGdZMzBhclNoL0NSSVNy?=
 =?utf-8?B?LzBNeXRBM0czRUxrdXVLTldJdG5RcEkwSFA1d3JZTzZQWHJaK1l3bGpDdFda?=
 =?utf-8?B?S3V4c1VFTlpqeCs4NXN4MU9EcjZmNmg2aFNUc3FzcDNaTm9zdm56aUlsVmdY?=
 =?utf-8?B?YXduRUpOVGNMeGd4cURFUFlxdzNBL0hqVlY0amhzVjhpT3NVV3RPakd3LzRo?=
 =?utf-8?B?ZTVVS1Z4NVpKbjI1N3hOSC90aVlka21qOHByak1RL2JndDQwV3VTT3hyeG1H?=
 =?utf-8?B?ZXdxMlFjSWpCdiszczF2VmgrSkZUUDNxTGlwMXptcXlCT0xCWXdlQ2FKOHRm?=
 =?utf-8?B?VlJScXFCUy9ZazBQV084eHFQeW1qR2FSdmF1TzR1VS9HZWZHTUNDRzg5MnMz?=
 =?utf-8?B?NkNGaThxcjBnTThyTldCdTlmaGxGbVl1aFp4MVdFSEYwcWZSaFliU3FydlQ0?=
 =?utf-8?B?cm5aL21XVmJ2TGhTL2xJZ2dZMTJ2VDZFZ3VldjZza0hXajhsUDJJRlIrYnFx?=
 =?utf-8?B?M2Zld09WbDZreUx3YW8zRXZCNVMrMEdvUTZTUkhObG9ENFFUQmpOM21mOFdG?=
 =?utf-8?B?YU1zM0JGa0Z5ZDl3RDBhcFUwTktBaDh2eXhoWE5vUTdQYS9Bd0ZabnByY3hE?=
 =?utf-8?B?Sm8xdzBwSmJxSnBBSCs2LzZNTnpObE95YjMyZzQyNk03V2doZUpVQUp3OTFM?=
 =?utf-8?B?RTNmUGQ5Zm9qaEozWmwrODVBZldiWTRwcGM4S2xZZzhJS2VadUV2YUJ3RnFS?=
 =?utf-8?B?T1Ixcy83VlVyQWg4VTJYV1hRMVpFdG93MzJoemdhRTd2UXpQMXJpa2NCQzNz?=
 =?utf-8?B?Y2hiRGNRWUtvYTRMaXNrUHZjakd1d0VMTHdiQncyZjlsdmk2cG9tOURWcGtj?=
 =?utf-8?B?Y1FkNUQxRGFZV09yMmdMVjVjMzV5ZlUyK3VGOStKRk5RWU5xUHFELzJvb0d2?=
 =?utf-8?B?RTNnMGZrdVB1TldGNVBFTlJMWjNyNlRmSHRlaHJUNnBoK1BYQVBEcUNHN3lK?=
 =?utf-8?B?aWI4WE9sU01YR0xHcHhmSzVZdXZkTXp0WVF2d2RaNzVBWkdSUy9SLzdKTWg4?=
 =?utf-8?B?RHMzMnQrK0hQQ3ZFZFBLR1BsMERoYTJaRFVNQjR6NnFRaUt4RFJCOU1OakZx?=
 =?utf-8?B?WmptQ2RQdldSckZ5MTFrcVdtbDN4NytTajFFNjJ5ZnZUVlVCRXBxOXhEK1Zi?=
 =?utf-8?B?SzRKMWZSQ2tzSlZ6SDQ0TXRRUlRrVXRra0NJVHdiRkQ2M0NhM2J0NmlGMFVj?=
 =?utf-8?B?SmxKU2lNNGplR00wMjNPMnVoZkd0eGttV05EakpNTjRsRjBKYzBobzZ0OU4v?=
 =?utf-8?B?WEluYnRFT3FvcEtpeVh2ZTUwZExtVmdFTEpUa1hwSzQvRmd2dWtPQkEwRmJq?=
 =?utf-8?B?SXNOQWlpMUdPUFhnMVVnSnRLQVVMMkZqWk5BU09vbG1qVzZTSTJ2WTVjMS9w?=
 =?utf-8?B?SFpCMGRNUk9FSmlDanJ6KzJpeUh4RkNtdjJrWlhLejRFaDFjQlhlQWpLRm5F?=
 =?utf-8?B?WHN5b2FtSVZ4dlg1WEN1QWtiRmJ3YnU2Q1JzK3l3Q0EvTUcyQ0JEWFk2MDE4?=
 =?utf-8?B?SzQ1KzE2KytybVh3UDY4MlluWUY4SCtjcG9DbWRIdzVpV0xNTnRsZFEwK3FC?=
 =?utf-8?B?bTlXMVlSSEdwYm9LMzRkVVZyckJ4TUx4NElTMmVhOG9jeEYrdUFkc3NhdEJM?=
 =?utf-8?B?dkowSm5CZDljVG1wQXJaZ2dlSnpEaWxvMmtIVDN3Qzd2cTZzSG91d0xDUDZT?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26580D645D5B2648A639FAF44CF198CF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	n+CMdk59wQIMF2auZ+scrluoDS2pjEShTXLkwPM5l9ggBCaVqH0Xh8cmudDO/kXY+dXFsUaogT/9jXxOoCqmIhpZtB3J7unEfydXtQpyTamB2gdnm364xd3a9jzAy14SRni+YbEgmXVnjVxBm+ovAKlnUo35dNm+3N4LFgdq5n3AJtrjkiMDRGKwFg2v2fxLEIrovqGs2kFqmph8eZ41Iha/blNyKsFTEaAIVKYry4qz9PU/M9S1x4BcKatMiD1/Ls42Cv9scv20samLddrrOhaYvQTIb6T62so4tX5AwTnOlYKt6pQs1PuYSck8A7eeZQobo0Ys6RAEHYxtra7foFRw2t0Tm1ta4c/ri6OnJ9tfAArJGHEr4QyYF8F2FDm6ChYdS4PUvgJkuDKbHb32i8AzxVOy0gETdvKMAy2zNcCrPgM+Y/o7NTSRDMfiCyUHnZFwEwI+jlBSM5pR+P8fAQ2LEneNPOpjGiNoUN3aJvGlZ0RGJQWpnZx6Zy4yJGnLAzwPdNEax0FMkYSizLFM9cp5E+PiFkkIqV4YT4cc38VcrBRHk3SGcCuRd3K/JLhCaEIZG3+Zjex7UG9h4DRR/JsN49siVm27okLFc/MHY6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2363a529-e1fa-4b40-4e48-08dc8ca06cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 18:33:02.8695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yo2f0QWl7VkuhGY+DcRlYwfI0c1Dw5bkJ8ZNFIsdV342f3KOMcpW6c1AyrUA/Tgb+VpLTRO+0W0NJiwbDND0Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_15,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140128
X-Proofpoint-GUID: dFJ28JIWhbY6eZbo3MyKHU727VJ5HBun
X-Proofpoint-ORIG-GUID: dFJ28JIWhbY6eZbo3MyKHU727VJ5HBun

DQoNCj4gT24gSnVuIDE0LCAyMDI0LCBhdCAyOjI24oCvUE0sIENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIEp1biAxNCwgMjAyNCBhdCAw
NTo0NjoyMVBNICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+Pj4gUmVzZXJ2YXRpb24g
bWVhbnMgYW5vdGhlciBub2RlIGhhcyBhbiBhY3RpdmUgcmVzZXJ2YXRpb24gb24gdGhhdCBMVS4N
Cj4+IA0KPj4gVGhlcmUgYXJlIG9ubHkgdHdvIGFjY2Vzc29ycyBvZiB0aGUgTFVOOiB0aGUgTkZT
IHNlcnZlciBhbmQNCj4+IHRoZSBORlMgY2xpZW50IHJ1bm5pbmcgdGhlIHRlc3QuIFRoYXQncyB3
aHkgdGhlc2UgZXJyb3JzIGFyZQ0KPj4gYSBsaXR0bGUgc3VycHJpc2luZyB0byBtZS4NCj4gDQo+
IFlvdSBjYW4gY3JlYXRlIHJlZ2lzdHJhdGlvbnMgZnJvbSB1c2Vyc3BhY2UsIGFuZCBzb21lIGNs
dXN0ZXIgbWFuYWdlcnMNCj4gZG8gdGhhdC4gIEJ1dCBub25lIG9mIHRoYXQgc2hvdWxkIGhhcHBl
biBmb3IgYSBkZWZhdWx0IHNldHVwLg0KPiANCj4+PiBXaGVuIHBORlMgbGF5b3V0IGFjY2VzcyBm
YWlscyB3ZSBmYWxsIGJhY2sgdG8gbm9ybWFsIGFjY2VzcyB0aHJvdWdoIHRoZQ0KPj4+IE1EUywg
c28gdGhpcyBpcyBleHBlY3RlZC4NCj4+IA0KPj4gRXhwZWN0ZWQsIE9LLiBGcm9tIGEgdXNhYmls
aXR5IHN0YW5kcG9pbnQsIGVycm9yIG1lc3NhZ2VzIGxpa2UNCj4+IHRoaXMgd291bGQgcHJvYmFi
bHkgYmUgYWxhcm1pbmcgdG8gYWRtaW5pc3RyYXRvcnMuIEkgcGxhbiB0bw0KPj4gY29udmVydCB0
aGUgcHJpbnRrJ3MgYW5kIGRwcmludGsncyBpbiB0aGUgTkZTRCBsYXlvdXQgY29kZSBpbnRvDQo+
PiB0cmFjZSBwb2ludHMsIGJ1dCB0aGF0IGRvZXNuJ3QgaGVscCB0aGUgbWVzc2FnZXMgZW1pdHRl
ZCBieSB0aGUNCj4+IGJsb2NrIGFuZCBTQ1NJIGRyaXZlcnMuIElkZWFsbHkgdGhpcyBzaG91bGQg
YmUgbGVzcyBub2lzeS4NCj4gDQo+IFdlbGwsIHRoZXkgcmVhbGx5IHNob3VsZCBiZSBhbGFybWlu
ZyBiZWNhdXNlIHRoZSBhZG1pbiBjb25maWd1cmVkDQo+IGEgYmxvY2sgbGF5b3V0IHNldHVwIGFu
ZCBpdCBkaWQgbm90IHdvcmsgYXMgZXhwZWN0ZWQuICBTbyBpdCBzaG91bGQNCj4gcmluZyBhbGFy
bSBiZWxscy4NCg0KWWVzLCBJIGV4cGVjdCB0aGF0ICJwTkZTOiBmYWlsZWQgdG8gb3BlbiBkZXZp
Y2UNCi9kZXYvZGlzay9ieS1pZC9kbS11dWlkLW1wYXRoLTB4NjAwMSAuLi4iIGlzIHZlcnkgbGlr
ZWx5DQpvcGVyYXRvciBlcnJvci4NCg0KDQo+Pj4gSXMgZ2VuZXJpYy8wNjkgdGhhdCBmaXJzdCB0
ZXN0IHRoYXQgZmFpbGVkIHdoZW4gZG9pbmcgYSBmdWxsIHhmc3Rlc3RzDQo+Pj4gcnVuPw0KPj4g
DQo+PiBZZXMsIGl0J3MgYSBmdWxsIHJ1bi4gZ2VuZXJpYy8wNjkgaXMgdGhlIGZpcnN0IHRlc3Qg
d2hlcmUgdGhlcmUNCj4+IGFyZSByZW1hcmthYmxlIHN5c3RlbSBqb3VybmFsIG1lc3NhZ2VzIChp
ZSwgUFIgZXJyb3JzKSwgdGhvdWdoDQo+PiB0aGVyZSBhcmUgYSBmZXcgc3Vic2VxdWVudCB0ZXN0
cyB0aGF0IGFyZSBhbHNvIHdoaW5naW5nLg0KPiANCj4gSW50ZXJlc3RpbmcuICBOb3JtYWxseSBv
bmx5IHRoZSBzZXJ2ZXIgYWN0dWFsbHkgcmVzZXJ2ZXMgdGhlIExVLA0KPiB0aGUgY2xpZW50cyBq
dXN0IHJlZ2lzdGVyLiAgQW5kIHNvbWV0aGluZyB3ZW50IHdyb25nIGhlcmUgYW5kIG9ubHkNCj4g
Zm9yIHRoZXNlIHRlc3RzLg0KDQpJIGp1c3QgY2hlY2tlZCB0aGUgTkZTIHNlcnZlcidzIHN5c3Rl
bSBqb3VybmFsLCBhbmQgdGhlcmUncw0Kbm90aGluZyBpbnRlcmVzdGluZyB0aGVyZS4NCg0KRldJ
VywgdGhlIG90aGVyIHR3byB0ZXN0cyB0aGF0IGVtaXQgdW5leHBlY3RlZCBqb3VybmFsDQptZXNz
YWdlcyB0aGF0IEkgbm90ZWQgZG93biBhcmUgZ2VuZXJpYy8xMDggYW5kIGdlbmVyaWMvNjE2Lg0K
DQoNCj4+PiBEbyB5b3Ugc2VlIExBWU9VVCogb3BzIGluIC9wcm9jL3NlbGYvbW91bnRzdGF0cyBm
b3IgdGhlIHByZXZpb3VzDQo+Pj4gdGVzdHM/DQo+PiANCj4+IGdlbmVyaWMvMDEzIGlzIGtub3du
IHRvIGdlbmVyYXRlIGxheW91dCByZWNhbGxzLCBmb3IgZXhhbXBsZSwNCj4+IHNvIHRoZXJlIGlz
IGxheW91dCBhY3Rpdml0eSBkdXJpbmcgdGhlIHRlc3QgcnVuLg0KPiANCj4gT2suICBUaGUgb3Ro
ZXIgdGhpbmcgd291bGQgYmUgdG8gcnVuIGJsa3RyYWNlIG9uIHRoZSBjbGllbnQgYW5kDQo+IHNl
ZSB0aGF0IGl0IHNob3dzIEkvTy4gIEJ1dCBhbGwgdGhpcyBzb3VuZHMgbGlrZSB0aGUgdGVzdHMg
aW4NCj4gZ2VuZXJhbCB3b3JrLCBidXQgc29tZXRoaW5nIGlzIHVwIHdpdGggZ2VuZXJpYy8wNjku
DQo+IA0KPiBnZW5lcmljLzA2OSBqdXN0IGRvZXMgT19BUFBFTkQgd3JpdGVzLCBzbyBJIGNhbid0
IHNlZSB3aGF0DQo+IHdvdWxkIGJlIHNvIHNwZWNpYWwgYWJvdXQgaXQuDQo+IA0KPj4gDQo+PiBJ
IGNhbiBnbyBiYWNrIGFuZCB0cnkgcmVwcm9kdWNpbmcgd2l0aCBqdXN0IGdlbmVyaWMvMDY5IGFu
ZA0KPj4gdGNwZHVtcCBhcyBhIGZpcnN0IHN0ZXAuIElzIHRoZXJlIGEgd2F5IEkgY2FuIHRlbGwg
dGhhdCB0aGUNCj4+IFBSIGVycm9ycyBhcmUgbm90IHJlcG9ydGluZyBhIHBvc3NpYmxlIGRhdGEg
Y29ycnVwdGlvbj8NCj4gDQo+IHhmc3Rlc3RzIGluIGdlbmVyYWwgZG9lcyBkYXRhIHZlcmlmeWNh
dGlvbiB0byBjaGVjayBmb3IgZGF0YSBpbnRlZ3JpdHksDQo+IHNvIHdlIHNob3VsZCBub3QgcmVs
eSBvbiBrZXJuZWwgbWVzc2FnZXMuDQo+IA0KPiBJJ20gYSBiaXQgYnVzeSByaWdodCBub3csIGJ1
dCBJJ2xsIHRyeSB0byByZXByb2R1Y2UgdGhpcyBsb2NhbGx5IG5leHQNCj4gd2Vlay4NCg0KVGhh
bmtzLCBJJ2xsIGFsc28gdHJ5IHRvIGludmVzdGlnYXRlIGZ1cnRoZXIuDQoNCg0KLS0NCkNodWNr
IExldmVyDQoNCg0K

