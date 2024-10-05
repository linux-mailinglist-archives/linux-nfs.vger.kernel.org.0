Return-Path: <linux-nfs+bounces-6887-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE08A991908
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 19:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13151C210DE
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 17:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D609157A59;
	Sat,  5 Oct 2024 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aDQObZX8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CuuG55Cv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6117F1AAC4;
	Sat,  5 Oct 2024 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728150760; cv=fail; b=jwrHRxqHKfhAc/sCPf/f++7iBEyPhV7sLHFs52oLna9E74BF8S8vLEcxZVOM8DNxCkA+fmhsVJ9Ng3/3nhwaJdH76sc7vsysGutYVfkeNhkrJWPh9zKJ230AM1MZjR+lUeoQIHn5CpQZu9h3f1k80HXWDhHmsikjYmEbY4OmqQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728150760; c=relaxed/simple;
	bh=HFdb4IvLw0a7sykREFmwpcfhbSmmJI9CoJwIUrWXkpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jr9080Jz9j4HxmSwdyu8wU0auW40e+UWIVoE6XbipthxTm4/q2qKAcYe1WLMCZSI/aicSWFR5WUsVYXc53h2s3yMhcBSw8CdoYx+3jqWiBtnjXDcPxjx2eLsh7+cv4hTcc1b2kMILXS9Jb0pCHWElrFQDBfeGs6NXW5DDAeHtNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aDQObZX8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CuuG55Cv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495FZrG6008704;
	Sat, 5 Oct 2024 17:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HFdb4IvLw0a7sykREFmwpcfhbSmmJI9CoJwIUrWXkpM=; b=
	aDQObZX8OLacOYO4d8fenN5ai7zagoJJd+9T2EWLQ1MoJWPszeI5j9ns4u9GfaC3
	1pcDoaQROi2qkFTmEHXxyVIWt71pFjnCIOorFOUD3OmKOfT5iImPdceOqaMGQ6HT
	ZR6BGuSxoJkaypvBDq1c2IK0tmdTat8/B7/mhFfOhL02EjlQAQqv8b3/K+b7lmJm
	JGrB0shQTENs/0GZjQ+I6Z9DQCoraBQiD+mAsSFbGBlWlKwooNW3B00fcKyXPLJB
	o6qS6dT6AFPz9L+5i+pUvw/0DRwDmeEEe6FEXQ8qtxv33uJgj7BSgpap+L5+r0z8
	E5Z9RCe71Cwwhg1pWP9C9A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063ge2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 17:52:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 495GWTIS001215;
	Sat, 5 Oct 2024 17:52:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw4dgy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 17:52:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzoTjDJPp5NkhFcY6tVX8A5Bu3jA1iDXYIjoTI+rcuVJpREV63mF9w2aHI7BhkoCtNZUdoWqBq9XavTr8e7Ig0ZD09+LHBupj7mGJ53sOsD6/gLKeoiqB0AuHWoaps6B5Vv8aMscwApqV6ZJaxAzCNh/pJ6IWXtBpH+0Cf2908C8UHADYWyY0/ReGOpKpvG4B3Okz2xCxiWo0QU9x/6jh6WPQlMycD1c4lk1WyznbVWkXf/DGl1pd7tQub52ZD09YTgVvpO8ek6rs0bZhTUPX1SJ9E52GD8cdoQyKqT0Ea7k9Vh0ZPcSbtBG9yAyC+sUG3EuJpmPeUrTi3CnKYKO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFdb4IvLw0a7sykREFmwpcfhbSmmJI9CoJwIUrWXkpM=;
 b=TfHUli2iKoOadUSarnY7vSYhxpwOAL7Y7UgEGqkLSlz6SnBfB3uPNi6g1xwdYPV+ILFe25hXO/ZX8SpQL/4j2Wy8tTLTYjLf322YSILf8sTvPh1nafsHCrlqw6//3tg1EIVLQlL4eAQ+cnLYKVh4oh31xG5lHYfITKCcPOyMYnKigcDlJtXmnMn3BicJmTu4/NzR8Ifgbwc5IFB8LuVZNTPAeML1kPtMTzQJwzmtj30j8jASO0nt/o+334Rg/tiiYH+P3YSMHxaXLl+2GRLn75szdW+AmXShwpUcfMJ7cccR5zSggGQ+qMRo6tvhfZJSV8yFiiGkkN3h+rieqUvUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFdb4IvLw0a7sykREFmwpcfhbSmmJI9CoJwIUrWXkpM=;
 b=CuuG55Cvggi8xqT+y6lfxHXl7uA3k8itTekKd1X0F9obyZahC6FEoSLnKlUOVnonn+oKcJ4IVCo96aC/btQxbkWKGmMNqWGDJNH7UOvvH85+8Vvw7ddnvOe4zgZ8qnQAR+KQfvuGvL+V9hjvhwsYOTe14D+C/udxPrLyKkAK9DY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5879.namprd10.prod.outlook.com (2603:10b6:510:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 17:52:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 17:52:13 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockd: Fix comment about NLMv3 backwards compatibility
Thread-Topic: [PATCH] lockd: Fix comment about NLMv3 backwards compatibility
Thread-Index:
 AQHbBWa0DBt0/gIdRkSsStsFqwuJWbJUxzCAgAADLYCAAAG9AP//vo2AgCP4LICAABDwAA==
Date: Sat, 5 Oct 2024 17:52:13 +0000
Message-ID: <01C90EC0-1C3E-4880-9D33-ADCDA5B35483@oracle.com>
References: <20240912225320.24178-1-pali@kernel.org>
 <172618264559.17050.3120241812160491786@noble.neil.brown.name>
 <20240912232207.p3gzw744bwtdmghp@pali> <20240912232820.245scfexopvxylee@pali>
 <ZuN6ah3nI0giafGl@tissot.1015granger.net>
 <20241005165125.rbtgxzz4olvv4sqn@pali>
In-Reply-To: <20241005165125.rbtgxzz4olvv4sqn@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB5879:EE_
x-ms-office365-filtering-correlation-id: ef381ba4-a102-430e-16cd-08dce566716d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVNYRUVpZkF3eUFTV0JaNExYaElqZXBSRVdsWjhPVHI5dlA5eHhHNUVHOE54?=
 =?utf-8?B?TGlxRTMrcWpkU080eVUvelZ0RW4rMDFMZFhzTGdPMTVsam9KQm1lQ2gzY2ly?=
 =?utf-8?B?R3VkTXNBbkZnQ0tKR1I4eGlJYnc5MjlzNGx6aG1DcXhYL0s2OWoxb0NLWTYv?=
 =?utf-8?B?RTB4N1JKaWJYamVmdVhSYkdVVVZYRjhaMUxqa1NFMkxJRElwaHJodkdHSVFs?=
 =?utf-8?B?TzZFd3hVY2liaS9JZE5hblQ1bmY4SDRtVEtwS0ZHZ1JmL2JxRkt1TkNrdk9o?=
 =?utf-8?B?R1NOWUs2UVcxQmJ3ZXFKQXVpT3ZXQ3NoL3A5T09haWpUWHRoa3V1aWppY2g5?=
 =?utf-8?B?OXNMYlJ3eHU3WWxxb2ZuOXBLaU1ESkZBRElGVDVEM3YyNSs5aWF3Y1hGL1Fr?=
 =?utf-8?B?emJidHJWdi9GWldYbFh6MXcyM3NWVUQvUzdEcXZ2UWVDeWd2UUdrVGhISWlk?=
 =?utf-8?B?RUc5ZWN3N0lGNDFMc3RJK0M3ekM0M2d1UmphVjhuSmIvTHo0N21oSFRVVmgv?=
 =?utf-8?B?eVJCaHh6UkV0VTk2THRndCszckhNRWUxTkcyVFBGcnE4ekxvaEdBZW8ycTkx?=
 =?utf-8?B?UWtPMCtqblNrZmQreUF6bVNDZURYSjZjRUxSUDVNYXQ2UzNlYUhmMUkyNlpC?=
 =?utf-8?B?VUdMOTR1RlpJUE5McXlVQ2oxVVhEOExnNUdYL3JZOFAvUm9qODZ0U1JxSGd1?=
 =?utf-8?B?RVVJaFUzVTl0SkhnWVhESE12cXp4M3VBTCt5YkUwU2ZMelEzOGp5M2JGVmNr?=
 =?utf-8?B?NWxtTnZ5YW9kblRtRHNkc3M4TndEMjl5VU1VenVFUW5BbkgyanpwYngvT3Bk?=
 =?utf-8?B?TjdqQXJHTDhsOThwNUdwYW9OT3VTdjZTb0xqRHlseXMrSlhzQ0xmUG45TStX?=
 =?utf-8?B?S241OTd2Tm5jdU51d2MxMUdyVS9nR3d2eTdwZmFtWlJtRTc0bldwWG9nNTc3?=
 =?utf-8?B?cDdZOFJwaGFKSW5zbW1CZjM1akpIOFovK1FMRVBRajAyS2QxQWlya1p1NzZi?=
 =?utf-8?B?MFdGelE4ZmZxdEUxbnA5VlVVU1dER0Vmclptd1libWF4TERtc3RtbjhXWWhr?=
 =?utf-8?B?RFlGRzNvRmRKRDl0QkVBblZvQjBkcEV4cmRueGFuSUhMcDlMVFl4dGZZOHZF?=
 =?utf-8?B?U2ZMU3Z5WStwSDc5U2drNzdTTEsvbHZ3SnFLbmRQZ0dBUytXR0VNMk1nbjlP?=
 =?utf-8?B?OXlURXBUQkE2OFgwL3A3YkhUcEFBNHlrbkxqemN2dXJCLytMWTBYTythc3Vv?=
 =?utf-8?B?RGxVUWdGQUFVM1BESUlRMnYwd3NMZGZXWnZNdzdLUjU0dDZHNFdDQnFyNktm?=
 =?utf-8?B?MjhHajVhcDRPL0V0THhtN3BaTzhpQVl4VC92cnVVK3JlclNtUGNVbjlGaDV5?=
 =?utf-8?B?TGdVRDZBanhkMnh2b1pjdDBjeEtNeFY3TFlUVWZJaW0xZUh5bFdjSUtOQlVX?=
 =?utf-8?B?RmwrUmgvQXQ2cHNTQmJoNHFJR3hHT2NoN1VsTFJoTzlZd084aExmODNkL3hC?=
 =?utf-8?B?MEYwbm43WWgyMDhoYmxWODR1YmFHVXFMOUhlVkc3dkZhTlRycy9GQmpJMXRu?=
 =?utf-8?B?ZWNlYjNMR0ZOVDVjOWZZVmZ4Z3F5S2gvZUhUYmdqVTJKeTJLNkNWWmp3bGpB?=
 =?utf-8?B?ajQ5NkNHZzFyYlZXaGl3ZjVscEUyTVpIVFpBSzhwM2NzV1RtN0NBYitIUXFr?=
 =?utf-8?B?cXJxRHVkS1RadXAzVk5iVzRnaUpPSTZKK3lKWEY0Z04yVDg2bnJoa0pNN0RP?=
 =?utf-8?Q?UJ8XwafYxdF0N5Dkbc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2JHWnY3ZTZwanlnSCt5bFBTZ1VRbCt5cFlaSmJDdXVYV3VSOXV3S0V1Vk43?=
 =?utf-8?B?RlVGbi9ORGw3dTdodkszR2VVN28zMlhvQ0VUTnBNRVVlOGhIWVp5azZlRUpK?=
 =?utf-8?B?eWdlaDNGcTBQNlhPNFBIb2RxUW5QM1RPdjNrNmRYVDJHb1BPMjEwZmJPQzVM?=
 =?utf-8?B?QjUrRGYrRWNtaGhMY2JtL1hrMjQ3Sm16RjBid3dESXo1YW5SeTdHWlVVYXgz?=
 =?utf-8?B?S3BMcGFGdzF6SVFJZDBqcWN2cStic3d6OTNkWTVDc0QxbmhSMmNTR2d4bmpp?=
 =?utf-8?B?Vy9wa0cyU0RVWHc5VUI5T042THpCVHhlTFp6bHdpcWMxQ1hrYWZDbk1SRFBa?=
 =?utf-8?B?RUdyT2dTR0NvdVZUK2x1K0pCZjZDRkpieHI3T1JhbTdRaGQrOGFMeVNzaVMv?=
 =?utf-8?B?dGJaR09IQ3U1aXhMUzBkb0tNTG91R2xvbTFFRGdhVHo3NHh2d3haTE1Gc2VY?=
 =?utf-8?B?ZnVSYW9PTW9pUHZLRnlGMXJ6bk5DdUNtcFZuaGVLNUN6TVNUaVpJa1FlU2tv?=
 =?utf-8?B?SkoyNFZORkVHcitTbUp4NTQ1dFNRdE9ZSittVzBad25hUityV2dKKytXUCtp?=
 =?utf-8?B?aUdxVmRTTjV0eWNOcGJ4N3JnVUdkNWFpbHAyMlBGTWczQWFydWpGSlk4RGVT?=
 =?utf-8?B?Y2NuRHNEWVUvWTJocUpaSVlTVVZoekVOWlpMWU9YNlhqcmJHVDVabCtCWTNh?=
 =?utf-8?B?L1U3dnNNRFIwcUprc1l1MkNMWllqQlpucmc5N2hNeVBaejRvWlB6ajFnOHZ2?=
 =?utf-8?B?UnBON0I3Z3RIMHN5Y05kMEw2ZDBUaG04cmd4UFlhSWRicXZsa0VuUTMvUENw?=
 =?utf-8?B?b3RIbk1ydEFFK3Y3MVVVNjQ1UXNJV0RZZ0tyZzdBMWd4WUFuMWpVa25HSTFp?=
 =?utf-8?B?UUJSOXNScFZUUHpNVm9oNkJCZFY3ZlJlcWhTSExLSW5NeVpiaEtNdUYwd0pq?=
 =?utf-8?B?MEZoQ1kwL015VUNpM1FiNlBDTCtJeFdqMnNyQVovelNDYlZBWHZJQ0tUaUJS?=
 =?utf-8?B?dzBDUDBQY1NHbmplMXFpY1BFVmludm13c0lDNFd4RWF2Mkdac3hzKzlWVGtr?=
 =?utf-8?B?MFhSTllGTHhKL2xMdWVKM3RmRkhjYkVKSTI5Z2VYZ0cwbm1TQUNENGdDVUta?=
 =?utf-8?B?aHl6WVdhRlFrTHdjb2FDNUEvc1JPNHI1a3ZkZkdWeFd4aUV0UXBZaWM0QWYx?=
 =?utf-8?B?WW16ZXJQT0tDWWVKRGRxM2IxOXZMYUxiK0xBVVZacy9nVzh5UU5CTFV0SmNr?=
 =?utf-8?B?ak1zb0Y1NzJRakgyVlB1TUs4UnArQ0dPL0lxMVdwTzNqTXh3ZVV4eHNnZTRa?=
 =?utf-8?B?QWZGc0hTb2IwOXRvdTI4YVdqSHphc3FwVzN6bkY2M0FteHMvOHBXeTlkK3Ny?=
 =?utf-8?B?RzNjR1hNeWMzMHF0VmJWOXF3U25XNjdjL0tzek9yeng3SU9EMTQ4RXZ3V3I2?=
 =?utf-8?B?UXlaQk9tbElteGlFZ2lSZTZyZ2xrMHliSFJCZjBJV0F3Vk1RVXFHNDlZbWVL?=
 =?utf-8?B?dTlSWDl4elJ4ZFEyNU5rVmk1emhRdzBvV0FLOUk1ZHRsWi9vL0xWYmFWQ0p3?=
 =?utf-8?B?V2l3eUpaZ29iQzlMbnlwaVNOOURSaDhoNktOOHVNekp1NTlSZ21UVm9LMnYz?=
 =?utf-8?B?Q2dtbmEzNkxsVU9EbkRuRWNFRmQ2aWk4cHdKM2NsYzI4TjV6dEcvMVBjL3Iw?=
 =?utf-8?B?MXZZZk1HZGxWYkpnQXR5MmEwbjdQT1FhbVRDK0NrV2F2akt5ZEZ1bDdEc3oy?=
 =?utf-8?B?Vlh1YmNUMDFsTE5QYVZhUW1HYWF0UHpNSUlHUFUwaGRTU2RGQUtYbmJyc2FI?=
 =?utf-8?B?bEg0VHZJTFN1aTdvNG5LaEcxbEZ4dDIxbnEwd0FXVXdDT0xJdzVwUDd2bFoy?=
 =?utf-8?B?QWRzMnNaY0ZHT1dPa3ZERDYwTEJDdFY0eXZMMzk0aU44UnZMQ2swSVJ5azVF?=
 =?utf-8?B?amtSVXRxR0dlMVVGY2VONEdDYkJTV0MxRWw1eHhjYU9FaVU2NXpaS0FWRlht?=
 =?utf-8?B?NTRVc1NXNnlMS2NJVlBSeWVGYlE3RFNvNHZzWmNQUnA2bzJ6NzN2ZE9VYm82?=
 =?utf-8?B?Wm45QWRnQ3JPcFhXdzM5Qk5WMzgvc29yNDNicEVNcU03RFRVZmdRRE4zNmRq?=
 =?utf-8?B?T2lKa1U1VVVSUWIrNFJqRWVGRWFXcVgwMWdLaXhpaTFVcy9idWdPM09zNlQ4?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBD03827643F81449567F755E71D51C7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4uhonWJPRd6WvLfZ+kXIsnvzb05EN4cjekOy2kUiF6/XL/FDo6bh9Fq1g4zGtxLE6t60nctTJjfplvD35/4a7vDH6TuLcM0k62q15kk7IV1Tsgz9ntkBA4nxLzcACkEnTl3sqBP6yd02v/PlAJuQPRHqdjyGE1qZqi+M6oaWueLWBEmruAazy93/JK0TdgXWDXnVRSMKb7KOJWxW+ciSOZjRcQOvgKWUSQgV8LGDxrhrS8A+uFhAV9x9rbY3i9ZVZ3CnfUG8HYA6KPZXwncyHC3ZSu1NFagvUvKFEnjntcqBmMKKGU2L91YVNhfX+SCzpAkRckIEqC20z2Ssvgja+IMa7caR8nVoHXUedbpztNFh9aR+q6RF5TE2QMpLDwixBuPNtWGAm3alHQjtHOlZn1s2gekYUhjMSYH7EMMK/M9yf0DvbLwE8+WQsK9RdGMgsZeB6xlYsXwrjB/iPocJenX/0nwPOzHUnq1lcJb4U8umNYoLVg0u/bxl3AGLpQ2y64PEp58tpi9feIP1GQwGMAC1+mKPEvYrbSfsx3Y/oSYD6sjn4+/XH+64DhzKpkoXV0BHvdpaK9XztQKeKp6uT5pEi6lvk+WUQJXfTPiCDZI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef381ba4-a102-430e-16cd-08dce566716d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2024 17:52:13.1795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxcaD0a0R8q5PNPyaChL3OQTLLhri6zdXVlx4+/wI6Y2cxXyzm2ZcRGxWaNve8tx7P6r2eHAtf4YzWyivBP4iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_16,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=600 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410050131
X-Proofpoint-ORIG-GUID: lQbtS64j3rM8svH0wm0y8PkWihfJPuzz
X-Proofpoint-GUID: lQbtS64j3rM8svH0wm0y8PkWihfJPuzz

DQoNCj4gT24gT2N0IDUsIDIwMjQsIGF0IDEyOjUx4oCvUE0sIFBhbGkgUm9ow6FyIDxwYWxpQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1cnNkYXkgMTIgU2VwdGVtYmVyIDIwMjQgMTk6
MzQ6MDIgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+PiBPbiBGcmksIFNlcCAxMywgMjAyNCBhdCAwMToy
ODoyMEFNICswMjAwLCBQYWxpIFJvaMOhciB3cm90ZToNCj4+PiBPbiBGcmlkYXkgMTMgU2VwdGVt
YmVyIDIwMjQgMDE6MjI6MDcgUGFsaSBSb2jDoXIgd3JvdGU6DQo+Pj4+IE9uIEZyaWRheSAxMyBT
ZXB0ZW1iZXIgMjAyNCAwOToxMDo0NSBOZWlsQnJvd24gd3JvdGU6DQo+Pj4+PiBPbiBGcmksIDEz
IFNlcCAyMDI0LCBQYWxpIFJvaMOhciB3cm90ZToNCj4+Pj4+PiBOTE12MiBpcyBjb21wbGV0ZWx5
IGRpZmZlcmVudCBwcm90b2NvbCB0aGFuIE5MTXYxIGFuZCBOTE12MywgYW5kIGluDQo+Pj4+Pj4g
b3JpZ2luYWwgU3VuIGltcGxlbWVudGF0aW9uIGlzIHVzZWQgZm9yIFJQQyBsb29wYmFjayBjYWxs
YmFja3MgZnJvbSBzdGF0ZA0KPj4+Pj4+IHRvIGxvY2tkIHNlcnZpY2VzLiBMaW51eCBkb2VzIG5v
dCB1c2Ugbm9yIGRvZXMgbm90IGltcGxlbWVudCBOTE12Mi4NCj4+Pj4+PiANCj4+Pj4+PiBIZW5j
ZSwgTkxNdjMgaXMgbm90IGJhY2t3YXJkIGNvbXBhdGlibGUgd2l0aCBOTE12Mi4gQnV0IE5MTXYz
IGlzIGJhY2t3YXJkDQo+Pj4+Pj4gY29tcGF0aWJsZSB3aXRoIE5MTXYxLiBGaXggY29tbWVudC4N
Cj4+Pj4+PiANCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQYWxpIFJvaMOhciA8cGFsaUBrZXJuZWwu
b3JnPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+IGZzL2xvY2tkL2NsbnR4ZHIuYyB8IDQgKysrLQ0KPj4+
Pj4+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4+
PiANCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZnMvbG9ja2QvY2xudHhkci5jIGIvZnMvbG9ja2QvY2xu
dHhkci5jDQo+Pj4+Pj4gaW5kZXggYTNlOTcyNzhiOTk3Li44MWZmYTUyMWY5NDUgMTAwNjQ0DQo+
Pj4+Pj4gLS0tIGEvZnMvbG9ja2QvY2xudHhkci5jDQo+Pj4+Pj4gKysrIGIvZnMvbG9ja2QvY2xu
dHhkci5jDQo+Pj4+Pj4gQEAgLTMsNyArMyw5IEBADQo+Pj4+Pj4gICogbGludXgvZnMvbG9ja2Qv
Y2xudHhkci5jDQo+Pj4+Pj4gICoNCj4+Pj4+PiAgKiBYRFIgZnVuY3Rpb25zIHRvIGVuY29kZS9k
ZWNvZGUgTkxNIHZlcnNpb24gMyBSUEMgYXJndW1lbnRzIGFuZCByZXN1bHRzLg0KPj4+Pj4+IC0g
KiBOTE0gdmVyc2lvbiAzIGlzIGJhY2t3YXJkcyBjb21wYXRpYmxlIHdpdGggTkxNIHZlcnNpb25z
IDEgYW5kIDIuDQo+Pj4+Pj4gKyAqIE5MTSB2ZXJzaW9uIDMgaXMgYmFja3dhcmRzIGNvbXBhdGli
bGUgd2l0aCBOTE0gdmVyc2lvbiAxLg0KPj4+Pj4+ICsgKiBOTE0gdmVyc2lvbiAyIGlzIGRpZmZl
cmVudCBwcm90b2NvbCB1c2VkIG9ubHkgZm9yIFJQQyBsb29wYmFjayBjYWxsYmFja3MNCj4+Pj4+
PiArICogZnJvbSBzdGF0ZCB0byBsb2NrZCBhbmQgaXMgbm90IGltcGxlbWVudGVkIG9uIExpbnV4
Lg0KPj4+Pj4+ICAqDQo+Pj4+Pj4gICogTkxNIGNsaWVudC1zaWRlIG9ubHkuDQo+Pj4+Pj4gICoN
Cj4+Pj4+IA0KPj4+Pj4gUmV2aWV3ZWQtYnk6IE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4NCj4+
Pj4+IA0KPj4+Pj4gRG8geW91IGhhdmUgYSByZWZlcmVuY2UgZm9yIHRoYXQgaW5mbyBhYm91dCB2
Mj8gIEkgaGFkbid0IGhlYXJkIG9mIGl0DQo+Pj4+PiBiZWZvcmUuDQo+Pj4+PiANCj4+Pj4+IE5l
aWxCcm93bg0KPj4+PiANCj4+Pj4gSSBoYXZlIGp1c3QgdGhpcyBpbmZvcm1hdGlvbiBpbiBteSBu
b3Rlcy4gSSBndWVzcyBpdCBzaG91bGQgYmUgcG9zc2libGUNCj4+Pj4gdG8gZ2F0aGVyIG1vcmUg
aW5mb3JtYXRpb24gYWJvdXQgdjIgZnJvbSByZWxlYXNlZCBTdW4vU29sYXJpcyBzb3VyY2UNCj4+
Pj4gY29kZSB2aWEgT3BlblNvbGFyaXMgLyBJbGx1bW9zIHByb2plY3RzLg0KPj4+IA0KPj4+IEp1
c3QgdmVyeSBxdWlja2x5IEkgZm91bmQgdGhpcyBJbGx1bW9zIFhEUiBmaWxlIGZvciBOTE06DQo+
Pj4gaHR0cHM6Ly9naXRodWIuY29tL2lsbHVtb3MvaWxsdW1vcy1nYXRlL2Jsb2IvbWFzdGVyL3Vz
ci9zcmMvdXRzL2NvbW1vbi9ycGNzdmMvbmxtX3Byb3QueA0KPj4+IA0KPj4+IEFuZCBpdCBkZWZp
bmVzIE5MTXYyIHdpdGggdHdvIHByb2NlZHVyZXMgbnVtYmVyZWQgMTcgYW5kIDE4LCBwbHVzIHRo
ZXJlDQo+Pj4gaXMgYSBjb21tZW50IGluIGZpbGUgaGVhZGVyIGFib3V0IHYyLg0KPj4+IA0KPj4+
IFNvIHByb2JhYmx5IHRoZSBiZXN0IHJlZmVyZW5jZSB3b3VsZCBiZSB0aGUgSWxsdW1vcyBzb3Vy
Y2UgY29kZS4NCj4+IA0KPj4gV2hhdCB5b3Ugc2VlIGluIHRoZSBJbGx1bW9zIGNvZGUgaXMgbm90
IHNvbWV0aGluZyB0aGF0IGlzIHBhcnQNCj4+IG9mIHRoZSBzdGFuZGFyZCBOTE0gcHJvdG9jb2ws
IGJ1dCByYXRoZXIgYSBwcml2YXRlIHVwY2FsbCBwcm90b2NvbA0KPj4gYmV0d2VlbiB0aGUga2Vy
bmVsIGFuZCB1c2VyIHNwYWNlIHRoYXQgaXMgc3BlY2lhbCBzYXVjZSBhZGRlZA0KPj4gYnkgZWFj
aCBpbXBsZW1lbnRhdGlvbiBvZiBOTE0vTlNNLg0KPiANCj4gT2suIEJ1dCB0aGlzIGFwcGxpZXMg
Zm9yIHYyLCBubz8NCg0KT24gTGludXgsIHRob3NlIG9wZXJhdGlvbnMgYXJlIHBhcnQgb2YgdGhl
IE5MTXYxLzMvNA0KcHJvdG9jb2wgaW1wbGVtZW50YXRpb24sIHNvIGVzc2VudGlhbGx5IHRoZSBO
TE0gdjINCmZ1bmN0aW9uYWxpdHkgaXMgYSBwYXJ0IG9mIGFsbCBOTE0gdmVyc2lvbnMgb24gTGlu
dXguDQoNCg0KPj4gQWxzbyBub3RlIHRoZSB3YXkgTkxNdjMgaXMgZGVmaW5lZCBpbiB0aGlzIGZp
bGU6IGl0IGRlZmluZXMgb25seQ0KPj4gYSBoYW5kZnVsIG9mIG5ldyBvcGVyYXRpb25zLiBUaGUg
b3RoZXIgb3BlcmF0aW9ucyBhcmUgaW5oZXJpdGVkDQo+PiBmcm9tIE5MTXYxLg0KPiANCj4gWWVz
LCB2MyBpcyB0aGVyZSBhbmQgaXMgaW5oZXJpdGVkIGZyb20gdjEuIFRoaXMgaXMgYWxzbyB3aGF0
IEkgcG9pbnRlZA0KPiBpbiB0aGUgY29tbWVudC4gVGhhdCB2MyBpbmhlcml0cyBmcm9tIHYxLCBu
b3QgdjIuDQoNCkdlbmVyYWxseSB0aGlzIGlzIGFuIGFidXNlIG9mIHRoZSBwdXJwb3NlIG9mIHRo
ZSBSUEMNCnByb2dyYW0gdmVyc2lvbmluZyBtZWNoYW5pc20uIExpbnV4IGhhcyBhIHZlcnkgc2lt
aWxhcg0KdXBjYWxsIG1lY2hhbmlzbSwgYnV0IHVzZXMgTkxNIHByb2NlZHVyZSBudW1iZXJzIHRo
YXQNCmFyZSBzZXQgYXNpZGUgZm9yIHRoaXMgcHVycG9zZSBpbnN0ZWFkIG9mIGFidXNpbmcgYQ0K
bW9yaWJ1bmQgcHJvdG9jb2wgdmVyc2lvbi4NCg0KDQo+IEluIGhlYWRlciBmaWxlIG9mIHRoYXQg
bmxtX3Byb3QueCBpcyB3cml0dGVuOg0KPiANCj4gKiBUaGVyZSBhcmUgY3VycmVudGx5IDMgdmVy
c2lvbnMgb2YgdGhlIHByb3RvY29sIGluIHVzZS4gIFZlcnNpb25zIDENCj4gKiBhbmQgMyBhcmUg
dXNlZCB3aXRoIE5GUyB2ZXJzaW9uIDIuICBWZXJzaW9uIDQgaXMgdXNlZCB3aXRoIE5GUw0KPiAq
IHZlcnNpb24gMy4NCj4gKg0KPiAqIChOb3RlOiB0aGVyZSBpcyBhbHNvIGEgdmVyc2lvbiAyLCBi
dXQgaXQgZGVmaW5lcyBhbiBvcnRob2dvbmFsIHNldCBvZg0KPiAqIHByb2NlZHVyZXMgdGhhdCB0
aGUgc3RhdHVzIG1vbml0b3IgdXNlcyB0byBub3RpZnkgdGhlIGxvY2sgbWFuYWdlciBvZg0KPiAq
IGNoYW5nZXMgaW4gbW9uaXRvcmVkIHN5c3RlbXMuKQ0KPiANCj4gV2hpY2ggc291bmRzIGxpa2Ug
dmVyc2lvbiAzIGhhcyBub3RoaW5nIHdpdGggdmVyc2lvbiAyLg0KPiANCj4gTXkgdW5kZXJzdGFu
ZGluZyBvZiB0aGF0IGNvbW1lbnQgaXMgdGhhdCB2ZXJzaW9uIDIgY29udGFpbnMgb25seSB0aG9z
ZQ0KPiBwcml2YXRlIHVwY2FsbCBwcm90b2NvbCBiZXR3ZWVuIGtlcm5lbCBhbmQgdXNlcnNwYWNl
IGFib3V0IHdoaWNoIHlvdQ0KPiB3cm90ZSwgYW5kIHRoZXJlZm9yZSB2ZXJzaW9uIDMgaXMgbm90
IGJhY2t3YXJkIGNvbXBhdGlibGUgd2l0aCB2ZXJzaW9uIDIuDQo+IA0KPj4gSU1PIHRoZSBjb21t
ZW50IGlzIGFjY3VyYXRlIGFuZCBkb2VzIG5vdCB3YXJyYW50IGEgY2hhbmdlLg0KDQpIb3cgYWJv
dXQgdGhpcyByZXBsYWNlbWVudDoNCg0KICogWERSIGZ1bmN0aW9ucyB0byBlbmNvZGUvZGVjb2Rl
IE5MTSB2ZXJzaW9uIDEgYW5kIDMgUlBDDQogKiBhcmd1bWVudHMgYW5kIHJlc3VsdHMuIE5MTSB2
ZXJzaW9uIDIgaXMgbm90IHNwZWNpZmllZA0KICogYnkgYSBzdGFuZGFyZCwgdGh1cyBpdCBpcyBu
b3QgaW1wbGVtZW50ZWQuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

