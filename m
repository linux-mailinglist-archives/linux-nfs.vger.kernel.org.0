Return-Path: <linux-nfs+bounces-7321-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583989A692B
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 14:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7CF1C2112D
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9FF1F4FC4;
	Mon, 21 Oct 2024 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NvoZ4oEn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AIRB0+fw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B3B83A19
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515379; cv=fail; b=YY0sG5d9qzxbADOEAEpOhsOfkfdiECv6Ssw1hlaW5KBnvXtUAiU8hOX07uSPR0edIRQniWM07ASVC/L34oGvq3gDSLXESM/Mds64XZexXeowW/pCaR320RjfzzvL4YGViKo3n1RhHjteOM70NnrO5x0EExTJ3vZDCzKo2JLjtyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515379; c=relaxed/simple;
	bh=UezMJCx4W/UQL/qRPXfM0LBEipQobVx0KMpvRc/bunU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KXtHu+ggF/M/J1QzERKVPbSOF6eE1v20BuvKYF8KBFnjLX6WmJ3cmmFi+0+sDRm4UHrh1705IJD5m379Vq2aw6IoyJdnLP81MBvLnzN6kfDOn2RtimL1QAoBVsAy/+GcKn1bYajzvwHXeKXgpiD6Lw0zpAzbH+ePNlZCXrSVYjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NvoZ4oEn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AIRB0+fw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L96dds029492;
	Mon, 21 Oct 2024 12:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UezMJCx4W/UQL/qRPXfM0LBEipQobVx0KMpvRc/bunU=; b=
	NvoZ4oEndVp5YaFI/o56Mn0T2yn12dYCH986shTU0PxNuKqRsonHOr+MvfT7njx+
	4WgzbVSJYOlIkc2TX3AXPw4Wb7S3MclAZ0wRZIAVQRudjbk8nOsSkdgtiz3VLxuR
	r2i51SWlUoIVbSM+kuqgLb9FibDXunGcrKpPyFScCCPYmd0oeSUPFRO7C1MKxH2W
	9gF1g/8JMYmpD3AXXIDch5EluuPX285jSv54Pv0QiGcm5moGToR77ltRmtg7hWZM
	kgWCC/OVCeAMWarCQlNZ3SaThGakbvq1HXQ7xKYVUpG20hGO9FCPfF7UVz/lIFUl
	0x4H4unlERO/wlu62CzjDg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uk1b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 12:56:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LBbfCC026222;
	Mon, 21 Oct 2024 12:56:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376984x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 12:56:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNfSkYM7dK++wpY/+jAhD7ar9JrZhG5ncVZNtK7zmjuUybtSzPX2QSph8DUP1kY/uOruC3fsVzqdzx5QgYR0R+c1g2qdDh+gX6vlJ8IIhXPTZ4pof4v8BJ8BDwDwXykvwr25KZ0ulbkfk63yH7goVtT8+VdQNKZMct7uCnQpSonjlTBKu05u0v2b5te/hxSGHEQHJ/aGFh2/Y+10bUfC5YDGXuK7Qi9OCVS/xeFJnC1WI1P09/1Nsk2yR/gfnzmIX/sNg/QQ83sC+rxcLws4VC/QuqfI5puwe/ojxat2Jngyuq3IWk/Wu2v1K8PscHQN5/YFnhcMHeuOlcwUFriXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UezMJCx4W/UQL/qRPXfM0LBEipQobVx0KMpvRc/bunU=;
 b=X4x4GIaQ8XLoaaT1LTaA5homj8l6Z4ITF3u4T4TuyaJBip/CcPJspeu6Bawi8i9UXUn3kw7oE6IY7kFksEwja8G/OacPi6+6qPHxMsouN4jxyzzJuVeuX4JK9s5pxD+EL0jStCEKdqq1SUDluErdE2BmKmP2v16hSRN8+TL9q9VAUkjZRVyrDOvxyWFrBVr32E+1Fyjzwa24Tq2APL+pHH3miYSSScUuhU+3JwE6sKjyNZ+kg/f+LbRx8n7VkiNmWcjjvGPk+flzT4ug9wqyQHd78ejPo/d/z717q8opcJ8JG2hjc2ZLeQTd4SpU7rnY/ncidJXtqcnFS8LXaob68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UezMJCx4W/UQL/qRPXfM0LBEipQobVx0KMpvRc/bunU=;
 b=AIRB0+fw7CxJha84AeQdYIVPQx10CeXQUdLVKWHwOPliMvTRmK1UZ+5PGyga30e3X+UNNnNK0nRXL+YC2PnWuH+Pj9QXZydJ1xD5UO3MFwJWGzq+5Kijm7cWh/h8ffUoddMZDGv5UsBuyc3Zlrny4k0eQlPv8WXrdveWTOGzOTI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4645.namprd10.prod.outlook.com (2603:10b6:510:31::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 12:56:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 12:56:09 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chen Hanxiao
	<chenhx.fnst@fujitsu.com>
Subject: Re: exports(5), documenting refer=
Thread-Topic: exports(5), documenting refer=
Thread-Index: AQHbI3jUNyOgVGUqVkW6ACTtob7KTrKRKjYA
Date: Mon, 21 Oct 2024 12:56:09 +0000
Message-ID: <02ED1302-F18E-46D4-A48A-79EA461628F9@oracle.com>
References:
 <CALXu0UchyrLY7mbjXS=C6VFLY0A-maF=-DbzO69bCxtVbaa0EA@mail.gmail.com>
In-Reply-To:
 <CALXu0UchyrLY7mbjXS=C6VFLY0A-maF=-DbzO69bCxtVbaa0EA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4645:EE_
x-ms-office365-filtering-correlation-id: e0b09ad9-4428-408a-66f1-08dcf1cfbc31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmxGT2VCT0Q5WUFPMmFyZzNiVE5NL2RLM2xQNVpVRnlPNzRPaXhhY0V1eDQw?=
 =?utf-8?B?UlVOMCs4b3lsMVBOMzJTMjZsblloUTcxRWw3UCtjS1hqUXBjazFWMDRKVUFt?=
 =?utf-8?B?KzNWUXlsdE03NGYvSkZGbjk3cWNBeWpwbkhrMy9jVXV1MC9ZQWpjcU9TNGhW?=
 =?utf-8?B?ME5FRENxM09UM0YyTVRzeEx3N2crbWtrTzZmZW5SQ0xPYjdjT1UyWXE1RzAy?=
 =?utf-8?B?UDFBa0hqYVVoalIxMGwvOG5oRHRlWHV6S0hQL1Jud2EwR09zOUc5eHBYRGVz?=
 =?utf-8?B?L2xXRjMyemVMbjBsNmt0T3BHMU9wWDdPNXg4YlkxeHp1cGtOazZacUt3RFUv?=
 =?utf-8?B?TmpINXE4b0lNQkc4MFJscThYUUtHQ3ZIQm9SWlVJQXYvTFlyWHlremhtREUx?=
 =?utf-8?B?cERiQlBQdDRkVXlVdkhlZGJ3Q0hjMnlTV0Z4OXcrbVdxb1oveXZ4VHd5b21w?=
 =?utf-8?B?UFRnZ3pGOHNxQlpkZmNRR2p5NUdFdHo0dFZmUHpWVWdFaHZTV0ppMVA5Njl6?=
 =?utf-8?B?MjNoNGdNaFk1c285K3RBNHByKzhobUxUYVEvbW5QSWsva0hyck9RWHYyUEQ1?=
 =?utf-8?B?S1JMRWtSSkF2d1k4V2Z1U1JoNE4wOUtwT0dvQkNwbmtWMkpTL1M1dmdCVlJj?=
 =?utf-8?B?VG9oR0pobWd0dWhjYXcxZ0t5L0JHTDJZOGxRUzdvMFNPWTM2VEVpOEdsSHAz?=
 =?utf-8?B?bG02VTRuZ1Y0dXNrZ2cwamZBRlRjMExTbmJjU1N3YzNIZmdnNFJGWUNzdE8r?=
 =?utf-8?B?TVl4bXloUlNWc0tYOURtakF0Y0M2R055ajlZdkN1bEFIMENsdmZSL0daU3hS?=
 =?utf-8?B?VkxsQWRxbzdTWlZiVk1TWkQvQ2RLR3RjWDNrQ1R0QTJzTldKS1ZjYUlLemVS?=
 =?utf-8?B?TmUyQWpWaUcwVHREZUY1cFA5dmp3akxTeGNmdkNFTTZVbjd4VWJSMTdKWFZL?=
 =?utf-8?B?TENOUkVjYnFKY3IvT2VRZ1loalpqRGoxNHlqeGN5TzN6c3pWbDJFTHViNzZZ?=
 =?utf-8?B?andOcG9NL29wTUdHSXoyMWV4Z0VxUVlXQ2lobzVKRnJCeHRQdnJUSHNOVEVy?=
 =?utf-8?B?TGpSbytNdUdpTjN6a1gwczY5K2NtQzRpUEd5VGMrS2NpNTdUbC9TRENlTFFv?=
 =?utf-8?B?NW0wbCt1YXFZZ28zdlpyM1JFQnoybk1RZE1iS1NScVU3b0JZSzVHVUFqSUVx?=
 =?utf-8?B?UzRXeFdVOGNFK2xUeUNaaFArZG0zYzJYekpQQm9QenhwU3hhdTlkRmhDNURX?=
 =?utf-8?B?QzFramJZblpsdVAvMGxCODBjK2gwUXppYWxPdFdLYzRXN21nVEVMbU5yQnA5?=
 =?utf-8?B?d3NCbUR0QzAvdEFDUGh0ZUw4bUdhOUt2MzlOd1FUUVhnZVp2cHIyT3dxVDZI?=
 =?utf-8?B?RlduR3hFdUZoSW1qNEVCYlppcEVQYTNjVlBBRXJwdjdRT0RWMGhqYTNwbmFt?=
 =?utf-8?B?VXg0ejVPQ0JTa294TDJkeFM2Qk5vdWQwUVVVaWJpUzR4WDRWNmRQM00zcURo?=
 =?utf-8?B?VUxNYXU3dlRVelBnMUJibVd3N1VtdEZSK1R6bGI1TFVIa0N5cnorcUJRTUQ5?=
 =?utf-8?B?cUVSd3F5dzlrcGhtaHM5UkpON3VIei9EdTdmRVlWSHJScFBVenk0QlZGUjZt?=
 =?utf-8?B?T1VJV1pPaDdPWm9ldzRMNDB5alZ0Z0diMDZwUm5mb3RPQVNJbHh2eXE5dTh1?=
 =?utf-8?B?Q0VZV3hkMzVuTjR4QmdmMWZ4dGVDdGZkTmZzbnoxU1pPM1BmZGdTN0puNFRS?=
 =?utf-8?Q?OJyHfPWVuPpZ1GLSng6kbpkDhqFMJtnErl7udKe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTJiNVdBNmY5UTlhVG45SFVielhxSERkU0RIb2VlL1dEeUw5SG05eEdncU8r?=
 =?utf-8?B?bEdKUTZPU1NsSjkxR0grWWNKak9tZnBqSjk4VzJib0xCcVRqSFhycFhPV1RV?=
 =?utf-8?B?Q3pvc3JGbUR5bXAyMkFyUjkvdzkxUUpHM0NvcXZkSzJhMU83QytuME9HMTIy?=
 =?utf-8?B?WkVETkdtTGJVNU5rWmRzT1o4ekVIVE5ISVBQcFBUd2l3bTY1Yjh0YmJjTmda?=
 =?utf-8?B?cUxiRGtRemE5QjRGRWduc1FBVmJ5MGtHL2EwcFNxcm1PTTRVTmcxVmZJRk1T?=
 =?utf-8?B?RmxOSFNXaS8vZy9KOVM2UjFLdnRCTXNvWTZaQmtjQkJXTnBEL3ltcmtzazBy?=
 =?utf-8?B?VGpTSGxoNW5ScGRzZ3JVL3BvdFdveXVNd2VxQWVCQ3FHVGhSVUJaLzRTL1hL?=
 =?utf-8?B?THI4Qk56WTVUK0E5bUlYUzNJNVNsUVVaR2RldlFRV29TMlBGWWFITnpMc0k0?=
 =?utf-8?B?TDc2bTNXd2svTXZIRVdpVE9FMGJqcVM5MGUvRFZDZ0FrazVXWnFYVnpCOUdx?=
 =?utf-8?B?M1RNOGVQMnA3N3VTSjFiYlNJT3hqY3cxZG1jeUEyNWhQOWdSdGFJWDdtVEhC?=
 =?utf-8?B?U1BUTDFsdHYxUkJqRFhOTTUwZmdJZDdIRUsxVm56TncybTQzSFpjcTlVYkgv?=
 =?utf-8?B?Sm1yd1BQbjU2djl2UHlldmZ3cnpPOGsyWEI2elZsL3NyaFJFaURCNDEyZ3RR?=
 =?utf-8?B?OXNheFBEOGh1Qk1JREFPOEhWL1ZxWS9GT0RnYVJ6eHN3Q1NoQlpQNEtqNms1?=
 =?utf-8?B?K2doRXJ4Q3Z3cm9RVlR3M1NsOFZJb2RnNzVzWVdYNlhkTlQxZEZEZmIzYzlV?=
 =?utf-8?B?RDgxZzB2UDVUajhmYVlmaHc0TXlWbWZyK0dEL1FGS3V2Qi8wNkVNQXlJUG82?=
 =?utf-8?B?U3J1RzFUWXJOMStrd1ovVjNjcGU2ekYxdEhIUzU3N2YvTnJZdndJOHREaU9j?=
 =?utf-8?B?RmRxZGtoVmFsQnZOWHRvQjBmNm11QUlKdGptaUF5QW5kbXFMOWprOXhHeTNL?=
 =?utf-8?B?RzI5bjFMTFNZcElKbzV4VFU2b0ZHaldqS3M4Z0hhbFpHMHp4TURoZHpBVXBy?=
 =?utf-8?B?ZkgrWEZ4NHRVeEZESkFtSGppMFFRZlJ4NndZS3FyaHExMThyaGNnQW4zM1NW?=
 =?utf-8?B?L3QrMGorcTF3N00zcWlJcS9peSthcjVIcnlFdENGRVRFaUc4NXplMlB1MFFp?=
 =?utf-8?B?ZElybnliTk9iWnVKZ2dhOWxlZmdVVDlKS3ljdXVTZmRtdWJuOVZhZVFUejM5?=
 =?utf-8?B?Q0tMYWtqZ2pMMm9PQVJsTm5QK1F0aE1yU0M1ZGs3ZjlPWmp0aTkzVFp3TXVT?=
 =?utf-8?B?SlFESFhYMkMxNTVGbUdwU2w0K01HVEhrM0ZmVHJuMGdVTVVEQVRNVDY0bWh0?=
 =?utf-8?B?K3REWTZyN1ZuL3hFV2tZeTM4MXE2RFpEb3UyN3RmME56UCtjYXI4aXlnM3dx?=
 =?utf-8?B?MWZBdXlDS3Y1WTgwaGsyRTRzVy91Y0NzS0wwb0k4U2szZVQyVmtZc3Nab2FQ?=
 =?utf-8?B?aWs2ZXo3Z1BoOGVublF2Mi85dzN2N1dKbUl2WkUxT09DU1FHaVJTbnBkUHJB?=
 =?utf-8?B?bklCUUlpRUJRbHJyY1lCZXJubDgva1Vzb0xFdEs2dE1hNXlTNzVMSzljamM2?=
 =?utf-8?B?RWlmRWNuRzVIOHlhT3dvR1ozakZQdGswQkVoV3VudFpxZFlNS3M1cytQcmZS?=
 =?utf-8?B?aldqK2JQQU5zajVkNitYQUJaQWsvTGcrK040NG1KNnE1SzZud0FxYmEvazgx?=
 =?utf-8?B?OUVVR2dlbyt1UVdEK2VEUnV3MUlMZWRHajJwc0M2M3F4VTE0TE9LN2UrNTN1?=
 =?utf-8?B?VTU4VFJ6Y3Q5TGM5VWNZWGlJTnBTYnRuMGdoVVNVVmxaN2I5MFFQRzE0c01k?=
 =?utf-8?B?U1RaRFRmYzYxOEkwejdKdW5FdlNGR09zQVhBTHdGYTg4ekw3THg2YkhncXVV?=
 =?utf-8?B?LzFveWt3N2xkeXp2UUU2TWhUY2V4ajNEaXVuZlI3dVhvdzhRcmZoSmN2VzJI?=
 =?utf-8?B?R3ZGRlk4T1U0cUVlL21Qb05Nc0liN3lHNmhIamxwR24vUCs0VE4vekFGNi9v?=
 =?utf-8?B?a3FqVWdOYVFabFF4Tk1yRXJlVkFIWktCM2c0MmRzUDMvQzZBNUEyNUVhTm5r?=
 =?utf-8?B?MzZPVEdXczJzMTRwNXlCanBYcDZzOG5xZEpVeTdOUGZJUnliSDRGUFdRVFlU?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2C440EAE5A3644F93CA09F6581F5C22@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c5zYEe2TOPyPIAo8llZIWrdbBE3tsuI8m3BljON0vz+XRBwwEJWt0xS9FTzDFcXOIJ3ctBQ8pvcKWy1pTgGDN35n+/MvSlVx3IFvtdZl8Zwkqm0B1XUA73+4xEoV0av1HPTM/sh7+Nfb/NUrupTExGIkfqD3Ti45qGqhHVLXpsGlWn0QUAHaWyTKpL6GQXmN4x42VoTCC/7dZtDvn29jjmNIcOF7p4RAVCgfqUbjAVrTPLohw/mzGEd6iQ2+TFgsyIYWSfon3E6L7KpJ/am1NEpew0dZ4A0TpqwSKqjrl5fFkdMLZmfHFcKvWus5w+Q+t7Xi6UX2WMF9PS7yKu9wK44GatqyY77vZ15tl4M88KfSxnVVWdLas/GPECwUmYayl+gllUp9v6/pO4tyA8hlfiJSN3kglCffcGfyxZd7GPyRarO66uEYzullQkzBq02EaGBYoDIRqBUrWhq4CJg11OPwxYbwiYG3Y/lunTErPZnm+AKwgG7j8jPxjbozA+7KR9inhThGiUysGPb95LzZRj8SknwdyzmneeYKwY5QupooG3e9M78OnOwxWJNFlqBld3EBo7ZfbcOTa0DDLN81G0kZBK+eerpHtNJTQvUQrqs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b09ad9-4428-408a-66f1-08dcf1cfbc31
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 12:56:09.7013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODOy+WP5ff6zyE9AjsA9F3uSt4OorMATO9BeaxQAJguLu0JyIrCW9Y+uICuxm/KCvT5FZvkrJheiO12MUrNNUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_10,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210092
X-Proofpoint-GUID: t79teaPW48sEqycIbZWpCjDGuSa5tjzC
X-Proofpoint-ORIG-GUID: t79teaPW48sEqycIbZWpCjDGuSa5tjzC

SGVsbG8gQ2VkcmljIC0NCg0KPiBPbiBPY3QgMjEsIDIwMjQsIGF0IDE6MTnigK9BTSwgQ2Vkcmlj
IEJsYW5jaGVyIDxjZWRyaWMuYmxhbmNoZXJAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEdvb2Qg
bW9ybmluZyENCj4gDQo+IFdoZXJlIGRvZXMgdGhlIGV4cG9ydHMoNSkgbWFuIHBhZ2UgaW4gTGlu
dXggY29tZSBmcm9tPw0KDQpodHRwOi8vZ2l0LmxpbnV4LW5mcy5vcmcvP3A9c3RldmVkL25mcy11
dGlscy5naXQ7YT1zdW1tYXJ5DQoNCg0KPiBJJ2QgbGlrZSB0byBnZXQgc29tZSBpdGVtcyBhZGRl
ZCBmb3IgdGhlIHJlZmVyPSBvcHRpb246DQo+IC0gSVB2NCBzeW50YXggKHcgYW5kIHcvbyBwb3J0
cykNCj4gLSBJUHY2IHN5bnRheCAodyBhbmQgdy9vIHBvcnRzKQ0KDQpJSVJDICJyZWZlcj0gSVB2
NiBhZGRyZXNzIiBkb2VzIG5vdCB3b3JrIHdpdGggYW4gYWx0ZXJuYXRlDQpwb3J0LiBIYXZlIHlv
dSBmb3VuZCB0aGF0IGl0IGRvZXM/DQoNCg0KPiAtIGhvc3RuYW1lIHN5bnRheCAodyBhbmQgdy9v
IHBvcnRzKQ0KPiAtIGEgbm90ZSB0aGF0IGhvc3RuYW1lcyB1c2VkIGJ5IGEgcmVmZXI9IG11c3Qg
ZXhpc3QgYm90aCBvbiB0aGUgY2xpZW50DQo+IGFuZCBzZXJ2ZXINCj4gLSBSZWNvbW1lbmRhdGlv
biB0byB1c2UgbmZzcmVmKDUpLCBpZiBhdmFpbGFibGUNCg0KKzEgQWxsIG9mIHRoZSBhYm92ZSBz
ZWVtcyB0byBtZSBzZW5zaWJsZSB0byBkb2N1bWVudC4NCg0KDQo+IC0gYSBub3RlIHRoYXQgdGhl
IGxvY2FsIE5GU3Y0IHNlcnZlciBtb3N0IGhhdmUgYW4gZW1wdHkgZGlyIGZvciBlYWNoIHJlZmVy
cmFsDQoNCk15IHJlY29sbGVjdGlvbiBpcyB0aGF0IHRoZSBkaXJlY3RvcnkgY29udGVudHMgYXJl
IG9ic2N1cmVkDQpieSB0aGUgcmVmZXJyYWwsIGJ1dCB0aGUgZGlyZWN0b3J5IGRvZXNuJ3QgaGF2
ZSB0byBiZSBlbXB0eS4NClRoaXMgYmVoYXZpb3IgbWFrZXMgaXQgcG9zc2libGUgdG8gc2ltcGx5
ICJzd2l0Y2ggb24iIG9yDQoic3dpdGNoIG9mZiIgdGhlIHJlZmVycmFsIHdpdGhvdXQgaGF2aW5n
IHRvIG1vdmUgdGhlDQpkaXJlY3RvcnkncyBmaWxlIGRhdGEuDQoNCkNhbiB5b3UgZXhwbGFpbiB0
aGlzIGEgbGl0dGxlIG1vcmU/DQoNCg0KPiAtIGF1dG9mcyBpbmNvbXBhdGliaWxpdHksIGlmIHlv
dSB1c2UgYSByZWZlcnJhbCwgYW5kIGF1dG9mcyBlbmNvdW50ZXJzDQo+IGl0LCB5b3UgZ2V0IGEg
ZGVhZGxvY2sNCg0KVGhpcyBvbmUgc2VlbXMgbGlrZSBhIGJ1ZyB0aGF0IHNob3VsZCBiZSBmaXhl
ZCBpbnN0ZWFkIG9mDQpkb2N1bWVudGVkLiBJZiB5b3UgaGF2ZSBhIHJlcHJvZHVjZXIsIHBsZWFz
ZSBwb3N0IGl0IHRvIHRoaXMNCmxpc3QsIGNjOiBzdGV2ZWRAcmVkaGF0LmNvbSA8bWFpbHRvOnN0
ZXZlZEByZWRoYXQuY29tPiwgcmF2ZW5AdGhlbWF3Lm5ldCA8bWFpbHRvOnJhdmVuQHRoZW1hdy5u
ZXQ+IC4NCg0KKEkgZG9uJ3Qgd2FudCB0byBhcmd1ZSBhYm91dCB3aGVyZSB0byBmaWxlIGEgYnVn
IGFnYWluIDstKQ0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

