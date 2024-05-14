Return-Path: <linux-nfs+bounces-3252-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D397B8C5CA2
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2024 23:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D95C282C0D
	for <lists+linux-nfs@lfdr.de>; Tue, 14 May 2024 21:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F78180A6C;
	Tue, 14 May 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ovyF/4cK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nC7jQ+Ip"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B11DFD1
	for <linux-nfs@vger.kernel.org>; Tue, 14 May 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715720948; cv=fail; b=YVoGHAYf3iKQB6HJ92ME5jU21fy3PO6+0rTi1pF+JmX4Rdl7hTJx7OvMtwvrShKUfecYc04+9xH6rmsktExL8Kj7y43nGKZGO9UH/1t6rz8zCe2RdoFL0hAqrB/8Arg7Iw/biKrc14yHHOvRqg/p2UPpzKT93I2lI/dKjh8UGsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715720948; c=relaxed/simple;
	bh=mGLYWPacC6lIW4yeHEd/wJgycaEOgLBL0857AZb81N0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W54hCO2QzPAySFVzQrU8Z2HvKjmL03VP0KMHR9KG12yyNBPwMHnWlNQ5S84y1X+ZK6ZbswL5sb2TuS9DQo2z4pJar68TK56rlLypp496x7v+cA8nNczgMGMWbfASnysAv73loCfNgVxGVu00znlpXchU7z0Y0sgIjSUyjNOoJe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ovyF/4cK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nC7jQ+Ip; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EKXqNP013582;
	Tue, 14 May 2024 21:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mGLYWPacC6lIW4yeHEd/wJgycaEOgLBL0857AZb81N0=;
 b=ovyF/4cKBy4SmjoRJOxr6fOn9H3mW7ikNXDaKEEhhZeVHm9KCybYXyERNPm/lmiCTlmf
 m4Nx3Ak1hOFtPSiN2b4dptyHYptGXkflZl4Ae3nJW/9591Cs1ab0iv48nZ3Uo3jHxnkV
 9UiUL3wPNGc2RF1THbCXRV0AJxxCPkx7QoERCoipgDBRcAc75X99Y0RD4iSSDJmDLe6i
 jqLCz4SgL4Nlis1cVut/CgNGYfh8pqhGFrm9BYgrPliTFmrt9eGhUWzNSgwfYfcQUicR
 Xn0tSw7c46GB8ZW1JtyvlUNFvofJIYBqCV2mQQ5+9IBkPNSQRUTpu++lc/knQMowYe/D mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4faw2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 21:08:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44EJaUrY018860;
	Tue, 14 May 2024 21:08:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4838ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 21:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCk/mT7CFeJ6FeUz5dNLLQxE044Mb4AP9KpGEx4Ls7cbTLu7JTKZfKvggTLp7zuc7GGLG/qQTlXrLs+2IayHyibPTOkw2c5R9+7maGI7BOU1wMPUwAnhtfHuouKvPccf7JnI7lJHQSjl+OWrHZwlYYAdGOfcQsnP4UHZt6cO0Zw2QmoGmHjKwYIqAoOdEyYetcassq5KI8c95QuX1HHaR0/NOuo/7JfDJhcT/q0Ch3yomxfhSICXJwvXnPEj9dZPQWnBLLnOhGRUWZZKnnWqFalsnbHanBo3sXXxQoBp07SLvr/oyJWoDD6n7igl3WEn3WzQ33/1i2BfKlZ2eZaQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGLYWPacC6lIW4yeHEd/wJgycaEOgLBL0857AZb81N0=;
 b=ePGi/XlOnVQoYmXc5zkeQMfBS+MQHCFXzqPh6lytX6oDrGovQf9R7RHpX8q0PiKgtyq+b1IN8Oaee0z4Q/idR4NkOUrOS9/QKYgPdMrhHx/MQmcfv7FO2wBAbNX6c2rMAtiEGK8uu3fxbGnOqsXXXWDcis2Fl4hrEY5C6wDmVshgjhW2OxK6idt3mv1mgNOGmba+Bc07nT38MVY6WRynFP10nhiw7m2S2JENGY2N02uBndOuHv/zmLehJ+RfR3DIbfK/ra+2JfFfA3p7JZG9O2vFPXnKhRJYg1aqu2NIC1JmY/WLL3WQ1HrIsN6WWnFHyKAVR7w7oXRh7lKiMBKByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGLYWPacC6lIW4yeHEd/wJgycaEOgLBL0857AZb81N0=;
 b=nC7jQ+IpIFbsaljPTL0EU2q0X1Ze0jjjXlhEUrwAVRR1kQGLWzaam7Ba6WWPH2XZFk4VfT6sjC1tknTFxZAagQ9/AWhMXmSBHiQbLDZC5mPrsOC6HJzRFFuZZ/38gtQEHYDpVPp2qJyBGm3BOuFQc7oQHxBoC8TT44NOwtEMwP8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5957.namprd10.prod.outlook.com (2603:10b6:208:3cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 21:08:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 21:08:54 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: sm notify (nlm) question
Thread-Topic: sm notify (nlm) question
Thread-Index: AQHapkFRewhmuj9ZWkehT+PHJfGUH7GXOUqA
Date: Tue, 14 May 2024 21:08:54 +0000
Message-ID: <2C80B5BC-AAEC-41F8-BEB6-C920F88C89BB@oracle.com>
References: 
 <CAN-5tyFBn3C_CTrsftuYeWJHe7KWxd82YFCyrN9t=az8J4RU0w@mail.gmail.com>
In-Reply-To: 
 <CAN-5tyFBn3C_CTrsftuYeWJHe7KWxd82YFCyrN9t=az8J4RU0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN0PR10MB5957:EE_
x-ms-office365-filtering-correlation-id: e5b1b770-69ca-406d-d9ce-08dc745a0fe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eUZmSmJRT1A5R05Icy8zRkptcCtBVHRtRFNsUTl1Z0JlQnkzb3E5dWREOVND?=
 =?utf-8?B?dHNtb3FoQjkzYTYzR1RWV3VEaHExZ0QzdXA1VHgwaWZiZmNhM0crQk1UQnpm?=
 =?utf-8?B?SlM2MnJacGJleVh5Q0p5NjliVDhrL0I0Z0grRzl0L1RVZFdaRGN3dm1tZmkz?=
 =?utf-8?B?T3p4OVd0aWwwZllGdWVHTFFCcXFmU1hFQm9xYUt2citRb25rVTArWHc2RXNF?=
 =?utf-8?B?bE92UStHc2FNZElMZXlDLzlhL1YwUW91K2VMQjE1KzkvSmQvL2xBZ25MZmly?=
 =?utf-8?B?MmtCdzNvMy9yQ21UMG9ZS1NhQW5uNE5DTlpLcktRck5mZG1xd1g3Qy9kYkk0?=
 =?utf-8?B?VmFxK3JBZERqRmNCeEFQaGRmYmkvZU9Bdk1EWnhmNUJmYWYvVDJFbjhYUC9k?=
 =?utf-8?B?SE1HeGpHNlk1MTh6MGcrVldBelRwSzdPeDNNa0JxUGR0SEZ6N3RXYi9WTjA1?=
 =?utf-8?B?cFpFQzlBKzVYblJhdDV1ZjFCb2ttSzlsQTdqRGszM2JNZHd0Z25tWStDc1RS?=
 =?utf-8?B?U21uTTM2WFFsUVloZzN6U2lOT25OYmVyaHo2ZUxmK2hOUlNoUGhKMzFocWJU?=
 =?utf-8?B?bFJBVWQxRkdDMU9QTmZQV0EwWVVnMFBzdEJIWFlOSU02eWVPNjhRR3RZWG1C?=
 =?utf-8?B?UVZjSkMyYnIvZWNwSnRqUUtMeExYRWxHRkdrVmRvelZwN3lSeCs5VGxHZFFW?=
 =?utf-8?B?S043ZlMxN0RZbUxXdFN2TnhCcmFvN2NiYmZyRnZIYm01WldYemJpcmF0WTNS?=
 =?utf-8?B?RzUwUm5vZE1aN3grTmxUTDVhd0F2MTR6OS94TnlWNWZCRXpqaitDaWhaeHNt?=
 =?utf-8?B?WHVBckswUjhoR28rOXpiQTh0cVpEcUFKY2pJV09QemhMNTQyMHk3dzI5a0Iy?=
 =?utf-8?B?b2JxejQ0K09kTUU0dVB3NXR2eCtYOHBsdng4b1Bab0dzY21HMGxJTlJKN0J6?=
 =?utf-8?B?RWVHaTlYSlMyNndteWJ0K3ExYVR5SzNmejJYZ1l5MVNyK1JpL2JpTXBHaWFD?=
 =?utf-8?B?KzVwZGE3amFQN040aFlsd0NpQWVXeGJXN1RYRk1YMHFyM3dKQ0VOZk5yTzBE?=
 =?utf-8?B?NVh0dEMzT0RmYzFvc3RkNVU0b0xhMUtEZnlNVHVNbmtFak9pKzYzWXRHSmg5?=
 =?utf-8?B?a2Z1K2s2aEZaUVBzak05ODU1MFhGTzBBaFcxd0VMSExoYW9qSlRJVGpoMDJs?=
 =?utf-8?B?UjBvNTdmZUhYbnRXa0NvTk1BL3o0SzJ3VTc4NFJGeVlTZmQvRzhLS3NZYklz?=
 =?utf-8?B?cGVKRWRLMFlWUkFnWWFNeVljaWFqTzdFRzljMytxdGNzOU9ORFpmdHNCSmFB?=
 =?utf-8?B?NGhwQ256eElPSTUyRDIycnBaSlZrOGJvRUthd1FBSVdkZVlZUkc2bUVYMUpY?=
 =?utf-8?B?cERFcUpJOHZNS3F3SHcyaXNocVZadERaTlZickhSN3JETzRlZms0VUZMWTkr?=
 =?utf-8?B?ZDNVNEE0K0loNWVqcE5GZ2hpU0xaRkx4aU1YL2Q4ZlZETHFQb0xKamZHMEFY?=
 =?utf-8?B?Ukw2KzdHVzdwQnVrWVFjQXVaOExHVUMwZysyV0NlVGh2c1hRUzRDc2VnNTl0?=
 =?utf-8?B?NE11TktwdWdFZlhFbzJQZmtaWVRDSVpNdXY3WmtMZlovZXlWeWVCYjhaQ3dC?=
 =?utf-8?B?bnduN29zcTRLSzBheUJKK1c2NDVpZ3RsdjBqNU9CUlVQMDZ6WnM4Zk9MKzEx?=
 =?utf-8?B?c0JmRjR6QmFneW9iMytlTXR0eWRIbHpWYTBYbnhJZXBQd01hamxjTGZRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WHg4WldTTE5VZnI1bWxOM3RRREF6OUMyRjhBQ0xyTy84NHpEVmowUFhBRUxF?=
 =?utf-8?B?bW1zOHFUbmFTeVB3UUJOMnRqa0tyMWg1czl2L21SQWs2ZE1oN0E4VWRqVVB5?=
 =?utf-8?B?eVNTQ01sZThnRDRKZjdXL016TGltVVlQZHUrZkJabW8wQjhFeDhFZ0VTK2Rv?=
 =?utf-8?B?U0lRYkxNbkNMZm9tM0dtVFhXd3YrbmVISG02eUg3WWdjN3AxZGc0dU9jTS8v?=
 =?utf-8?B?dHJPMVd0eENQNm4zMU9kdU02dm9iblI4Nm9kL1YxWVEybW9tT0luQklsd2k4?=
 =?utf-8?B?N0Fya0c3V1Zxbk1nOEFwL1ZjR0dyVktvR1p1YzE3MXlLRmw5MU5MdmlydTRU?=
 =?utf-8?B?Q254R0p0ZkpnUXNZckpINDhnWDdGUzV2TzVvblBTa2pLSlRtYnBIb0h2N1gv?=
 =?utf-8?B?NDFwZUxTZy9wakV4QnhTUUNhNFp2Mk5jMitldzZZTEZTSlNqUWlXYlQrMjJM?=
 =?utf-8?B?Z3YyTWJ1Qk5DZ2pQWmZYdlpEYkp5cjEyWGF0SWo5OW0wM1NEN0QvOTJCbTZE?=
 =?utf-8?B?aWY0aFNnTDNKTmcxQjFyRzBsT1E3Vkd5VFN6RWFvZ1dyNnBsOUxuOWpMNU03?=
 =?utf-8?B?U3ViNnowNFpXVllEK2J0Nlg5ZkFJQUptcEpRUkxVUEg1QmNqaUY4RmVRd2ZF?=
 =?utf-8?B?eGZlSVpDZWw2NmZ3bWh3cDFWZHEzZ1luN2NDdUlRcDl0T3p1Rk1XTHVETUF2?=
 =?utf-8?B?bFpCME5DaFBOT1YrOWhFYzduRkVXdlE3YUwxdTg2eTUzZnJmcExvVGxoRGRB?=
 =?utf-8?B?dVBwVHNxaytJSFRaa2pXS3A5cS9GWjJRY0JnamIwc0dSeWtqcGJvV0tFSDdp?=
 =?utf-8?B?c3JyWDZSV3BZbDdsb2lqamFBS2Q0eGtOUmpPYU9CczFPMEFtbDhJeEJoRmp0?=
 =?utf-8?B?VDlCL1JBQ3Y1dVJDdGRvbStYUmRuR1k3dndoK1pHMThVV2tha3RIZ3pOZEdw?=
 =?utf-8?B?b2lnaHltUFFHYktRN0VNRjAxMW1Lb0h5OFF6cDJpQTZ2cURtNzhpUGJqTzJZ?=
 =?utf-8?B?Nm5NTnBXQ3o4NnpLM2k5b2Z5OUxJaWxFMlArOEhXUzFXc1JzVU1wSElzazNj?=
 =?utf-8?B?aW1ZSXFIb3BpZk9SZ1FlaFE2ZVZoenZwY3hjU2hRNEZNZnRzS1Q2TW5EUTlM?=
 =?utf-8?B?V0hERVNPZU1vZVUrM0NNZGNKMHJRSXRaOEpHZjhmTHgvOXphS2MvUXRZUGhW?=
 =?utf-8?B?UUFrYmJ5OWFzZVl3UUhXdzByZkJURlhxY2xmcHRpYi8rT3Z5OHN6cWRPVlJk?=
 =?utf-8?B?MFUxeUZDMlBLb2EvcUhzU2k4Z0lESjJiMHFVeUxCSjRtTG5WL2FEOUl2K0JY?=
 =?utf-8?B?b1kxR2NuRW5RTWM3S3RiL3ptcG04RksvRzNUWHp4M0tPQldURW5NYVpZejhF?=
 =?utf-8?B?WG1DSStFcTA1RUtWZFdLNHFOVTVlcFlRTkhWMUdwdnBTRHBKcm1PV0ZNbUhG?=
 =?utf-8?B?WG9JUHJhcXU4U2xGejNhMlhzRmFoQ2pVb3JrTkJvR005ZENQcHNmdU1VTmhM?=
 =?utf-8?B?WHhZZnJBZ2RhQmFpNUxwWDVLY0dIVGRGSkh5by9EYzd2M1FUL3dSM3ZaU0Uz?=
 =?utf-8?B?TzY5dlJ5NnZWaVJ5b3lTSitlSlZZTVdEYndibjA5bDhBZjVBMEVtWENndmZv?=
 =?utf-8?B?UmlRcURaY05HVUo0ZElsVUVxdklPQkZ1VG1obURjd29aaHlwU2xBdVFTVi9v?=
 =?utf-8?B?c0hteTlTajFza0JNRGJXdmhhVnZvcVkvbnIwbTZGMTlLem1ML0tCZ3ZrRXF1?=
 =?utf-8?B?VEVIc09qZkQxVWMrZDFyNk1VTUY4Ylk3MWI0ejROa2h4WW41bjMvclJyNTRL?=
 =?utf-8?B?SlZVYm9uQmpFNW1lb1FWU0l3cXJzZGhVbWYyM3VEN2Nzc3FsWVZBVFdRMmtL?=
 =?utf-8?B?Sjk0V1lpQ3dqY1orS0hKeWRoakwwSWxyVVQrOGhZUk1UMGVocnV5WU9lYnNU?=
 =?utf-8?B?c0pEQ05HMDRQQkFQTFFPdjYvT29JNVJTUUovNWQ2YXBTTWNMT2U3Wk5vVmVY?=
 =?utf-8?B?OXNlQkNCdzA1OGZhb1BpcWFsclNEaHFrU2wvcnV0NUN4M1p1ZFBMK1ZJQ3Rz?=
 =?utf-8?B?c2tKY3ZiNnExYVRRTW1GaVBmRGh1enlVZUZ5azR6bitpclhScmVZcVEycHpY?=
 =?utf-8?B?dXMrdnRFcmpSWXcwS3hrbmxMRXdWaGJ1WHBUU0l4SWk3SExxME9mWWQ0NWJN?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A4C8F541BA3CF4BA0DD52F4B3E32AA4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vCID77Mrj3K1tdA0cO/EzFOHvJzI3PuRFP6vqZd+fuy3OJKajAn7TYmS7CTlvxEFLu17b/e3waYpNfuxDttytNEe7idaCGSCF/qvD7CtfDrJ8WcgXwfsjtBq+tRk+UKGr01wC2eeDUK/MhSfTbhZFTkzPcIkBtuXJDcac/tS6SXpF8xlui8ek1ggtLoRVSwQuEvH0XKOI4MNaoHXVmkrHPMBI2r4Uq6ncMLInhct8xjtPkDhzWNuJlFxkNUSGoW2wTBPMjOGIbm/wY/ampq8ecfRK3HCeT08sXqE9ToV9P77gdPKYx1eFkKHG4DNduRfTFb8T6iWgbM38KwKO4NDkXBw6mwDjKUJqRID8gvC+jau1YMSvV//qbgHq95LasrfzolhjdW5DNXgT7zDBR+sTHku4ybYfG9owKe2WtYzBCiprG6c2P8+TyCZLdLQDNoApjig3bL0DbmX3rlgBOBGd40oTkr1cbLuGY3dBlwdGX3dGhD2OOFecAtBI00hHFb9QnsHGES1ZlD/2xw7clMWd2lrJVQpN44prNDiRIoDiIsavFWq7vzLhz4IjQfWIaSQGOY7y4JQbHiXOVk4vAZzs1vLoJ3CXbSh0txCiUgJnaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b1b770-69ca-406d-d9ce-08dc745a0fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 21:08:54.2166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuQtg823Ep/K/66/zVEjwwGknA5G/jfolQ1NuPb9yOcE7JT73uwguQLGXuXaelvJLAmKaXRPVfrCjSmidSujVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_12,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405140152
X-Proofpoint-ORIG-GUID: M7k0Hvvz8UEARtUZpMZMKuJPi9EfpFPJ
X-Proofpoint-GUID: M7k0Hvvz8UEARtUZpMZMKuJPi9EfpFPJ

DQoNCj4gT24gTWF5IDE0LCAyMDI0LCBhdCAyOjU24oCvUE0sIE9sZ2EgS29ybmlldnNrYWlhIDxh
Z2xvQHVtaWNoLmVkdT4gd3JvdGU6DQo+IA0KPiBIaSBmb2xrcywNCj4gDQo+IEdpdmVuIHRoYXQg
bm90IGV2ZXJ5dGhpbmcgZm9yIE5GU3YzIGhhcyBhIHNwZWNpZmljYXRpb24sIEkgcG9zdCBhDQo+
IHF1ZXN0aW9uIGhlcmUgKGFzIGl0IGNvbmNlcm5zIGxpbnV4IHYzIChjbGllbnQpIGltcGxlbWVu
dGF0aW9uKSBidXQgSQ0KPiBhc2sgYSBnZW5lcmljIHF1ZXN0aW9uIHdpdGggcmVzcGVjdCB0byBO
T1RJRlkgc2VudCBieSBhbiBORlMgc2VydmVyLg0KDQpUaGVyZSBpcyBhIHN0YW5kYXJkOg0KDQpo
dHRwczovL3B1YnMub3Blbmdyb3VwLm9yZy9vbmxpbmVwdWJzLzk2Mjk3OTkvY2hhcDExLmh0bQ0K
DQoNCj4gQSBOT1RJRlkgbWVzc2FnZSB0aGF0IGlzIHNlbnQgYnkgYW4gTkZTIHNlcnZlciB1cG9u
IHJlYm9vdCBoYXMgYSBtb25pdG9yDQo+IG5hbWUgYW5kIGEgc3RhdGUuIFRoaXMgInN0YXRlIiBp
cyBhbiBpbnRlZ2VyIGFuZCBpcyBtb2RpZmllZCBvbiBlYWNoDQo+IHNlcnZlciByZWJvb3QuIE15
IHF1ZXN0aW9uIGlzOiB3aGF0IGFib3V0IHN0YXRlIHZhbHVlIHVuaXF1ZW5lc3M/IElzDQo+IHRo
ZXJlIHNvbWV3aGVyZSBzb21lIG5vdGlvbiB0aGF0IHRoaXMgdmFsdWUgaGFzIHRvIGJlIHVuaXF1
ZSAoYXMgaW4NCj4gc2F5IGEgcmFuZG9tIHZhbHVlKS4NCj4gDQo+IEhlcmUncyBhIHByb2JsZW0u
IFNheSBhIGNsaWVudCBoYXMgMiBtb3VudHMgdG8gaXAxIGFuZCBpcDIgKGJvdGgNCj4gcmVwcmVz
ZW50aW5nIHRoZSBzYW1lIEROUyBuYW1lKSBhbmQgYWNxdWlyZXMgYSBsb2NrIHBlciBtb3VudC4g
Tm93IHNheQ0KPiBlYWNoIG9mIHRob3NlIHNlcnZlcnMgcmVib290LiBPbmNlIHVwIHRoZXkgZWFj
aCBzZW5kIGEgTk9USUZZIGNhbGwgYW5kDQo+IGVhY2ggdXNlIGEgdGltZXN0YW1wIGFzIGJhc2lz
IGZvciB0aGVpciAic3RhdGUiIHZhbHVlIC0tIHdoaWNoIHZlcnkNCj4gbGlrZWx5IGlzIHRvIHBy
b2R1Y2UgdGhlIHNhbWUgdmFsdWUgZm9yIDIgc2VydmVycyByZWJvb3RlZCBhdCB0aGUgc2FtZQ0K
PiB0aW1lIChvciBmb3IgdGhlIGxpbnV4IHNlcnZlciB0aGF0IGxvb2tzIGxpa2UgYSBjb3VudGVy
KS4gT24gdGhlDQo+IGNsaWVudCBzaWRlLCBvbmNlIHRoZSBjbGllbnQgcHJvY2Vzc2VzIHRoZSAx
c3QgTk9USUZZIGNhbGwsIGl0IHVwZGF0ZXMNCj4gdGhlICJzdGF0ZSIgZm9yIHRoZSBtb25pdG9y
IG5hbWUgKGllIGEgY2xpZW50IG1vbml0b3JzIGJhc2VkIG9uIGEgRE5TDQo+IG5hbWUgd2hpY2gg
aXMgdGhlIHNhbWUgZm9yIGlwMSBhbmQgaXAyKSBhbmQgdGhlbiBpbiB0aGUgY3VycmVudCBjb2Rl
LA0KPiBiZWNhdXNlIHRoZSAybmQgTk9USUZZIGhhcyB0aGUgc2FtZSAic3RhdGUiIHZhbHVlIHRo
aXMgTk9USUZZIGNhbGwNCj4gd291bGQgYmUgaWdub3JlZC4gVGhlIGxpbnV4IGNsaWVudCB3b3Vs
ZCBuZXZlciByZWNsYWltIHRoZSAybmQgbG9jaw0KPiAoYnV0IHRoZSBhcHBsaWNhdGlvbiBvYnZp
b3VzbHkgd291bGQgbmV2ZXIga25vdyBpdCdzIG1pc3NpbmcgYSBsb2NrKQ0KPiAtLS0gZGF0YSBj
b3JydXB0aW9uLg0KPiANCj4gV2hvIGlzIHRvIGJsYW1lOiBpcyB0aGUgc2VydmVyIG5vdCBhbGxv
d2VkIHRvIHNlbmQgIm5vbi11bmlxdWUiIHN0YXRlDQo+IHZhbHVlPyBPciBpcyB0aGUgY2xpZW50
IGF0IGZhdWx0IGhlcmUgZm9yIHNvbWUgcmVhc29uPw0KDQpUaGUgc3RhdGUgdmFsdWUgaXMgc3Vw
cG9zZWQgdG8gYmUgc3BlY2lmaWMgdG8gdGhlIG1vbml0b3JlZA0KaG9zdC4gSWYgdGhlIGNsaWVu
dCBpcyBpbmRlZWQgaWdub3JpbmcgdGhlIHNlY29uZCByZWJvb3QNCm5vdGlmaWNhdGlvbiwgdGhh
dCdzIGluY29ycmVjdCBiZWhhdmlvciwgSU1PLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

