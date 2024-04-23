Return-Path: <linux-nfs+bounces-2955-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE638AE81C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 15:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9061F22BB9
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9962A45BFD;
	Tue, 23 Apr 2024 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lTjd0HTF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mYL/nr7r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054B6A03F
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878830; cv=fail; b=CiQWzcS84rhbQzK8Ptfe0o6LqUMHh7PnDZB70TagfUWv9EapuIUG5m9remYif88yal8Werh6j3QHLxglrh4D8Wap07FWRGVr1v9gTQgsfSqVYkLnXqgMVwTy6D+QV8Y6lTzKFM4I/l3x85zm7Vho3OAa7a2C2EaW16C6YTe8s3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878830; c=relaxed/simple;
	bh=Ngx6F5sFjaqvchos93vs9IzYT6jJV6P+ed4p/cnVFKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OnpL5dAUJC7xvtNzygRb39lMgONvYrYh4Z1F+uNbgVGbHS6KdzxnMEFXArpAgt/r7H2oA9F+CBv/0BkErWugLcNObCKWlqkxt2mq1+EVfkmivWhCVAxSb/GuN/M0xbbdiNk8s0Z7Ewf8ph3HPiCIzMoRfeIub6C3c44CoWAup70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lTjd0HTF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mYL/nr7r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N7YECq006399;
	Tue, 23 Apr 2024 13:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ngx6F5sFjaqvchos93vs9IzYT6jJV6P+ed4p/cnVFKA=;
 b=lTjd0HTFjN++qDye5WQS8uUpTGvcuskEtLCgdYUJSq6ogwOatOY44V2YIrUaRfuqkOMu
 EvmThJ22rZ+/B+L2Xx3qA07U9qrIRLUilX5PeXDuYVzx4Tigkm7/b42EyiqZdtUzfTOX
 C70apBYZkxK50TKFx5OBJLl/2HeQ1btJvKpJVLO3tttslIO1j0lf3GNQWGxqZ3odoSmF
 HHnuBkSHw8nSDKfxzU9L6tPEB6ywbtJXtT825ReGnv1Kssg2OIc6xUY7wrJznmsfVHs/
 gV+yhDVczd75Qv2dtbRx0kkVTrAt9/N1XEa2H5+d1wNDtSxJ9xwvCp3Uoffpu7cUBFIH eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4d6ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 13:27:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NDJeRA001768;
	Tue, 23 Apr 2024 13:27:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm457pa07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 13:27:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXANxQwep+T8iW01bsHDA+xLxZutjJDtmCESxqztlOvYiHTKwPRB2BvIbgvg4rutNYd0hC4QiVdfxHN5sFS6VQhPTyQe+BPivPDLHn0SIoP343rpMhDijP5qhg01r9B4Y2wRlFtyE4AaP0lkMeQExwtBAc6DYYLYv7YXx8DKez/5Y5tiP90FoJvc8WJ/HdC4bwAooN+W5GEuYCIOTVasres1PUKrhjYlHqtgQiB9nu5/c42xqP7STfmsW2NFNrOG3nfMDFUqHg6QZqiGcdp9f9VR0TPngfFSHgcTygrMQruiOK8vovF9H3fgtlSqRiXCSSLabbIlnT8uky6mWBaWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ngx6F5sFjaqvchos93vs9IzYT6jJV6P+ed4p/cnVFKA=;
 b=UiPen5DRT475xo5UPFr46rkIa6DUwE3UvzfBMQEyKQLRFi4iq9UezhFUhboYTxh7XHIug3W4a0GW94AEDv92Rc7461g72UtO6KSBdOiIbOEOlQgzkQcqePHto85MxTr1S0yYBg2sNaXKMfBPQF9y9unJCUCBlE73i1MxOn53xR2fHNT2gxasR7WFKyq5IbQ4SWqOdnK9BqqY5nNxLfZnl+0/X83xikcp6Xet/lFRt4sA7uI5yKaTLjqBKZ2IgyH4HeRec3cxmRdeL87mtQajq738W/KLm0Ht8SsOO4tI2nMbsmlsGjC+vx8a1TE3lZM23j5eDNzrN0988C8F7DB/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ngx6F5sFjaqvchos93vs9IzYT6jJV6P+ed4p/cnVFKA=;
 b=mYL/nr7rLk8xTtkVHjTYrwlfTD98NsZupVuoTERB5SW3W4Onb1WpGKgi3+VgpX4fhkyd7wOARE2Sk/ZaG81G0FgQKeLFaB9dvlVVdwSzHj686LJyFx9U3B5mPQy2jKekFtrLnvb2YeMM7eJEpGymhiPSJL9pneI8XBii36nk/xM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4326.namprd10.prod.outlook.com (2603:10b6:610:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 13:27:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 13:27:04 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Robert Ayrapetyan <robert.ayrapetyan@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS server side folder copy
Thread-Topic: NFS server side folder copy
Thread-Index: AQHalBKo9fcbMcOhJkSr7RYo6lzFVbF126sA
Date: Tue, 23 Apr 2024 13:27:04 +0000
Message-ID: <27859A3F-39CD-4BD5-ABC2-A0B12C5880F3@oracle.com>
References: 
 <CAAboi9s9=h-ULoTJ4kcTi3S297RWou0JfBz5nTQP90pVpA37bA@mail.gmail.com>
In-Reply-To: 
 <CAAboi9s9=h-ULoTJ4kcTi3S297RWou0JfBz5nTQP90pVpA37bA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH2PR10MB4326:EE_
x-ms-office365-filtering-correlation-id: f827c26a-ead2-4aa0-16ce-08dc639910e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RVhBTmw5UTNpSnhWR21EcXp3K0xLVWVXYWdDUGVRRXlhWjlWY3NiaXdNeEh3?=
 =?utf-8?B?VTZENEJZcjl6T25uQ21hdXlZczF1dk9ldTlXSVpsSFVieUFiQ1pBSXNmWUNk?=
 =?utf-8?B?YzhBdHpEM1pvY0NvMmtlZ1lNdHF4NUJ1QUFzWGFNMWsyeEIzYTJ4L2VvM1hQ?=
 =?utf-8?B?NmMwN1EySkZRVU90TkNveXNkQTcvV3diRjVTSkVNUXlDV0RkR1MvUjByc1FB?=
 =?utf-8?B?YzBacFlVTW1ITndIS29STllhdWJKRVVRQ3U1STA2cGFqQ2RhMGJkVTM5TEgy?=
 =?utf-8?B?dGV6SlY2NjZvdFRGbExaWm1ZRlhRZHpSbUpwVHAvd0h3UHBxUnNRREhVQlQ1?=
 =?utf-8?B?WHFIWTVsR3lLVFQzSi9FcWVIRlFCdkE4VnhkOGtuM01jMDhKUnpJSWVqaCtH?=
 =?utf-8?B?OEZVQXA3M3owR09jbWhqT3lxZytwTFpRUGU0enhkZHV0eDVqdHpvQnhweWpk?=
 =?utf-8?B?cWFWSkMyRTBEc3E3TExmbmpLanVXcXNVZUJKaENJM1UxQUhDcnlZWmhuQjZi?=
 =?utf-8?B?MU9tc1BCbUs0VGFMayt5TGNncW85YXNXUGJCL1NsVXBPN0sxUktWREcxVzJx?=
 =?utf-8?B?V3hQYWdWTDkyS1Z5RFEyZDFXK2RiWjRwSXZlbW5RcEJhbUZTSVB2YURxME1N?=
 =?utf-8?B?TEdjMjN3ZjNnZ1hFZE1LTEdEVjhqVHFPNTJ2WVlKNlBZT1VEbHhPR204MWpK?=
 =?utf-8?B?WXZDK0ZUVzlCTmVvS2hoYnhxNTJTMXZoTkh3cUtjbGRZeVk4dS9kSlBMSzJW?=
 =?utf-8?B?NXMxUmRldzlwZXZwNG9kVGlOdVNiUWdNOUJoTUtqRGNBZXZMeEV3YVFqa2tT?=
 =?utf-8?B?ZFdJQ1BsMVRrSzdYbFIxL1pYb25MUW91VUVlZWgxTWJOcGV4NWw5K3hOMVEx?=
 =?utf-8?B?K2krT01DaGtYcm9QN1lLWGo3ZkhXQmZ2WCtDY0J3WVBJYWdFSFZMc01IdXBn?=
 =?utf-8?B?T0FXVWtzRFE5Tjllak5pdzRBanFvRVpiS1dvSTNEa3p5WjEyaDVNOVVTVnlu?=
 =?utf-8?B?WlZvQnJQcFFMdTROVG91YVcwNnNDK0h5azZNTFhpSk1LdS93S0pZWmxIc3o5?=
 =?utf-8?B?NHdMSUtWbWpEVVhOelgzeGUzVVlHTGRIS25XNHZMaC9jMUVodUNqTy9MUStH?=
 =?utf-8?B?SXZTaWZLNTBqUGFnRmJucnJmWDVaMWVsSFozanV1aThiWkY4RGdrTGJ1VkpW?=
 =?utf-8?B?OEl1cWFUMWIrYlJRZ2VocGc3eFdKU1cxb1VCRXFIek80QThrT0h1SC9IR2Y0?=
 =?utf-8?B?NGdQcWZzMGlja2huNS9xZFFBTWhkVlVTRXFoUmZtajVGNkpCWDZyTFp4dW44?=
 =?utf-8?B?bS9yRXc3dFpPSURGRG9qUHpWclg5L0FoSUJuTGNheTdYaTBoM1JwUDNjYVdl?=
 =?utf-8?B?Z01TYUNkeVF5VkhXWVR1VmMraFVtU2l4VnZ2MDJLWjdYSmc4cytBVk5janJt?=
 =?utf-8?B?WHBoU056a2F4N2FhTkdMMmpGeGgvRmpCdmk2dnhMYVdMWFpZdmtHZkI3WUdD?=
 =?utf-8?B?elBuNnozNjNEN1VKdVVvNWNGb1R3WlQ4bXlFWDNKbFc4YW5ndkVXZGdTTzRF?=
 =?utf-8?B?eWZUOTlHalZXdDNZbEVEdnloL0trcXV3cE9NcHNnTkkyU1hMVzZ5Q2Q5WkdY?=
 =?utf-8?B?UDdTVDJLWHlQMFJKSHpBbnVnZmpmN2c1U0wzQW01cFFDOGhFWEFOeGVhK3VU?=
 =?utf-8?B?WlZMekVHU0JoTUR3dmtnYlRIY1MrRHVZMzhyOWYyYkhGRkpHa0daR0kyeVZj?=
 =?utf-8?B?ZmdldmEreUZhTC9TSllqeXMrNUZEeTdIaGEyUmpsaENscnhRTm1Xb1JDM1pU?=
 =?utf-8?B?cTNEYzBFVUJPS3BoOW9SZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eFhxRG4zQXk1RWdUaW9INGlpZGtiY0c3WXVSNHVLU2xGaWFmWDhrUFdtWStD?=
 =?utf-8?B?eDgyQXRTMllJbVF3cjJyMDF6RkwrSk1yc1BuRjlnRXp6NHpEc0RZbUd1dGts?=
 =?utf-8?B?M2szQjRBd090bi9hZS9LWEUvNkM5MldWUUtSQWhwS0IyODlDSll2QlNRYWVK?=
 =?utf-8?B?dlZubHZYNlR0V0FtakpuRExnUmdWMjFtc0FBWWNUeFVoSXRwdWsyUUloUVla?=
 =?utf-8?B?Y2JhY29kMTZ1eWFXdlN6T3M0ZUgvU1d4Ulh1bStHV05aNkk4RjE1S25ZZG9J?=
 =?utf-8?B?UDRONDdZS0x2NGJ4cXhSNGNLajlTU1EvRUlYOEdxQm12dWd2UzJMcDRwa0w3?=
 =?utf-8?B?TUlkNHhNamlSUmxYczNTVEUwTWd5NlpaS3pLN3VEOUhaRkMvcXFsVEpBcDFu?=
 =?utf-8?B?QldNeFBPYWxDb0tiYnFlc2dEYlV6d3RaZXdZMXB5ZTZyb2llY2pHRnVXdFI2?=
 =?utf-8?B?RnhnemNsOWg5N3FTUCtPMzZlaEd3eGdUcEhRNXNpdnVxMS9qdWQ0QjJQSXJ6?=
 =?utf-8?B?c2pDUHJadTUvNGJZQ291MWtscEJpS2xyWE82QnhjQ3JDMXV6OEJHRnlYdkhx?=
 =?utf-8?B?dXo1MUg4NUE4TmthQWlUUHB1VVVPR2Via0E5RXhKb1lLdWxQN1FvMjMxZGMv?=
 =?utf-8?B?L0phRWRUTzNrV1FOenVhTjltVVhUdDNhdk5yd0NtRXVkcCt5c2R0VkNNOEpL?=
 =?utf-8?B?Yk5UeHNmRDNtcmk3RHB1SVNmd3dYWXhCMHloNTJGVE5adFBpNGlyY1JRcFBZ?=
 =?utf-8?B?NnhOQUF1T2NaRWlEb1pybDhMU21CQXBoR2RQNXY2K3FoQTBMQzhQNll6SEgz?=
 =?utf-8?B?b2RkN09odGtUSUdtUFV6ZUo2dEFJdllhc29aNDRYM1BPdytYZkwyYXBNMkk4?=
 =?utf-8?B?MWJDWW9DMVJ6dStwbVl0eG50RmRZeGgyOWpZSlhGVGU1b3FkMldzM0ovSW41?=
 =?utf-8?B?blExbDdwRHpRNXBlMEFWTVUyRDdhbi84bUY0OExQaFdERklCNnJ1bGVVUGV3?=
 =?utf-8?B?ejV6VCszeWZ4dE55bUNsT1pZSFNmRStpNlZDQjBNcm8vNVZxOFhLTURQcjJD?=
 =?utf-8?B?MEg4WUtvMmZuZkY3ajkrUUhaT055RzdWODRXU1ZDWkRuK0h3NTV6ek90N29u?=
 =?utf-8?B?UmloakFkem9WeS82RnlUc1dKTzRZRllZb3QzQlRNdmZ3bjV2dzR1SlMrMjNh?=
 =?utf-8?B?TzJtTlp6MVhjYXl1YnUwRHZVSVVEVCtpakI3a3NQRUg3b0R0Rkl3MkZoK0ln?=
 =?utf-8?B?K1N6R3ZzeGZ4SGQrbURGanRIb2F1UGg5RVNFZGlMUytrVldoeGhUMURoaTJl?=
 =?utf-8?B?TC9YTjloNkM0anhZV1NVRGRVWnNlVGhCckVRMVdObUx0RkgxR2l4TDFQMVpm?=
 =?utf-8?B?Q3dXTUh5NzlvazdRaW1WZ3VFL05zbXNOZVdVVW5TUnYvbkQvUW5xczFia3FC?=
 =?utf-8?B?a2syK1FuS1ZNbWJuU05NRDdVdytnYlR1NHRROWtRUDlVTWN0VlcxemJqeEpN?=
 =?utf-8?B?ZmloYktaaHFUWmNQT3FBTVBVK1hURXhPY1dMMXRUWXB3bWpkM2xqWjF2WEYw?=
 =?utf-8?B?cnpWWkFGMHVWblhhVGtHbFpJbjFTT0JNTDl3cnl1TVYvVEk1NEM4cTc1Y2E3?=
 =?utf-8?B?UXh5akd3eGwwckJRVDBDcHpLbHE2K0xHL3JzUFFJejlFUUFXaFVEOTRRMmkv?=
 =?utf-8?B?RmJJN3hzRWlleklHb20xeTFFMWtFVkxzdktaTjU1emZ2c1FOL05kdVdnZDJ2?=
 =?utf-8?B?LzhsNUVFRjVqTTNIa1c1UnlnN0MzSGdqY29mTDdiOVVMQnh4b01EaHJzZjNS?=
 =?utf-8?B?ejlBSTZNTHNBTHdrbkVLY0JUODBQUmg1VlhLNXBlUmtMbUtLV1ovMSs2bHpp?=
 =?utf-8?B?VWlaVG9kQlNUQXREbVFjRk1rQ1lQdWUrTGN2alVZc050eGxNN2ltd05TM3Jr?=
 =?utf-8?B?ek0wNk12SVFSNTlnMVpoUXNiMkJLdFZoMUlWUHNxWG90M2VzN0EwRjVxbS9H?=
 =?utf-8?B?clZxQWVDWTh5djFmQ0RvUEh0dmcxOFJoZE1yejFLT2lmNm1jNi9HYW92elow?=
 =?utf-8?B?SWZiTnU0ZXZ5THEwcExYZXhmNXdoNjZTUU85YnI3TU5QcnZQUWVoNFhFcnJJ?=
 =?utf-8?B?MWVtMU1sR3FNOXBsV2UvT1NJTzlZcVlXcmdxY0w5V3h6NXBoalhabGJFejk0?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F35A2627D352DB46A1E65498A2B40E06@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GCVAkf5Qq0S+g4tUTdklvbqa4xknR4Asi7ny7CP73W7bbNa9SN8FOw7lm0OAD/96ZCODpFLs8N4g3MhoiwdCVTWqLo3IQVb4cXYWzvxyfA7yKgp528/SzC2Av06C1xg4HjFUeQkGDlNhBsFCh1RyCQLLLM8NijIxmJ21XHsYTknAeZDmpEFXB4Km1J6Z4X0ljfBCKjZrag2OSmj4vEZBsVgj3htACX/4AuVvJbK1ynWf2hULQxvTwW/2W5X+F1gjOyus1lvQDceOiR4k7STobw78I5a+jKraLCwfoBJp9+azt1bti3L/0xC6Slhkw/Zt7tXJ08B2c/64ETq3yxrhAox53YGUELavTb3sCAep2aaYAAnJVjDEhtKZTlWE85ckTwAdtp8U43dI1fDgAyUMCjjvbbLSoKD0POP7yFV6p8mwtvtA+bvfSZxxmVFgFXFxMMSQTqC5wgVnS2KjI7LGjYIelCctF5ZiFIRdFdrdHD8GUCVZBx4TYPNgpWj7bKer8LYBtiWEpIDwP34Q+AkP7iSEAa4Htbn+YMCIfd3ys20O6+jIivRh00yEGREFirIP6ibz4eF2Bjsb6DtraffTNV/eRuEHhinurXA9jVfq0t4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f827c26a-ead2-4aa0-16ce-08dc639910e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 13:27:04.3563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tcZ5BDVZdm6nQtyo5PBxDZCiQikdxD83Jpg5+QuWRz9SMKW5//pib6pF/61N4WfUByP7tHbgy5lbwStFWToU5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_11,2024-04-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230034
X-Proofpoint-GUID: 5fTskrphqNn0A-fZHxqBxaJP5gt_yIQS
X-Proofpoint-ORIG-GUID: 5fTskrphqNn0A-fZHxqBxaJP5gt_yIQS

DQoNCj4gT24gQXByIDIxLCAyMDI0LCBhdCAxOjM34oCvUE0sIFJvYmVydCBBeXJhcGV0eWFuIDxy
b2JlcnQuYXlyYXBldHlhbkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSGVsbG8hDQo+IA0KPiBB
dHRlbXB0aW5nIHRvIHVuZGVyc3RhbmQgdGhlIGltcGxlbWVudGF0aW9uIG9mIHNlcnZlci1zaWRl
IGNvcHlpbmcgb2YNCj4gZm9sZGVycyBtb3VudGVkIHZpYSBORlMgNC4yLg0KPiBDdXJyZW50bHkg
Y29weWluZyBhbiBlbnRpcmUgZm9sZGVyIChjcCAtciAtLXJlZmxpbms9YWx3YXlzKSBwcm9kdWNl
czoNCj4gDQo+IG5ld2ZzdGF0YXQoQVRfRkRDV0QsICIvbW50L3NvdXJjZV9maWxlIiwge3N0X21v
ZGU9U19JRlJFR3wwNjQ0LA0KPiBzdF9zaXplPTI0NjYsIC4uLn0sIEFUX1NZTUxJTktfTk9GT0xM
T1cpID0gMA0KPiBuZXdmc3RhdGF0KDMsICJkZXN0X2ZpbGUiLCB7c3RfbW9kZT1TX0lGUkVHfDA2
NDQsIHN0X3NpemU9MjQ2NiwgLi4ufSwgMCkgPSAwDQo+IG9wZW5hdChBVF9GRENXRCwgIi9tbnQv
c291cmNlX2ZpbGUiLCBPX1JET05MWXxPX05PRk9MTE9XKSA9IDQNCj4gbmV3ZnN0YXRhdCg0LCAi
Iiwge3N0X21vZGU9U19JRlJFR3wwNjQ0LCBzdF9zaXplPTI0NjYsIC4uLn0sIEFUX0VNUFRZX1BB
VEgpID0gMA0KPiBvcGVuYXQoMywgImRlc3RfZmlsZSIsIE9fV1JPTkxZfE9fVFJVTkMpID0gNQ0K
PiBpb2N0bCg1LCBCVFJGU19JT0NfQ0xPTkUgb3IgRklDTE9ORSwgNCkgPSAwDQo+IGNsb3NlKDUp
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDANCj4gY2xvc2UoNCkNCj4gDQo+IHNl
cXVlbmNlIG9mIG9wZXJhdGlvbnMgZm9yIGVhY2ggZmlsZSB3aXRoaW4gdGhlIGRpcmVjdG9yeSBv
biB0aGUNCj4gY2xpZW50IHNpZGUuICBOb3RhYmx5LCB0aGUgYWN0dWFsIGZpbGUgY29weSBvY2N1
cnMgb24gdGhlIHNlcnZlciBzaWRlDQo+IGFuZCBpcyBpbnN0YW50YW5lb3VzIChCVFJGU19JT0Nf
Q0xPTkUpLg0KPiBCdXQgZm9yIFRUTHMgYXJvdW5kIDUwIG1zIChzdWNoIGFzIHdpdGhpbiBpbnRy
YS1yZWdpb25hbCBjb25uZWN0aW9ucw0KPiBsaWtlIFVTIFdlc3QvRWFzdCksIGNvcHlpbmcgYSA3
MDBNQiBkaXJlY3RvcnkgY29udGFpbmluZyA1MDAgZmlsZXMNCj4gdGFrZXMgYWJvdXQgNCBtaW51
dGVzICh3aGlsZSAidHJ1ZSIgc2VydmVyLXNpZGUgZm9sZGVyIGNvcHkgaXMgYWxtb3N0DQo+IGlu
c3RhbnQpLg0KPiANCj4gRXhwbG9yaW5nIGlmIHRoZXJlIGV4aXN0cyBhIExpbnV4IG1lY2hhbmlz
bSBlbmFibGluZyB0aGUgY29weWluZyBvZiBhbg0KPiBlbnRpcmUgZm9sZGVyIHdpdGhvdXQgaW5k
aXZpZHVhbGx5IGFjY2Vzc2luZyBlYWNoIGZpbGUgd2l0aGluIHRoZQ0KPiBkaXJlY3RvcnkgZm9y
IHNlcnZlci1zaWRlIGNvcHkgb3BlcmF0aW9uLg0KDQpUaGUgTGludXggRlMgY29tbXVuaXR5IGhh
cyBkaXNjdXNzZWQgdGhpcyBpc3N1ZSBpbiB0aGUNCnBhc3QuDQoNClRoZSB1c3VhbCBhcHByb2Fj
aCBpcyB0byB0ZWFjaCB0aGUgdXNlciBzcGFjZSB1dGlsaXRpZXMNCih0YXIsIHJzeW5jLCBhbmQg
dGhlIGxpa2UpIHRvIGtpY2sgb2ZmIGZpbGUgY29waWVzIGluDQpwYXJhbGxlbC4NCg0KDQotLQ0K
Q2h1Y2sgTGV2ZXINCg0KDQo=

