Return-Path: <linux-nfs+bounces-4565-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DFE924753
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 20:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D341C22C10
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4CD15B0FE;
	Tue,  2 Jul 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d/G5b6PL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VZRBPc5r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F8158DD1
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945221; cv=fail; b=neVO64Pns1HKgTfk2dwXr1SLXUeTMDG/ea3q0Qpty8vUPj+yqeDdkiVBNSJKIaxsxBl3Vb7ifBArAzuWjOW1kakzFOiH0XYskpuOIrIekEMeNgbl5rhjihyVaGryen984A+xN+r/cHit2c4FIqb9bqMUc96YdhtJqoAHkoGS/Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945221; c=relaxed/simple;
	bh=VBz856ya8QgRXOICoSOTz+B739kRf1ee6Y3Kywj1ySM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sOFydcgUI+Kw+W81vu5B0A34Z5/85s0JosiumvR/tjTLjt93yVBu36MvQf0ZW8DKobWeEKMVPw47V5LdaNYZfnyB51e5MOsOMJWqqFHLGGjjRJ18mhD8IbCmehLb98Xo6kzOgUYu5Lzjx6TjrgzGTR1x0MGUH3eZ6BAwxirnDwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d/G5b6PL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VZRBPc5r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462HfaHe011017;
	Tue, 2 Jul 2024 18:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=VBz856ya8QgRXOICoSOTz+B739kRf1ee6Y3Kywj1y
	SM=; b=d/G5b6PLw7PsEUttUSv6jW+fYFUA9nOZPnQOkoV0wOAJBPEVDjYgKzS8j
	xAiytqEmyC5MoxYotMavAYd1SrLBQJFZztT5PoFbfFN0lZxiiMFycp968RRX0Nys
	z9Wcx5/PL9L2AonDhnMMA4IfrWMA+PAK10gQCasLtbYIZa1MKPVtxqIpoudCATkU
	ql6VCx7HbRSXY07IvspvyS7+vgQUOVAdr3dje1InM5gbHkSddEFpHKniEpHRyVUn
	ZLxxg7fHBKTe886c6ZWxjsCRuJ3zZeEOhjXXvHFtZLYQfle3CrdX0X88Rg6l7e9A
	Z1aaiDDavocHW/hNbV+jEzvGC/qxw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296axm0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 18:33:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 462HhK95025028;
	Tue, 2 Jul 2024 18:33:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q8fyv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 18:33:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy9JWmaCRFNWxjXgA4G6RWnSmUgUAJxuNZ990I6VF+zE3K4mpUkszm5Z9uFVhTZnuVeHv6dISabwOR4H6tNZwuRj+RpyG84Z6TkM+0a9fhKq4cp65q1x/3yW4ZYAwJQtEMrFG9dv4vgRd+m4PyJe2BIVRDhb/DFTGi5SksBoCkRtzkQyDQwfkOSluqgzW9kWIsheP77w2BwETqb+n7ikYXjYqOVHqQg3Vcz8VwLU0XLrVn682d6Z/8vTHN7hRJX7frvnLT/5WqkYdhsV3MVyEAzIaWzbjVBQEN7XajSDCIZB1wBgYr6ezUN/UdTClzNqFYOhMCtcSfoIOuSKyZ5BQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBz856ya8QgRXOICoSOTz+B739kRf1ee6Y3Kywj1ySM=;
 b=M4nJS+URkCIO7VkFhR6mjytyxLa8UfqUIiCjkiXtVSCP848Snzwcv06I/TrEpwKCAjE1nZIITHqyMjY0YzvsqUgnIHF+66fk7M7zOn5G73jFDFIFB6F5xedEa6DUhrrL00hhXox68hK4F15BDcz9rnYXyk4z4iSNnnfr/QDwiIrBVoGdzIEyJ8/PXFAhKLyIG77dvtVhlzMCIVEhutZ7htY34SOPOqLmXq+2UOGt4nb6halYskpUXyrm88gjnsaicQEbReO/fYFYxvfWkykWfkolyTEblwQ36WAM/DpY6yK2CTLZ6nCGB3FJPNmlnqIuDEKWf9cLCqc2O+IWg3BrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBz856ya8QgRXOICoSOTz+B739kRf1ee6Y3Kywj1ySM=;
 b=VZRBPc5rfSR7wvw+e6ExDALRfMAKulECv+DQTGBnPJgDblgRxCUN4PFS8RzyaV0FLQKd/lIqjs2F1lgzO12iPzbvZbw5pB/VwxYxQ7Ifx2+tHgDjTp1Xh0IDHaqw9OKpxEHu922ps4AuE95GG10qnf+U4BGuIHYZIv2PGy4EJI8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5008.namprd10.prod.outlook.com (2603:10b6:5:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Tue, 2 Jul
 2024 18:33:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 18:33:25 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<dai.ngo@oracle.com>
Subject: Re: [RFC PATCH 4/6] NFS: Implement NFSv4.2's OFFLOAD_STATUS operation
Thread-Topic: [RFC PATCH 4/6] NFS: Implement NFSv4.2's OFFLOAD_STATUS
 operation
Thread-Index: AQHazJN2MeeOxjWblkaWbpLid4FApbHjwp6AgAAA0wA=
Date: Tue, 2 Jul 2024 18:33:25 +0000
Message-ID: <540FF670-430A-4599-8D19-856114C00BBA@oracle.com>
References: <20240702151947.549814-8-cel@kernel.org>
 <20240702151947.549814-12-cel@kernel.org>
 <CAN-5tyFC0O9FMKvQxXd6L9cJgzUO8-Z5-eSAguxUFfr=fVdfng@mail.gmail.com>
In-Reply-To: 
 <CAN-5tyFC0O9FMKvQxXd6L9cJgzUO8-Z5-eSAguxUFfr=fVdfng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5008:EE_
x-ms-office365-filtering-correlation-id: 06639f5f-9a47-49a2-0556-08dc9ac575b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?V09JaHgzVVlOYmJETWNCaTE4VVRMWnhlSGl1U3ZVQ25tK3c1UXRKUkpWV3lF?=
 =?utf-8?B?U0o3OVNyTm1hK3ROcHpwT0xMMTR0UjBVbHFTZ0NMbWpHV2VZME5jdjkrOGhQ?=
 =?utf-8?B?alArY0xKSENwQnk5QU43d0RHMjh4WSs2V3hRUi9XdW9oODRtdDZZZXJVdnha?=
 =?utf-8?B?bkVmRUtSYWlaMjU2cmp3ZU9aQy9DbG9pcW0yUE04OXNVVjNHaGJpK0FLT0ti?=
 =?utf-8?B?cDh6OTBZQ1Q5ODVSSlA2eVVQcHEycHgrTzU0RGtydXgxRG5YREFlTTZZT3VI?=
 =?utf-8?B?NjlMUEdnNHk2YUtkV2FtOGU4VkpwV2dCc0xVUkROMWVjMmc3YkMvTDZXaXlJ?=
 =?utf-8?B?d3Nwd1RQSDJ6cWdDRTJCaGt5L0NWZVJZdW54Q0xER0VoNldzdXkrRUFLUHRU?=
 =?utf-8?B?d3lyeFFFYnIzWEJHMHV1T1k1UkVvS3F3WFBqb0VNdzZHOE9Za1FISk82Snpr?=
 =?utf-8?B?VmxId0l2MUkvRzczNkxxZ1RZMkk0bFNUTXA0MEQ3SjRlNkVLL1JoVG5HWStp?=
 =?utf-8?B?SkF4b0ZxZWpNRklySVFQNXE0NENibmMzQ1pxdXFLSE05VFlBOXh1TC9IN0t3?=
 =?utf-8?B?UHFwVXcyUUVkeHBMSENWY1dTYm85UkVuZ2dYam1DbnJHR2J1Z3NwV1FMd2E4?=
 =?utf-8?B?NmU1TlZSbnF1djdQamcxK0lLelBtUlY5QUN1MmFRZTMwNXNsUlgzeU5xRFg5?=
 =?utf-8?B?UXBPV1gweGZhNXZmMHYyS0gxVkFlSVJzRXV6SG9oeDkyTXBqbW5YZ2RhU1Fu?=
 =?utf-8?B?aFZPK1d3OEVHcm9WOTU4T0RZZTkvSWVocE50cmc5Q21saWtodVhxQ1BObCti?=
 =?utf-8?B?M0d1MGJwdFh5YTN1djRNMzBzalVoa3Y2c2tJcGEzU0NTSEJYRFZHL29yOXNO?=
 =?utf-8?B?SkpxUGxvUGhwK3pkRy82d2w4TUkrQlBITEpkRlc0dzl0SXg5ak5lZlpqdnRT?=
 =?utf-8?B?M3RuS1hlMVYrSGVtcGQ1TWJiSnR6MXZYaGh4NFR3b0hCcnM2WkFYd1BpMDQr?=
 =?utf-8?B?MUxwWkdFLzF1alp4T0tuRkt4YVpPZHJneFdUVmxmcm1hVGpsT2Q5aXIrSWd2?=
 =?utf-8?B?RDJ1OC9ldE5TSXJrVzFhZ0krY1JsSHdQc21qKy9uMTRwSUpmRklONVo1T1NG?=
 =?utf-8?B?enNEMXRBOGQ5bkdNN3FWT3FSWWowVVE3WDdLazFMZ1JnY2xsVm5KK0hoTlZy?=
 =?utf-8?B?SVhKRE1kVzhoV2Ribk5iQzhyOUhoTm1YVDFtTUFRR1E0WThYODgrblB3WEty?=
 =?utf-8?B?NERpT05NQ1JUQ0ZxZnhmWUNic3lPb05kOXdlYUlaUXEyUDljWUhhWmhaU0ZT?=
 =?utf-8?B?R0VnWVorQUpkU2wvRUd0Q0ZNSG1JUnpXM0V6M0g3bU5nTmQ0Y043ZjNOUXha?=
 =?utf-8?B?b2JMSXovb0ltMVpRNXBtQm8vTUxWUDdIL0tnK1pMT1RDdklJbFRuS21ZUFRw?=
 =?utf-8?B?VnFoZnJTc0JPWnJHajFBa21RdnRPWk01Yk9JYURlalMzOVk0U0h6TWNjSTdv?=
 =?utf-8?B?WlBYa3ZWeUdIOXNSeFNUNkovazlsTXdReStScVNrN09ZSnJMZUVPNVUrZ2dT?=
 =?utf-8?B?SUgrcUwxNzNzNDJRQzdEMTg4dVdUWm1IN1ZvTTBndTRhZE9jb2hmaVZhZ214?=
 =?utf-8?B?cHVLYmxKNk92RHhiRld4VWZDdWcwUEhqaXFWRzR2cnBIQUNpN2FnakdrQnlU?=
 =?utf-8?B?ZUdaSFZuWGdTQWlCK0pDVTkrZmRoSVpKM2g2S3NJbHhWR3FQb3FuN1lZV0FK?=
 =?utf-8?B?c3MzWG12dUVFOEZFL1VUdFdPdmhTTkF2MEthQ08wWmhLWmgwWjE1eFBFRkRm?=
 =?utf-8?B?Q1NvczdhN1pYUGQxZElSNURlWWlKWjRYT21vQ1A2S05Vb1drU3BFdFVobnRE?=
 =?utf-8?B?RUhzL1dKUFpGOVR6NFVZUlREOUF0Q1M4UzZsRWNzM01BelE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?THdoQVBNU3FabXAydTgzVUFoSmRlMGhuWWJzTEZJOERZVUhqSksvUUpvSVFa?=
 =?utf-8?B?S1Q4eDExcWM2WG40Yko4NXVNWnpZc3VlVjk2RThwYjhjWkczUmJYdUdyL0Ra?=
 =?utf-8?B?U3FaQUcrdWNzbTQ2Z2xTZTh1RFcvcjc3WEd5SXlYMllZMlU1ZzRWTXN6RCt0?=
 =?utf-8?B?NDF6TVNwZkNCL2lkNjMwZzl4azU1ckxkQ0FlaFRsbWFqVFVrTmM0cmo3Wm51?=
 =?utf-8?B?SjBKTXI5cmNsS0J0Y2M4TjN3QWUrQjhDcDAzclZxQUdiWFpId1JUS2xLUmpN?=
 =?utf-8?B?bWMxa3VWUlVjKzJHWUZLdXI4QlNBaFlrR0MzQXNYYmI5RjJubTJRMnRSbEJG?=
 =?utf-8?B?Q0VncE1qbWI0WVlRQm80S2xPVFoyTEdvdHoxRFRQUEJYU0V1eUxkenMreGVZ?=
 =?utf-8?B?OXdEZmNaeFhSKzNyWFdrS2xRK0YzWEVuWmpBNUNnT1NLT3c5RG5waTBTKzhL?=
 =?utf-8?B?WjUvYlE4djA1eXdaZ1F3ZEkzcXMyeG5mNUNBeWpOYkZtdTFQOFNoN2lkZ29q?=
 =?utf-8?B?ck83ZHdwTE1XaDBDWVhXdis3QlJVQ2MxaFVnYmlqV1hybGc0Q0I5enA0Vyth?=
 =?utf-8?B?Y0NyaE40enRtQzVhT2lnOVBnYmZiM2ZCajlFenhudWZFbWMyTi9IbGV5MDlV?=
 =?utf-8?B?dVFneFVXRXhlTVZJTWk2bXJBOWl1eFh5YzdkbHFLTGlDWlZ2bEMrSVllYyt3?=
 =?utf-8?B?UmtUV2VBd0hDdDJxcXhyYjdZWWhQS2ZDcEt1Q0VhNyt1STJIaE0rdU5uaU1l?=
 =?utf-8?B?NmxFV3JrQ3daZDNWb2tmMlRwdUU5dVVEN2EydlVDSEw0S2YrR1Rrdm5XVitv?=
 =?utf-8?B?bjJjUk1mdHhQa3Y2YkFsdUcrNXpMODJOTzRON0QzY2FaWVppZnRpYjVkOE9P?=
 =?utf-8?B?ak01VDd4aTRnT0ZMLzRNZGw3MXVsZmNLcWZHekREM3VZUTkzdWMyN2JnZm05?=
 =?utf-8?B?cTZZZ1dIMlNnTHVXNzRGRHlBZnhKMm42aDJwWnE4S0N5M09MZFc5bGVvL1BU?=
 =?utf-8?B?SFFjV1lxdmY4bmRudHg4SVZQZzdQN0xBSFUwWnF2TXJvc0p3ZEFDVGhhODlB?=
 =?utf-8?B?NjNUTituTnlZT3I2ZDM4UkFWU2lIOVN4aXlyeGp6TjlLYkhzUndGQUtUbm5O?=
 =?utf-8?B?eklaNjJxZFM1eDVhVUJuUHRQQXlvVVh3UVp5NldNcDJsTHJiWUUxcFljd2Uw?=
 =?utf-8?B?WGJOYXJwUEp2SjNSMWhITzN5SlRrUVVha2lGdE1RUXltMkQvaXNFSjNIMS9s?=
 =?utf-8?B?a2UwbTlQazF4bDROZkNoVEF5VDdQaFdCMWpndGMwc2phS0hvSVJGRWxMc0Fs?=
 =?utf-8?B?R1llT1dqamw4MFRudkNOQ1RVZjV0d0F4aURhcHR2T3hJYUZnMzJEdVBHcG5T?=
 =?utf-8?B?bTdWak5YaS9IZzVadkdZVWlEN1dOQkYzVXJmQm5tWll0b242UTVVa1FISklC?=
 =?utf-8?B?UnFLWG5rQW56clpaVmZzU0xCTmRVQkwyR2g0dGl3MUxDTVEzZnNvOWtyVVFj?=
 =?utf-8?B?MUdkNVhCV3JHbGh6NmZRY0ZTZFh3SXpsUk01QkxyK3J5WHZVV2VzYWlzTzFl?=
 =?utf-8?B?dEZRaEl5SGFwVFgrMHl2RUtrc2pMamRtRGtNV0VadGVhNUlPdnZKRnhydzU5?=
 =?utf-8?B?SStaM3haWUtGdkJUbU1xZ3J5UXBEVUdIVnNpa09sWHAwT3lzSFJmU0Y1bHQv?=
 =?utf-8?B?SzZJckdOdFBaUktITXFBTmZkeHRDOFdOREl3L3VneGgzZWRZZTBUdGw3YzQx?=
 =?utf-8?B?U3ppMksrZ2tDTlkvMTJzdzlDZGllNUNDT1JZWjhiYkNHbUZZYUdaeDBhNWVS?=
 =?utf-8?B?Um9MamNmVTh1UWNoT1dCOHVudldhRHYzaGNSSnd1dSswb0NEVFlhcTdnQnlL?=
 =?utf-8?B?R1RoVkhOTm91eWhiaEVzQW9rVitib3U0TUFRM2xyQjVxK2M2UkhUcGMvV0hq?=
 =?utf-8?B?Uk5VdUdodnRqOW15S3h1WStKc2JUNG5TOUt2dmgwRzFuWlI2cTA5Wkhtano4?=
 =?utf-8?B?RGpwU09lbXRFc0dFdVNTTjI3dmNVbjI2ZzM4N21MYW5aNmdtcDlTallSU2RT?=
 =?utf-8?B?YkhHMWphNUdyVVNEZEJuOGhYM0luMDZ6U3lOODhTa3BEeEdEZUF3OUk1bTA1?=
 =?utf-8?B?WmtrNk8zeGtxT1VSRzdocldlWDF4VFd6NVBYVUY1SVY2MkN6aENkTGtTQTNK?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BBC622DDF83874DB413DD1DD96A186E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	64rH1zP2eGWfRXtP5bGQXtCMbizXXTgvbOZq0H5GSVggujDsB3MII1h7PhHe/c0NY3ZZdWtII5YMr+O9PLUBkCGhIuz4kM3EuLRA9zt/gDM6H9xwyeg50kElPIuHtn9lnDVENKhvjYWGM1PIkFPwFpskjzrBoJVDKQT30AQhqOfywBgzx7cjmfJY3CQErbhhQyH9ZqlVFOe2k/5pYQljtjiXIAiH8iHsVVlMT2GTC8a4yMICXDkeJU68hs+W6Lfh2lVgJDxhI5cYIEGsISiVw00fVzCp/KEE/GCtCxmQ0viNRtUMk2O6aQcvUiDoQ1Zbkw14FfjlWUEVJz2DgI5LzdLKlgVJLfYqYIjk4HEY+U5D0Vd5pBzfuySWeeWPe9A8yhygz1QgxxAKhHtMzFC1BhPRvJZ1WBaIGM+iS2jmfhP7k8dXdkdrD2vJN5tJmnAmTAMODzyKS14ND2Lkn96KyCsjHQ9CNn1RINuTeULpe0uD50+RJDaGPF3m2waTlQuQdqwS3jdxB03mL0zAK86CpaGt7It63TzVADLYnxn1WW6/XhD/qwKVYzYnC+3t6y1MTjaGZ6DV3FQ5LVB75MHlbJJbv9lsPLa6sHg6yjHGecI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06639f5f-9a47-49a2-0556-08dc9ac575b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 18:33:25.3046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhpYV6xUjXTp9BQzVWqht814SiORk/RjkRPfz6sVSNxcAp1gDgrNhHQkuSL/8UAMehYHmvf6mx9tIj1vEI4CIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_14,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407020135
X-Proofpoint-GUID: hs9mr4dfQjySDczrdu_ITbSFXe0KFUAv
X-Proofpoint-ORIG-GUID: hs9mr4dfQjySDczrdu_ITbSFXe0KFUAv

DQoNCj4gT24gSnVsIDIsIDIwMjQsIGF0IDI6MzDigK9QTSwgT2xnYSBLb3JuaWV2c2thaWEgPGFn
bG9AdW1pY2guZWR1PiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgSnVsIDIsIDIwMjQgYXQgMTE6MjHi
gK9BTSA8Y2VsQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+PiBGcm9tOiBDaHVjayBMZXZlciA8
Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+IA0KPj4gRW5hYmxlIHRoZSBMaW51eCBORlMgY2xp
ZW50IHRvIG9ic2VydmUgdGhlIHByb2dyZXNzIG9mIGFuIG9mZmxvYWRlZA0KPj4gYXN5bmNocm9u
b3VzIENPUFkgb3BlcmF0aW9uLiBUaGlzIG5ldyBvcGVyYXRpb24gd2lsbCBiZSBwdXQgdG8gdXNl
DQo+PiBpbiBhIHN1YnNlcXVlbnQgcGF0Y2guDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IENodWNr
IExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiBmcy9uZnMvbmZzNDJw
cm9jLmMgICAgICAgIHwgMTEzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+PiBpbmNsdWRlL2xpbnV4L25mc19mc19zYi5oIHwgICAxICsNCj4+IDIgZmlsZXMgY2hhbmdl
ZCwgMTE0IGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0MnBy
b2MuYyBiL2ZzL25mcy9uZnM0MnByb2MuYw0KPj4gaW5kZXggODY5NjA1YTBhOWQ1Li5jNTUyNDdk
YThlNDkgMTAwNjQ0DQo+PiAtLS0gYS9mcy9uZnMvbmZzNDJwcm9jLmMNCj4+ICsrKyBiL2ZzL25m
cy9uZnM0MnByb2MuYw0KPj4gQEAgLTIxLDYgKzIxLDggQEANCj4+IA0KPj4gI2RlZmluZSBORlNE
QkdfRkFDSUxJVFkgTkZTREJHX1BST0MNCj4+IHN0YXRpYyBpbnQgbmZzNDJfZG9fb2ZmbG9hZF9j
YW5jZWxfYXN5bmMoc3RydWN0IGZpbGUgKmRzdCwgbmZzNF9zdGF0ZWlkICpzdGQpOw0KPj4gK3N0
YXRpYyBpbnQgbmZzNDJfcHJvY19vZmZsb2FkX3N0YXR1cyhzdHJ1Y3QgZmlsZSAqZmlsZSwgbmZz
NF9zdGF0ZWlkICpzdGF0ZWlkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHU2NCAqY29waWVkKTsNCj4+IA0KPj4gc3RhdGljIHZvaWQgbmZzNDJfc2V0X25ldGFkZHIo
c3RydWN0IGZpbGUgKmZpbGVwLCBzdHJ1Y3QgbmZzNDJfbmV0YWRkciAqbmFkZHIpDQo+PiB7DQo+
PiBAQCAtNTgyLDYgKzU4NCwxMTcgQEAgc3RhdGljIGludCBuZnM0Ml9kb19vZmZsb2FkX2NhbmNl
bF9hc3luYyhzdHJ1Y3QgZmlsZSAqZHN0LA0KPj4gICAgICAgIHJldHVybiBzdGF0dXM7DQo+PiB9
DQo+PiANCj4+ICtzdGF0aWMgdm9pZCBuZnM0Ml9vZmZsb2FkX3N0YXR1c19kb25lKHN0cnVjdCBy
cGNfdGFzayAqdGFzaywgdm9pZCAqY2FsbGRhdGEpDQo+PiArew0KPj4gKyAgICAgICBzdHJ1Y3Qg
bmZzNDJfb2ZmbG9hZF9kYXRhICpkYXRhID0gY2FsbGRhdGE7DQo+PiArDQo+PiArICAgICAgIGlm
ICghbmZzNF9zZXF1ZW5jZV9kb25lKHRhc2ssICZkYXRhLT5yZXMub3NyX3NlcV9yZXMpKQ0KPj4g
KyAgICAgICAgICAgICAgIHJldHVybjsNCj4+ICsNCj4+ICsgICAgICAgc3dpdGNoICh0YXNrLT50
a19zdGF0dXMpIHsNCj4+ICsgICAgICAgY2FzZSAwOg0KPj4gKyAgICAgICAgICAgICAgIHJldHVy
bjsNCj4+ICsgICAgICAgY2FzZSAtTkZTNEVSUl9ERUxBWToNCj4+ICsgICAgICAgY2FzZSAtTkZT
NEVSUl9HUkFDRToNCj4+ICsgICAgICAgICAgICAgICBpZiAobmZzNF9hc3luY19oYW5kbGVfZXJy
b3IodGFzaywgZGF0YS0+c2VxX3NlcnZlciwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTlVMTCwgTlVMTCkgPT0gLUVBR0FJTikNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHJwY19yZXN0YXJ0X2NhbGxfcHJlcGFyZSh0YXNrKTsNCj4+ICsgICAgICAg
ICAgICAgICBlbHNlDQo+PiArICAgICAgICAgICAgICAgICAgICAgICB0YXNrLT50a19zdGF0dXMg
PSAtRUlPOw0KPj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gKyAgICAgICBjYXNlIC1ORlM0
RVJSX0FETUlOX1JFVk9LRUQ6DQo+PiArICAgICAgIGNhc2UgLU5GUzRFUlJfQkFEX1NUQVRFSUQ6
DQo+PiArICAgICAgIGNhc2UgLU5GUzRFUlJfT0xEX1NUQVRFSUQ6DQo+PiArICAgICAgICAgICAg
ICAgdGFzay0+dGtfc3RhdHVzID0gLUVCQURGOw0KPj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0K
PiANCj4gSG0uIFNob3VsZG4ndCB3ZSBiZSBhdHRlbXB0aW5nIHRvIGRvIHN0YXRlIHJlY292ZXJ5
IGhlcmU/DQoNCkhhcmQgdG8gc2F5LiBDb3B5IHN0YXRlaWRzIGFyZSBhIGxpdHRsZSBkaWZmZXJl
bnQuDQoNCklmIHRoZSBzZXJ2ZXIgZG9lc24ndCByZWNvZ25pemUgdGhlIHN0YXRlSUQgaW4gYW4N
Ck9GRkxPQURfU1RBVFVTIHJlcXVlc3QsIHRoZSBzcGVjIHNheXMgdGhhdCBjYW4gbWVhbg0KdGhh
dCB0aGUgc2VydmVyIGdvdCBhIHJlcGx5IHRvIGl0cyBDQl9PRkZMT0FEIC0tDQp0aGUgc2VydmVy
IGlzIGFsbG93ZWQgdG8gZGVsZXRlIHRoZSBDb3B5IHN0YXRlaWQNCmluIHRoYXQgY2FzZS4gSXQn
cyBub3QgYW4gZXJyb3IgdGhhdCByZXF1aXJlcw0Kc3RhdGUgcmVjb3ZlcnkuDQoNCkJ1dCBJJ20g
bm90IHNheWluZyB0aGlzIGNvZGUgaXMgY29ycmVjdC4NCg0KDQo+PiArICAgICAgIGNhc2UgLU5G
UzRFUlJfTk9UU1VQUDoNCj4+ICsgICAgICAgY2FzZSAtRU5PVFNVUFA6DQo+PiArICAgICAgIGNh
c2UgLUVPUE5PVFNVUFA6DQo+PiArICAgICAgICAgICAgICAgZGF0YS0+c2VxX3NlcnZlci0+Y2Fw
cyAmPSB+TkZTX0NBUF9PRkZMT0FEX1NUQVRVUzsNCj4+ICsgICAgICAgICAgICAgICB0YXNrLT50
a19zdGF0dXMgPSAtRU9QTk9UU1VQUDsNCj4+ICsgICAgICAgICAgICAgICBicmVhazsNCj4+ICsg
ICAgICAgZGVmYXVsdDoNCj4+ICsgICAgICAgICAgICAgICB0YXNrLT50a19zdGF0dXMgPSAtRUlP
Ow0KPj4gKyAgICAgICB9DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcnBj
X2NhbGxfb3BzIG5mczQyX29mZmxvYWRfc3RhdHVzX29wcyA9IHsNCj4+ICsgICAgICAgLnJwY19j
YWxsX3ByZXBhcmUgPSBuZnM0Ml9vZmZsb2FkX3ByZXBhcmUsDQo+PiArICAgICAgIC5ycGNfY2Fs
bF9kb25lID0gbmZzNDJfb2ZmbG9hZF9zdGF0dXNfZG9uZSwNCj4+ICsgICAgICAgLnJwY19yZWxl
YXNlID0gbmZzNDJfb2ZmbG9hZF9yZWxlYXNlDQo+PiArfTsNCj4+ICsNCj4+ICsvKg0KPj4gKyAq
IFJldHVybiB2YWx1ZXM6DQo+PiArICogICAlMDogU2VydmVyIHJldHVybmVkIGFuIE5GUzRfT0sg
Y29tcGxldGlvbiBzdGF0dXMNCj4+ICsgKiAgICUtRUlOUFJPR1JFU1M6IFNlcnZlciByZXR1cm5l
ZCBubyBjb21wbGV0aW9uIHN0YXR1cw0KPj4gKyAqICAgJS1FUkVNT1RFSU86IFNlcnZlciByZXR1
cm5lZCBhbiBlcnJvciBjb21wbGV0aW9uIHN0YXR1cw0KPj4gKyAqICAgJS1FQkFERjogU2VydmVy
IGRpZCBub3QgcmVjb2duaXplIHRoZSBjb3B5IHN0YXRlaWQNCj4+ICsgKiAgICUtRU9QTk9UU1VQ
UDogU2VydmVyIGRvZXMgbm90IHN1cHBvcnQgT0ZGTE9BRF9TVEFUVVMNCj4+ICsgKg0KPj4gKyAq
IE90aGVyIG5lZ2F0aXZlIGVycm5vcyBpbmRpY2F0ZSB0aGUgY2xpZW50IGNvdWxkIG5vdCBjb21w
bGV0ZSB0aGUNCj4+ICsgKiByZXF1ZXN0Lg0KPj4gKyAqLw0KPj4gK3N0YXRpYyBpbnQgbmZzNDJf
cHJvY19vZmZsb2FkX3N0YXR1cyhzdHJ1Y3QgZmlsZSAqZmlsZSwgbmZzNF9zdGF0ZWlkICpzdGF0
ZWlkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU2NCAqY29waWVk
KQ0KPj4gK3sNCj4+ICsgICAgICAgc3RydWN0IG5mc19vcGVuX2NvbnRleHQgKmN0eCA9IG5mc19m
aWxlX29wZW5fY29udGV4dChmaWxlKTsNCj4+ICsgICAgICAgc3RydWN0IG5mc19zZXJ2ZXIgKnNl
cnZlciA9IE5GU19TRVJWRVIoZmlsZV9pbm9kZShmaWxlKSk7DQo+PiArICAgICAgIHN0cnVjdCBu
ZnM0Ml9vZmZsb2FkX2RhdGEgKmRhdGEgPSBOVUxMOw0KPj4gKyAgICAgICBzdHJ1Y3QgcnBjX21l
c3NhZ2UgbXNnID0gew0KPj4gKyAgICAgICAgICAgICAgIC5ycGNfcHJvYyAgICAgICA9ICZuZnM0
X3Byb2NlZHVyZXNbTkZTUFJPQzRfQ0xOVF9PRkZMT0FEX1NUQVRVU10sDQo+PiArICAgICAgICAg
ICAgICAgLnJwY19jcmVkICAgICAgID0gY3R4LT5jcmVkLA0KPj4gKyAgICAgICB9Ow0KPj4gKyAg
ICAgICBzdHJ1Y3QgcnBjX3Rhc2tfc2V0dXAgdGFza19zZXR1cF9kYXRhID0gew0KPj4gKyAgICAg
ICAgICAgICAgIC5ycGNfY2xpZW50ICAgICA9IHNlcnZlci0+Y2xpZW50LA0KPj4gKyAgICAgICAg
ICAgICAgIC5ycGNfbWVzc2FnZSAgICA9ICZtc2csDQo+PiArICAgICAgICAgICAgICAgLmNhbGxi
YWNrX29wcyAgID0gJm5mczQyX29mZmxvYWRfc3RhdHVzX29wcywNCj4+ICsgICAgICAgICAgICAg
ICAud29ya3F1ZXVlICAgICAgPSBuZnNpb2Rfd29ya3F1ZXVlLA0KPj4gKyAgICAgICAgICAgICAg
IC5mbGFncyAgICAgICAgICA9IFJQQ19UQVNLX0FTWU5DIHwgUlBDX1RBU0tfU09GVENPTk4sDQo+
PiArICAgICAgIH07DQo+PiArICAgICAgIHN0cnVjdCBycGNfdGFzayAqdGFzazsNCj4+ICsgICAg
ICAgaW50IHN0YXR1czsNCj4+ICsNCj4+ICsgICAgICAgaWYgKCEoc2VydmVyLT5jYXBzICYgTkZT
X0NBUF9PRkZMT0FEX1NUQVRVUykpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RT
VVBQOw0KPj4gKw0KPj4gKyAgICAgICBkYXRhID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IG5mczQy
X29mZmxvYWRfZGF0YSksIEdGUF9LRVJORUwpOw0KPj4gKyAgICAgICBpZiAoZGF0YSA9PSBOVUxM
KQ0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPj4gKw0KPj4gKyAgICAgICBk
YXRhLT5zZXFfc2VydmVyID0gc2VydmVyOw0KPj4gKyAgICAgICBkYXRhLT5hcmdzLm9zYV9zcmNf
ZmggPSBORlNfRkgoZmlsZV9pbm9kZShmaWxlKSk7DQo+PiArICAgICAgIG1lbWNweSgmZGF0YS0+
YXJncy5vc2Ffc3RhdGVpZCwgc3RhdGVpZCwNCj4+ICsgICAgICAgICAgICAgICBzaXplb2YoZGF0
YS0+YXJncy5vc2Ffc3RhdGVpZCkpOw0KPj4gKyAgICAgICBtc2cucnBjX2FyZ3AgPSAmZGF0YS0+
YXJnczsNCj4+ICsgICAgICAgbXNnLnJwY19yZXNwID0gJmRhdGEtPnJlczsNCj4+ICsgICAgICAg
dGFza19zZXR1cF9kYXRhLmNhbGxiYWNrX2RhdGEgPSBkYXRhOw0KPj4gKyAgICAgICBuZnM0X2lu
aXRfc2VxdWVuY2UoJmRhdGEtPmFyZ3Mub3NhX3NlcV9hcmdzLCAmZGF0YS0+cmVzLm9zcl9zZXFf
cmVzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgMSwgMCk7DQo+PiArICAgICAgIHRh
c2sgPSBycGNfcnVuX3Rhc2soJnRhc2tfc2V0dXBfZGF0YSk7DQo+PiArICAgICAgIGlmIChJU19F
UlIodGFzaykpIHsNCj4+ICsgICAgICAgICAgICAgICBuZnM0Ml9vZmZsb2FkX3JlbGVhc2UoZGF0
YSk7DQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIodGFzayk7DQo+PiArICAgICAg
IH0NCj4+ICsgICAgICAgc3RhdHVzID0gcnBjX3dhaXRfZm9yX2NvbXBsZXRpb25fdGFzayh0YXNr
KTsNCj4+ICsgICAgICAgaWYgKHN0YXR1cykNCj4+ICsgICAgICAgICAgICAgICBnb3RvIG91dDsN
Cj4+ICsNCj4+ICsgICAgICAgKmNvcGllZCA9IGRhdGEtPnJlcy5vc3JfY291bnQ7DQo+PiArICAg
ICAgIGlmICghZGF0YS0+cmVzLmNvbXBsZXRlX2NvdW50KSB7DQo+PiArICAgICAgICAgICAgICAg
c3RhdHVzID0gLUVJTlBST0dSRVNTOw0KPj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4g
KyAgICAgICB9DQo+PiArICAgICAgIGlmIChkYXRhLT5yZXMub3NyX2NvbXBsZXRlWzBdICE9IE5G
U19PSykgew0KPj4gKyAgICAgICAgICAgICAgIHN0YXR1cyA9IC1FUkVNT1RFSU87DQo+PiArICAg
ICAgICAgICAgICAgZ290byBvdXQ7DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICtvdXQ6DQo+PiAr
ICAgICAgIHJwY19wdXRfdGFzayh0YXNrKTsNCj4+ICsgICAgICAgcmV0dXJuIHN0YXR1czsNCj4+
ICt9DQo+PiArDQo+PiBzdGF0aWMgaW50IF9uZnM0Ml9wcm9jX2NvcHlfbm90aWZ5KHN0cnVjdCBm
aWxlICpzcmMsIHN0cnVjdCBmaWxlICpkc3QsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IG5mczQyX2NvcHlfbm90aWZ5X2FyZ3MgKmFyZ3MsDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG5mczQyX2NvcHlfbm90aWZ5X3JlcyAq
cmVzKQ0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbmZzX2ZzX3NiLmggYi9pbmNsdWRl
L2xpbnV4L25mc19mc19zYi5oDQo+PiBpbmRleCA5MmRlMDc0ZTYzYjkuLjA5MzdlNzNjNDc2NyAx
MDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGludXgvbmZzX2ZzX3NiLmgNCj4+ICsrKyBiL2luY2x1
ZGUvbGludXgvbmZzX2ZzX3NiLmgNCj4+IEBAIC0yNzgsNiArMjc4LDcgQEAgc3RydWN0IG5mc19z
ZXJ2ZXIgew0KPj4gI2RlZmluZSBORlNfQ0FQX0xHT1BFTiAgICAgICAgICgxVSA8PCA1KQ0KPj4g
I2RlZmluZSBORlNfQ0FQX0NBU0VfSU5TRU5TSVRJVkUgICAgICAgKDFVIDw8IDYpDQo+PiAjZGVm
aW5lIE5GU19DQVBfQ0FTRV9QUkVTRVJWSU5HICAgICAgICAoMVUgPDwgNykNCj4+ICsjZGVmaW5l
IE5GU19DQVBfT0ZGTE9BRF9TVEFUVVMgKDFVIDw8IDgpDQo+PiAjZGVmaW5lIE5GU19DQVBfUE9T
SVhfTE9DSyAgICAgKDFVIDw8IDE0KQ0KPj4gI2RlZmluZSBORlNfQ0FQX1VJREdJRF9OT01BUCAg
ICgxVSA8PCAxNSkNCj4+ICNkZWZpbmUgTkZTX0NBUF9TVEFURUlEX05GU1Y0MSAoMVUgPDwgMTYp
DQo+PiAtLQ0KPj4gMi40NS4yDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

