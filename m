Return-Path: <linux-nfs+bounces-1621-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380E8844216
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 15:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19961F26783
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C711272C4;
	Wed, 31 Jan 2024 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XH7jYQdc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WZL2ADtv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EEF1272A1
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712115; cv=fail; b=oCpgq7a/PM7JhUKZtOGSHtBif2haFGFpOObscawULJ6PhXqZiXvzHEyRqXNZ+WI2zJ2HxVJV9UZTSFHQ4TwAQJOG92MNyFvPCpioLmn6hdy0NaGvM0PKn+gTHW+3k/P0D7+864nY93UxaGo0ynfIT8Yuz5dNagxVyr5/jLYvzX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712115; c=relaxed/simple;
	bh=Xnfv/kvowrquNlvr4hheTo+TSmktU9PTXHyqFFpCbno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sHY0yemLipvEDC6B5td5IMrHRE2jghpXszX0NtztQHcHg6PWzI9SSiqLU+D3xrZt9cNCof05zp3mM77folzb/rrMAWwO3NRAxP4g1vLW7Ek2dark26b1OVmLIqz3M7RhQ6JZUixmAawR/tTTqE31qMOi+DKd+ELOUgvUR7J41IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XH7jYQdc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WZL2ADtv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VEaL4G019390;
	Wed, 31 Jan 2024 14:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Xnfv/kvowrquNlvr4hheTo+TSmktU9PTXHyqFFpCbno=;
 b=XH7jYQdcJVk4LyL3Dx2NdKQXYo0/+qNIAdO8Wtu/JbbvD5DBV7K92Tu+hGKQqlC+sxhf
 QNEF2sroQXXzXdAp25Of13VPbAKZF0DHiNL1WbwTNp8oUmgrtS2CV+hQaZZmNhAbbmap
 q0rIkh/xNRziSIcW3J6HrnnAeq9+5lk0qV/2T0uL+OwrZFXCTOUE3qtnEOO+9zJzueRO
 HEHCGKncf+xEAwjurCg42m3fekSpzRl3QFC4SnhFli2SOd0/cT+llQSetv0YWWlID8PY
 NBTfZN83krbG6h0zFabwMl3/t/HN9sSekuw6Byom7VwBKP2kU94wvA2OBlIw/Vn+EIjg 4w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrcj52f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 14:41:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VE8dtV005371;
	Wed, 31 Jan 2024 14:41:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9ewqka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 14:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5YRXLZOvByl9z3nRn3trX6qK/0QGVrtAbHMOq8DpBaM5JQ8+T9gEsFLf8logqNVOFE36qrtfWmq/KxK0Nhi0WyPvQkEpK0Vtrys7dxA8kHH9Zh9vCloR1gSMPDQXUG7RAr/dr4Rvy+rdOKP5QqVhB+O18jSlksdpKpHe0siC8bKHurZUeBl9jfhcXcxuu5fvSqJzicIq5x5JWWgT8scT7TMqhlLVUhdsAsqXgWClyw5rVO1KuGqXNeFw7w/Os4sm+Wml/xnrflpMtFJLmoHe4xjGIdxTWUp2WymnE0BHc87myRz0Wq5bQyclqd0cT5j26GZw1M9Vw+KRtpP3vaqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xnfv/kvowrquNlvr4hheTo+TSmktU9PTXHyqFFpCbno=;
 b=Z2aAXOuZD2eP6/3OeMxxTqUB/UXU2ckMR4yr8zHldSkrX9ZnF9FlWkMIjnjX1T5rfzw7o0mGt4taE7tUlBs765YwafTESixBaKzNua9BisjCAY7krOKwIv1e1eB7Gr6qxYju4qiXFi7XnDtAdbQqhLHR8rCAxGnV8FLUoZOP5gD/ynevQPB1G72zWkqqr2ATtV/+ZP7z/lm0TBeVvaJu/h9yjPMWDMw37K20oLO+Y0o1x/9j72qY8ehm1bBmbu3FYmd6lxqmsJNQ0+9tgFADyzIBVia6Gm5n0ZuX2O0aEQGdPr2qc81+ZqIr0pDU6IJ0wzwSuhcIbYCN9FN7e8Iniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xnfv/kvowrquNlvr4hheTo+TSmktU9PTXHyqFFpCbno=;
 b=WZL2ADtv5J2KFhdODXvTjdp+Kd0p5GDYibchts7xkqAA/35NibFdcQ4KDf3f/bsI9IJDYz444RujLdv69WjLyHp2qCqzpMfdfPAzb0X1JpEzSEpoQgqT0digH9LT6+bLp3uV+gDBQfZwBOAR8QEFfHBfitRT9ZUlvvgx4gZzKmA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5367.namprd10.prod.outlook.com (2603:10b6:408:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 14:41:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.025; Wed, 31 Jan 2024
 14:41:41 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Roland Mainz <roland.mainz@nrubsig.org>,
        Martin Wege
	<martin.l.wege@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Cedric Blancher
	<cedric.blancher@gmail.com>
Subject: Re: refer= syntax in /etc/exports for custom non-2049 TCP ports ? /
 was: Re: Change "hostname" to "hostport" in text-based mountd downcall Re:
 BUG in exports(5), no example for refer= Re: Examples for refer= in
 /etc/exports?
Thread-Topic: refer= syntax in /etc/exports for custom non-2049 TCP ports ? /
 was: Re: Change "hostname" to "hostport" in text-based mountd downcall Re:
 BUG in exports(5), no example for refer= Re: Examples for refer= in
 /etc/exports?
Thread-Index: 
 AQHaDXJPkaKnFSGKLkeVN9xiH7a/Z7ByuFQAgAAI+gCAAALcAIAAGasAgABndgCAAK6dAIADivKAgHm3SACAACn/AIAADsUAgAMdXoA=
Date: Wed, 31 Jan 2024 14:41:41 +0000
Message-ID: <0EC68335-F4EB-43B2-BF95-0C3A6E01FCC8@oracle.com>
References: 
 <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com>
 <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
 <CALXu0Uf2z3um+kh=tgnqskr-ZdY2gU=185K3Amr=F_GJpb2_UQ@mail.gmail.com>
 <FD981B2C-5C24-4349-A279-C70F640C0A01@oracle.com>
 <CANH4o6O=ihW7ENc-BTBXR4d4JL0QJjZa5YdYaKAdoHdq9vwGcA@mail.gmail.com>
 <5DA015E1-50C6-4F56-B4E7-62A4BE90DBA4@oracle.com>
 <CALXu0UcLV-KZ4GNY8UgWCwiUOO_HsH=KLWOKuWJ2uEDP+a9sqw@mail.gmail.com>
 <CAKAoaQ=FDdkTW2Vh=_Y08DEWZYaJa6tDSYKnFiZCfQ6+PW_5iQ@mail.gmail.com>
 <610FDE39-3094-40EB-B671-F2CA876CA145@oracle.com>
 <CAKAoaQkdf41emWL-2Uq9_kFjF99Xc7UEK_ur0MmnfFAjJqLM7A@mail.gmail.com>
In-Reply-To: 
 <CAKAoaQkdf41emWL-2Uq9_kFjF99Xc7UEK_ur0MmnfFAjJqLM7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5367:EE_
x-ms-office365-filtering-correlation-id: ad85d862-c9ab-4869-0c3e-08dc226abd12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SQK2jt4a8SUZS5GE3AcH2W+aPrVZ227BWODd8Dmfe6sCgms2SqZTg4c1+XKkCKLmuxTIz3Uf3kU23MDRSdsaWuy2qpZdr6wxj2Khp4PXfx7OTgSpRxe67S8r9FpKD9bQR082fLsgNr5kwCwJQjQzOHNzittpwWu7AtztMvlXkmqN7rNMJaQ5fK/thMrXDjFBz6HrOXuvDFpeqinn4V2FaBzWQi2TBflYmRExD58GbAhRZ0HpH1D7uYQLnYJ59PUGlSlIqHEyQNfyfvcixNS059hmLl6Ju/dh50TdZShz1EaX4jz97euzLyk4NzavHcopJfQuM47tqpYmMJLjs1ATMtE0kARY9nUtF2A4PfkANBOFvCnkYgTjg367HvOldBAWQY4GppFq5vP/xhse1rrTqud3wxCEommfUayPiTsW75FIp7t9fDj4YZLczYMKVrTOeX4/mGshE2XYV0vgfJ+NA9HbXxIxsd6u0jaVlwKE5ZIgQll6Ocgdr9KyIk5lAlzNzMmd1lFlerocukm80EdGQA042oSmcvtfbP9bsobkR0BcVEt9txZ2Tbvvp7tLy3714k36CP9quwKcjWSf2rxnoLU+VlykBXd/0KNV4Hraw+mYPCyPL/pi8b3zxFiYj9oIDVJxc8Ys629OBo1qcLVXeabmQoRby/LkHdz0CboClpjNqbvSZbIUjfsug5GKlkYBb58lOFEbtU5KkFUwhMeX/A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(4326008)(8936002)(8676002)(2906002)(33656002)(5660300002)(110136005)(86362001)(66946007)(76116006)(64756008)(66446008)(316002)(54906003)(38070700009)(66476007)(36756003)(66556008)(38100700002)(122000001)(6506007)(53546011)(6512007)(478600001)(6486002)(71200400001)(83380400001)(26005)(2616005)(148773002)(45980500001)(47845010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZlQ3c1VFd0Ywa2pUYXU2WG1iVkc1dWh2NmplSklPTVgxVG44d3BvU2RkaG5S?=
 =?utf-8?B?Uk1uRm5IbUhRU2IzaHN3OU9BR2hDOEc3MkE3Zkx5Q0R4ZzI4bXdUQ01FUjRY?=
 =?utf-8?B?aGo2eE0xMDU2RWxLdzB1em9LaG1tM3VudjhXekJXb3piSHpDRzdJTzRNK0Vw?=
 =?utf-8?B?S3JIdXNLZmxHTGFzOHpHWDA2bDVtT1Z6S1lTb2xGWjkrTEREU1RPZkE2Rlpw?=
 =?utf-8?B?T0Y5WGtwdTdrZ3UvR3Y4VDQ4NWdHVjN1SGxzL1paUU1Qa2Q4clJZaGlXQWJm?=
 =?utf-8?B?N0lTc1ViVkZ3VENlUkoxbUF0aWFwUHVJUXBYbEFMeWdUYTNXQzR1YlFmR3lG?=
 =?utf-8?B?M245K1d0NXRtSXN2NWpFL3g2UzE2aFV0QzNRMGY2TXBBRkRDWWVjZExEblFI?=
 =?utf-8?B?NzloM01HdlpmN2VJMzZoaE1DUzcwYnJpNHVjd0o4L2VMa1VmWGFPTHg2UXRs?=
 =?utf-8?B?djBrY09wZFh1UVh1bUNOVFlQZ282ajBmZlpML0Z5cXpzUUlVN2pKNzlIL3ZF?=
 =?utf-8?B?RnJLSmUwL2xwOEtzOEZoQkxCaUw5VlJZNkd1ckZtTUFaWU1KNGpSRXdnamhC?=
 =?utf-8?B?bEZ3b1RnT3Y5SzFBdHBxOW5Hd2NtbENkbXRFQkhJa2xTc1F6ZVNhR3poU0h1?=
 =?utf-8?B?eWVsVlNqaFZVcEdWMi8zR092b1VDaGtBd29ZMEYzWUU3K2FBdDlCMVNURkxo?=
 =?utf-8?B?VVVVWURKS05hYVVDMU8wRjA1T0o1RGpDQjJuRlpVQWpiQmxSVEJISlRzSXZK?=
 =?utf-8?B?YnhobEVVMlhtdVBMVHMwTnc3QnpLV003eEVtZ0FwMDJ2OVBWdUZneUlJY0RW?=
 =?utf-8?B?T1hvMzJxLzh4Y2N1ak5ZNlphcUdsRVYzd29zQjk0RExnc0tVWUlFbm85SVVi?=
 =?utf-8?B?L2RBVjVyOWc2SFpoZHRPRGljNWdvZUhrRUtHL0FNbWx2Wmo1SW5MaUs5RnYv?=
 =?utf-8?B?RnluQm5oRWJlWHJlRDAwNjlsalorc0hBSHUxZWRvemVROWtBQXVuUFpDS25G?=
 =?utf-8?B?VVpzM3ZiQ3VqM0liWGJlM2JIbDRkcEJnUHZmcWF5dlgvVCs3aTJ0TWRQNVYx?=
 =?utf-8?B?WjJtRCtjaDhaU1BIejZwSVpxa2NFdWJaYW81R0JPaGd5QkcrcW0wUTd0a2NH?=
 =?utf-8?B?cTBHMGRjM0hQb3NRall6aEFRNU84ai9lbmtpMURPVmQxbC9uRURGUnVCaTRC?=
 =?utf-8?B?UVl6SlVmT3NscGZLQXNCZGpsdjJxdXhSQXRITlB2b253K1hOQ1pDQmFmcmcz?=
 =?utf-8?B?ZVRhUWE0VU9OUW5QczJqZmRvMlZoWGJCMDFNTkdOcURUbVhnd2hkZkc1c3pm?=
 =?utf-8?B?SHh3RlNMNEZ6LzBiRktiR3Y0ZW9LMzBTQlp0VzJ4Z2VIT2ROYkhIdmgxUk1j?=
 =?utf-8?B?YlpiaTJKbTR5eVJhcUlHSGNvb3hCUm5ZaE9xMEhCU2p5bmRHbEtWNTdhRnBT?=
 =?utf-8?B?SFZTUTFPR3VKTSs4NEZlaWFHaEV3bmJBTE8yMG4wUDBubHkyZkpuY1NyRktj?=
 =?utf-8?B?MFRNUC8vVWZscEhsNERpWVp5ZEpENWF5WkhEMzNYZ3ZmK09aNlUvaDlIald5?=
 =?utf-8?B?Qzkyd0hTOHE2VTN1a1IwUWhMNWxUQytqbkhRNWs5T05rblNlMXFqSHNDdVNj?=
 =?utf-8?B?cTRLalZocVltTE5EemxFVkV6R0lrZ00zaHVTOUpEVWw0Q1pWT1dVUjBNUjJH?=
 =?utf-8?B?ZkRVbFllNFJuK1VsejhCZm9ydTlERU1ndk5TUkpRSHZjNXJncDVTMjZzNWxN?=
 =?utf-8?B?YjRITjVIbkVGd3FQbGNiWGlxMVZValVyQUxQMnFWT0p6NDh6eWhjanZwdjBT?=
 =?utf-8?B?V3lLVW5IdFVIU1RtMTRLZ2ZicVVJWnp5V1RPeit3WEtKOEJCdFFLRXlheU1i?=
 =?utf-8?B?ZGRmSmlJNVRQSUEweUZOQXI1amZ0aGdJRitwTTZTU3FoaStSMW9oZjBscnBS?=
 =?utf-8?B?M1NzS04zV1FGanZOYXBFZ1UrUUEwS1Q1aXpjWW4zWU5QRHB2WDVjZXNaeTly?=
 =?utf-8?B?bkI5akhHMkRqV3g4bzBnY3VOYXRwK0ZQUWdwbnFQNy9zWkE5aHZacXlGWFZx?=
 =?utf-8?B?TGIvSXl4RGVseC9ldHdyYVlBeERwNVZXZkpVOGN4ajQ4MFFJKzh0VnliVUhV?=
 =?utf-8?B?MUpJOEtaUU9MQ2E3NGt1Yk4wRWdUMy83elVlRWJWaG5Xei9jWWRscGs0RmRI?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6F7C41F3D4C4B4392FF718B8980BAC2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cAN01DxpnoVE93wAGnh22DJDnswux/be8qwq1vgRdEV/blJmMYyvLXmwk5/wDaJx5+vPctawvnJRkpU99/GdSaIlHciH3TmN365NvfMH/j1slx3nVLzi0gpumyWYwemn5qe5jcn2qSzvSkiOQI8IonmCvFU9fC53zEaQmcU7m08tQRNALuQj86x1dRBkJ6r1DexZTg2LeV7KmmH6mTo/4mevXiIgi8QFzElzw41FQlRrr/9i0aqyr51GQ5jYpVsafG+lO4BOseDorQTU7q0EtasOObThZmGhMA7rwnAO4f4PpLYmcjLcwIG3VahENqg3bExCsgUWr37kX4zlBK02IzyM1UaBMPwHsUgmbxjogi1i1ruE9Lwi5LKGr7Td838Q9vK3GjjrCt2kSMz1HOdpNKUsuas0/xcw6L7enwDb9+BhwHh/v7Jr4lLTpGQLGzDFT4rW5A1t3hZ8XaqIUK3/HxvubfYUXdjOj1vIh/001Q8o06YlxxSq1hcQvE1BGoqGYSEwiEZ6FJWbKeIABf1pxO/LH3yHinAbjpzbV7Fn3NvLJyn8mjSLZJHZ0ekveLd1y92A3mU3OOXBK8gTgQ8DQe+3KtHOXnB7Qk9dh9cJREs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad85d862-c9ab-4869-0c3e-08dc226abd12
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 14:41:41.3669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Jaq9ATE2/C5zzErGOaEF6F1wtTTjcDtQEp9cXMycJBReOBt+PvsysePJuMhznjqS7QY9CWRMT+CFXF7m9m78A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5367
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310112
X-Proofpoint-ORIG-GUID: N0tTguI-OOWW2bsoxBAXmxAhUYqroDDy
X-Proofpoint-GUID: N0tTguI-OOWW2bsoxBAXmxAhUYqroDDy

DQo+IE9uIEphbiAyOSwgMjAyNCwgYXQgMTA6MDfigK9BTSwgUm9sYW5kIE1haW56IDxyb2xhbmQu
bWFpbnpAbnJ1YnNpZy5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBKYW4gMjksIDIwMjQgYXQg
MzoxNOKAr1BNIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6
DQo+PiANCj4+PiBPbiBKYW4gMjksIDIwMjQsIGF0IDY6NDTigK9BTSwgUm9sYW5kIE1haW56IDxy
b2xhbmQubWFpbnpAbnJ1YnNpZy5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IFdoYXQgd291bGQgYmUg
dGhlIGNvcnJlY3Qgc3ludGF4IHRvIHNwZWNpZnkgYSBjdXN0b20gKG5vbi0yMDQ5KSBUQ1ANCj4+
PiBwb3J0IGZvciByZWZlcj0gaW4gL2V0Yy9leHBvcnRzID8NCj4+PiANCj4+PiBXb3VsZCB0aGlz
IHdvcms6DQo+Pj4gLS0tLSBzbmlwIC0tLS0NCj4+PiBgL3JlZiAqKG5vX3Jvb3Rfc3F1YXNoLHJl
ZmVyPS9leHBvcnQvaG9tZUAxMzQuNDkuMjIuMTExOjMyMDQ5KQ0KPj4+IC0tLS0gc25pcCAtLS0t
DQo+PiANCj4+IEhlbGxvIFJvbGFuZCAtDQo+PiANCj4+IEFsdGhvdWdoIGdlbmVyaWMgTkZTdjQg
cmVmZXJyYWwgc3VwcG9ydCBoYXMgYmVlbiBpbiBORlNEIGZvcg0KPj4gbWFueSB5ZWFycywgTkZT
RCBjdXJyZW50bHkgZG9lcyBub3QgaW1wbGVtZW50IGFsdGVybmF0ZSBwb3J0cw0KPj4gaW4gcmVm
ZXJyYWxzLg0KPiANCj4gSSBrbm93LCBidXQgdGhlIHF1ZXN0aW9uIGlzIGFib3V0IHRoZSBzeW50
YXggaW4gL2V0Yy9leHBvcnRzLiBUaGUgaWRlYQ0KPiBpcyB0byB1c2UgdGhlIHNhbWUgc3ludGF4
IGZvciBvdGhlciBORlN2NCBzZXJ2ZXIgaW1wbGVtZW50YXRpb25zIChsaWtlDQo+IG5mczRqKSAu
Li4NCj4gDQo+IEZvciBjb250ZXh0OiBJIGhhdmUgYSB0aWNrZXQgb3BlbiBmb3IgdGhlIG1zLW5m
czQxLWNsaWVudCB0byBnZXQgdGhlDQo+IHJlZmVycmFsIHN1cHBvcnQgd2l0aCBjdXN0b20gKG5v
bi0yMDQ5KSBUQ1AgcG9ydHMgZml4ZWQuLi4NCg0KSGVyZSdzIGEgd29ya2Fyb3VuZCB0aGF0IG1p
Z2h0IGJlIHVzZWQgd2l0aCBjdXJyZW50DQp2ZXJzaW9ucyBvZiBORlNELiBJJ20gZ29pbmcgdG8g
d2FsayB0aHJvdWdoIHRoaXMgYmVjYXVzZQ0KdGhlcmUgaXMgc29tZSBpbmZvcm1hdGlvbiB0aGF0
IGNvdWxkIGJlIHVzZWZ1bCBmb3INCm1zLW5mczQxLWNsaWVudC4NCg0KUmVmZXJyYWxzIGFyZSBj
b252ZXllZCB0byBORlN2NCBjbGllbnRzIHVzaW5nIHRoZQ0KZnNfbG9jYXRpb25zIGF0dHJpYnV0
ZSBvZiBHRVRBVFRSLiBUaGlzIGF0dHJpYnV0ZSBjb252ZXlzDQphIGxpc3Qgb2YgYWx0ZXJuYXRl
IGxvY2F0aW9ucyBhIGNsaWVudCBjYW4gdXNlIHRvIGFjY2Vzcw0KdGhlIHNoYXJlIGl0J3MgbG9v
a2luZyBmb3IuDQoNCkVhY2ggaXRlbSBpbiB0aGUgbGlzdCBsb29rcyBsaWtlIHRoaXM6DQoNCnN0
cnVjdCBmc19sb2NhdGlvbjQgew0KCXV0ZjhzdHJfY2lzCXNlcnZlcjw+Ow0KCXBhdGhuYW1lNAly
b290cGF0aDsNCn07DQoNClRoZSBjb250ZW50IG9mIHRoZSBzZXJ2ZXI8PiBmaWVsZCBpcyBlaXRo
ZXIgYSBob3N0bmFtZSBvcg0KYW4gSVAgYWRkcmVzcy4gUkZDIDg4ODEgU2VjdGlvbiAxMS4xNiBz
YXlzOg0KDQo+IEFuIElQdjQgb3IgSVB2NiBhZGRyZXNzIGlzIHJlcHJlc2VudGVkIGFzIGEgdW5p
dmVyc2FsIGFkZHJlc3MgKHNlZSBTZWN0aW9uIDMuMy45IGFuZCBbMTJdKSwgbWludXMgdGhlIG5l
dGlkLCBhbmQgZWl0aGVyIHdpdGggb3Igd2l0aG91dCB0aGUgdHJhaWxpbmcgIi5wMS5wMiIgc3Vm
Zml4IHRoYXQgcmVwcmVzZW50cyB0aGUgcG9ydCBudW1iZXIuIElmIHRoZSBzdWZmaXggaXMgb21p
dHRlZCwgdGhlbiB0aGUgZGVmYXVsdCBwb3J0LCAyMDQ5LCBTSE9VTEQgYmUgYXNzdW1lZC4NCg0K
DQpUaGVyZWZvcmUgdGhlcmUgaXMgb25seSBvbmUgd2F5IHRvIGNvbnZleSBhbiBhbHRlcm5hdGUN
CnBvcnQuIFlvdSBjYW4ndCBkbyBpdCB3aGVuIHRoZSBzZXJ2ZXI8PiBmaWVsZCBjb250YWlucyBh
DQpETlMgbGFiZWw7IHRoZSBzZXJ2ZXIgaGFzIHRvIHNwZWxsIGl0IG91dCB3aXRoIGEgdW5pdmVy
c2FsDQphZGRyZXNzLiBUaGlzIGlzIHBhcnQgb2YgdGhlIE5GU3Y0IHByb3RvY29sLCBpdCdzIG5v
dCBhbg0KTkZTRCBsaW1pdGF0aW9uLg0KDQooV2hlbiBORlNEIHN1cHBvcnRzIHRoaXMgcHJvcGVy
bHksIGl0IHdpbGwgbmVlZCB0byByZXNvbHZlDQplYWNoIGhvc3RuYW1lIHRvIGFuIElQIGFkZHJl
c3MsIHdoZW4gYW4gYWx0ZXJuYXRlIHBvcnQgaXMNCnByZXNlbnQsIGJlZm9yZSBpdCBidWlsZHMg
dGhlIGZzX2xvY2F0aW9uNCBsaXN0IGl0ZW0pLg0KDQpJdCB0dXJucyBvdXQgdGhhdCBvdXIgbW91
bnRkIHBhc3NlcyB0aGUgImhvc3QiIHBhcnQgb2YgdGhlDQpyZWZlcj0gb3B0aW9uIHRvIHRoZSBr
ZXJuZWwgd2l0aG91dCBtdWNoIGFkZGl0aW9uYWwNCmNoZWNraW5nLCBzbyB5b3UgY2FuIHNwZWNp
ZnkgYSBmdWxsIElQdjQgdW5pdmVyc2FsIGFkZHJlc3MNCmxpa2Ugc286DQoNCi9leHBvcnQvcmVm
ZXJyYWwgICAqKHJlZmVyPS9leHBvcnQveWFkYUAxOTIuMTY4LjEuNzcgPG1haWx0bzpyZWZlcj0v
ZXhwb3J0L3lhZGFAMTkyLjE2OC4xLjc3Pi44LjEpDQoNClRoYXQgaXMsIGl0J3MgYW4gSVB2NCBh
ZGRyZXNzIHdpdGggYSAucDEucDIgc3VmZml4Lg0KDQpwMSA9IHBvcnQgRElWIDI1Ng0KcDIgPSBw
b3J0IE1PRCAyNTYNCg0KSGVyZSwgLjguMSBpcyBwb3J0IDIwNDkuDQoNCkkndmUgdHJpZWQgc29t
ZSBzaW1wbGUgdGVzdGluZywgYW5kIGl0IHNlZW1zIHRvIHdvcmsgd2l0aA0KYm90aCByZWZlcj0g
YW5kIG5mc3JlZi4NCg0KVGhpcyByZWZlcj0gcG9ydCBzeW50YXggcHJvYmFibHkgd29uJ3Qgd29y
ayBmb3IgSVB2Ng0KYWRkcmVzc2VzLCBhbmQgZGVmaW5pdGVseSB3aWxsIG5vdCBmb3IgRE5TIGxh
YmVscy4gVGh1cw0KSSBjb25zaWRlciB0aGlzIGEgaGFjayBhbmQgbm90IGEgbG9uZy10ZXJtIHNv
bHV0aW9uIGZvcg0KTkZTRC4NCg0KUmVnYXJkaW5nIFJvbGFuZCdzIHF1ZXN0aW9uIGFib3V0IGNv
cHlpbmcgdGhpcyBzeW50YXggZm9yDQpvdGhlciBORlN2NCBzZXJ2ZXJzOiBJIHJlY29tbWVuZCB0
aGF0IHlvdSBkb24ndCBkbyB0aGF0Lg0KWW91J2xsIGVuZCB1cCBjb3B5aW5nIGl0cyBtaXN0YWtl
cyBhbmQgbGltaXRhdGlvbnMuIFRvDQphbXBsaWZ5IG15IHByZXZpb3VzIGV4cGxhbmF0aW9uOiB0
aGlzIGlzIHVuZmluaXNoZWQgd29yaywNCmFuZCB0aGVyZSBhcmUgb3RoZXIsIGJldHRlciB3YXlz
IHRvIGhhbmRsZSByZWZlcnJhbHMuDQoNCk1vcmVvdmVyLCB5b3UgY2FuJ3QgY29weSB3aGF0IGRv
ZXNuJ3QgZXhpc3QuIFNpbmNlIE5GU0QNCmN1cnJlbnRseSBkb2VzIG5vdCBzdXBwb3J0IGFsdGVy
bmF0ZSBwb3J0cyBpbiBhbnkga2luZA0Kb2Ygcm9idXN0IHdheSwgdGhlcmUncyBub3RoaW5nIHRv
IGNvcHkuIEVhY2ggc2VydmVyDQppbXBsZW1lbnRhdGlvbiB3aWxsIGhhdmUgdG8gaW52ZW50IHRo
ZWlyIG93bi4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

