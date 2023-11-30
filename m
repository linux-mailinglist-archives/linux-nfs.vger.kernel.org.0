Return-Path: <linux-nfs+bounces-206-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577BE7FF14D
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 15:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37887B20AD5
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 14:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B843248CC8;
	Thu, 30 Nov 2023 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m6wqtq4A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OcNlec+Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EF2172D
	for <linux-nfs@vger.kernel.org>; Thu, 30 Nov 2023 06:08:10 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUE42m6019361;
	Thu, 30 Nov 2023 14:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=rNpX7YiL7xa6NPBvF4FXlatf/ADVMAOrJMYR+6/09kA=;
 b=m6wqtq4AoUU1udQtRzlCM8496hSfGtOUmuK25EHUzlEIWU7Y/BDUgkYZUM525O1LMbCM
 rWCZKjTclDJvWDBmW2HKl4AFqXI09FIiYxI/VRkVSlgFaq4/KtrSAGOoGUwtI10RFLf3
 d2KeK9Mxa9soTibAX6udK1DketOe0GZA4FuUsLOTtjOrM7vbYnj0hTdRYFeVjqrvKVzO
 KM1WIYGwQQP1BTYrcZrgF6UwFRwMTJyNrJUs7JtLkiYTPPYWCyppGUgKpQOg0gYM+mfv
 pKTA+W3Uy1B6NxSiLwmNHQoDwMOvT41bkxgr682sYkf+2W60MnO35VXvfootIfbowkG8 dA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3upu5jg4c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 14:08:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDd56Y027029;
	Thu, 30 Nov 2023 14:08:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cgmsp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 14:08:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLLvyjRo+ZyD4BSKYeZYQcqLxWJeVfStT4k95haP2zRAeqraOcGUnDUDl9J0RI65QyW67pG7/585H7MrP0iDeIWcmpaYmXgc+gw/X4bfYquaGQgRoCfpyZpSwSvW0YwzC9cufTQJVSuNmTfrn61BxnLx+teTUrOWDITGEHZvWJxYDG4Q4sbW9YjcDbC76WppZPJJuw9vjqFHqWgLo5ZpXH0a6EyXaX3Qgbe6XSWQ13UEePIGA+UVyVxaEbHGGLs2VFnVcQDT2jScq6UPABEpDdBYRYitVp7YHbUVg9324+mdcTUXFM6/yDKNMUvGzqj0RTtYBJ+rhgZQ/cbEza6DKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNpX7YiL7xa6NPBvF4FXlatf/ADVMAOrJMYR+6/09kA=;
 b=OTdCEX6ZVHxZUwqgKRaGtjjhY1LLcKawrSFLpX0FaY/Sa+sD0yb2pUAz2UuSExMF4enPcX4YD3wlnE7x1Gv3mHlObl9L/hUNt2CKs16OfCG01msBviGuypCu0ye9nBmOe4wIzqpI/lmufnw/07mtdG2KqlIgsG3NfDWh4O1QHVK0oLJIsVSdXcMe31VKFirTgroL0koT8Uu3LinBDim2h+EmEH6uiz50ovDcQhgLuswURSqTG8I/+hdwxgcnjsCnQMm0p3+q9a1seBA9E2AOyBl0e1lK20wCScwNv1v/w4eIC99f+afIFwHO5AxpFPWdSM3oGzF2OaQlcihRt4XCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNpX7YiL7xa6NPBvF4FXlatf/ADVMAOrJMYR+6/09kA=;
 b=OcNlec+QThCaOsljPtQRsdVsoOD9aecqwEOwcdLBGDpOf26WRh0wwC7DVPUHDQDtZpRTkrJpyogDEgFq/WhW2Qy0VO5JKJFI+n1yqPdVgOo0hFgM6ybA5//PdyibW3kexK7MPPsuwZak9M69Uiuy80nnJMxiRLPlC5DQsDDsqzw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5097.namprd10.prod.outlook.com (2603:10b6:610:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 14:08:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 14:08:04 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: "Sukruth Sridharan (he/him)" <susridharan@purestorage.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Hung task panic as part of NFS RDMA Disconnect due to possible
 bug on 6.2.0-34-generic client
Thread-Topic: Hung task panic as part of NFS RDMA Disconnect due to possible
 bug on 6.2.0-34-generic client
Thread-Index: AQHaI01aHpLGkBRLw0W/q9ngFXkl47CS5p4A
Date: Thu, 30 Nov 2023 14:08:04 +0000
Message-ID: <4D47796B-4669-4177-947D-3080AA0AEA78@oracle.com>
References: 
 <CAMyEAb9XbL55taNXD_MrTxJz62s6ByDWiK8m1Nxj1_G3pg-M6A@mail.gmail.com>
In-Reply-To: 
 <CAMyEAb9XbL55taNXD_MrTxJz62s6ByDWiK8m1Nxj1_G3pg-M6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5097:EE_
x-ms-office365-filtering-correlation-id: dde3e7cf-0bca-4a94-2b03-08dbf1adc585
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 XQw8fpBPFHprTOCz7fp+xUrooKgeTp6MS4K1ldmmaL1MKTUxlz0Zb/p65LctXcFu6pFrs1OnfWMhInY2DMY0eoe19QHnchJRC0FEcp8FpJDfr4GlJrSarcAJHSklEMaTObpvoCG+0jYCL2zDEgXNdKJ7MnwWoC5EGImgy1gxR9bEoCRm8qdLBw/1uUgEff8o1QL1dXYK+SfAukpA9tjSNbXbC7RX7zThJMqbgyfKlvI17FvwC0Ir5d5K/xkXhucrIQ5vgCKq2FEqxKt7cS2v1JDxrtnToWi0pvljV/Tczwx51HHKgSF+U+0WReIkJILc1NXFITumTEOPXcp01Og/CrxA//wrboc3pgkjRAyxRbZy4B+U9qWO0zZ1LuplIGGIJBzn/Inn758Wy4cJoYbq4l3Ro9sHsDQS5z1a/Hud5RQZ8ni5ySQpCDua0yJVkK/5FxknK+yWIGgXanfWRaOvSmI+SPhZW08fOqMFKE14opnlyhtB7wYixUodesqYsi0azP1IsYUIeqHATNFh0nxdIe0+vYxNJ6ZmFb5pMIAZhAPV5NEq7Rs35I3ExZYpw3Y+vjpmreoPh3wVdJRsYlR7WsHgjtzNAJ6cEOquk45emrWkWiyqPG+qdjGv+69pEbUqgWSzO1BHbnOMxFtvqOlOuhiJSao5WU17TadMmX+vTF4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(84040400005)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(2906002)(41300700001)(86362001)(76116006)(36756003)(66946007)(33656002)(91956017)(122000001)(6512007)(66556008)(26005)(2616005)(478600001)(71200400001)(6506007)(53546011)(6486002)(83380400001)(4326008)(5660300002)(66446008)(316002)(66476007)(38070700009)(64756008)(6916009)(8936002)(8676002)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K3B6bDFPMDlROVNBMlF6RW1KcFBPaXZoWDB6bWNPeHRrSHJmeGNZZ3VpR1lR?=
 =?utf-8?B?UGNyaVI3TEtFa3V0SlNpVi9vR2RDS0R0RVNkVzZoNUNrdmhkV2k4MXR5QnIr?=
 =?utf-8?B?L05ZdHY4TkVKbXB4UHVSeWx6UUxuQnZ2YXdRL0VsQXJCRmsxNEdSN0pPVTJp?=
 =?utf-8?B?YXRHbHhGb0twU3NIcEpyL1B2N0NYMlFiNUtwV0NIMkF3TURORDBROEV3YmRh?=
 =?utf-8?B?d1k5d3BoRUMrUkdHWjVIams2WTJPQlVWRXFVTVNwNFRRbVRDYVZsMVJqZHpW?=
 =?utf-8?B?SGhJd05WanQxazNNNHgwb0M5aU5ZeTZtVUNkQU92NTk2QStjeWxRNjE1Rzdv?=
 =?utf-8?B?WGdVQjBqa3lpZ2UyV2FGTUYwbHduWWdhelRFSmhUdVcwaWg5VEd1TEQzYzVs?=
 =?utf-8?B?UnAwYkkxQWk5K1ZQMHh0TkJ4cnYyR0ovcE1ZMllyZTVDZGhNME50K0pybmlM?=
 =?utf-8?B?SmN6eXdPYXdUOGVleTRFTDZ2VWJ5ekc1LzZGOVZWWFgwcGRuRkRaUmlWeGh2?=
 =?utf-8?B?MlNpRVUxK2tBWmI2SDYzRHhSUUczWElJZkVXNjVFTjBuZjJUNHFxZXZrbW1q?=
 =?utf-8?B?QWszekp1bU92WStGSDZBazI4VC9tYXEyUTY2aHFsNE9rZWFXQXJnTk9xMzFk?=
 =?utf-8?B?cS9zSjhuQldKM0s3ZWxxRUNVck16dGN0b1JlRllUNWI5U2o1c0FaMVp0ek9j?=
 =?utf-8?B?ano5SUw3L2FtMU5pWkVCbEtCcUppdXJNYUZ5RkVvVFNyV2NGdGp4VWZObVNS?=
 =?utf-8?B?VStaUFdUY2lNOWVyVXdMYjRNMld5WUV1djZlVjZ1NFZhdnZ0eXpKV3dEaWEx?=
 =?utf-8?B?ZGJpeGZZRjZZNUsrdkRtbVN1WXpGeUF1UHhqTEUwQTFESGFFeHlIZ0pWeFNF?=
 =?utf-8?B?eENVWkd1SWk4aE01TEVOaXBtMy91QVVsVDJzek16b1RTZGVrN0lBMHBwVWtu?=
 =?utf-8?B?MDlmUlVVdUlsMDVXdHc5YmhrV3Fodi9nMnpLbFRZR1k5Zy9GK2RQUXozY3lB?=
 =?utf-8?B?UzVnNEx2dWM4bkkwZjlpNCtnOUZyaFBhbkZYWVliVnY4a3lkQVBHdDN6ZnY0?=
 =?utf-8?B?TklJMThUd0hTZTVGNitoR2FydFVtYm5FTWhBbjc1QVpNQ3JZdnkxWFBLdTBw?=
 =?utf-8?B?RnJINFlQQzF0bHl0VDhXQnJveEh3KzJpSWp6dXJZcWtzRmdYTm9ib2VyMVRL?=
 =?utf-8?B?eXRPemxXNFNVcVh4MWFPRVZoMnZ0RHBtMGc0RnRPUzV2dDZpSEt6RkVqWXAz?=
 =?utf-8?B?Q1RBZnBkUVNwSUEwK3hBMGRqWDdtdlRZby85eDJnd3BHTXN1bEhNVW91UDR4?=
 =?utf-8?B?MHpvN2R2Z1JyOHhnL1p1QndiSjFsRmovOWF6YTgzMnp6NGpXWVFKVEEvWGxR?=
 =?utf-8?B?M2F1ZlRKdlRVV25LVmpZVUY2R3ZHT1V2L1o5b05oM2pUZU4xR2twRjlEYVY3?=
 =?utf-8?B?akg2bVVQaHp0WlltZkVCYmFidFRrNzQ5bHlMRjdDV2lYVWhWeDN6WFJ6UGFE?=
 =?utf-8?B?R0RVRVJIMXNWMXZ3bytoMlhVWWF0bnYxRmFxeFJscE5uS0FFeWRhc01oTytW?=
 =?utf-8?B?dHcyc3lQZTRNS0lSMWc2QjJWQjE3VVMrVnNQY1NHNGtNUHdjU3hEVDVtSUNq?=
 =?utf-8?B?ai92MTI1M3BEWFRlMTM5eFlRMUhoNjdZdEpMek00ZWxucFU2WTlKQTNwUHdJ?=
 =?utf-8?B?b21meGFidzV5cDQ3cGFCNjNmMFljWndmdTRVM3pYcGtNRTI0MEFEWS9nQ0hm?=
 =?utf-8?B?bDdTdm5qeFJsbVVYRDNKZWxCTFBxMzl6dlN1Q3lxczNXT3JIbW0rNFdFeHR1?=
 =?utf-8?B?VFkyN210K1dMS2lwY0pWeUNPeWxWd1hsTDFLQUsxNHlWWGMzcGp2OUQ3K2tx?=
 =?utf-8?B?L1l2WkpwTkJJVGc1bmV2WTJtTSt1QVZnSjJqUklBMW4xZk5ldlVTSFBLdURG?=
 =?utf-8?B?eVRXZDk4VXpWS1JER0MvbjJ3Y0RMTlVJRWdLMFQ4b3laWEF3RVhnWWVhemdQ?=
 =?utf-8?B?UlU5M1JoR0J3RlBOY290OFRFc0QzaUtML0JkZVNoSWZuTktFRDZIRlBLZ0I5?=
 =?utf-8?B?elZ6MjdIdFBORHV1K3A5RmR1ZGZvV2JyQlhMWnNtY1ZDMy9BcDRNQjk0Vkl0?=
 =?utf-8?B?b2I2cmFUWU1YQytyNTk0Rko3YWtVNnJIZmZNWlVtaG9wUHRkQitBV1BaTzhL?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F68FF80C83837447A4DBAE2D73219057@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	f2VGjmT+9SkvvvZ/xHreSS39FtYD4+agAlQWnRuAMUWOb8tgiYRZBq25IQVgtgH2lZ/hs+iTKIH+1qBWmUjUTMnVS0gi2wE1tlc5e5nNvVxQSHx8wU5pzpG3TS8IEmyn1ncq5TXWp+e46CxHKXcPEAReBElkdI8hU5HW8DqpJxiTQvO5b5csJ2N827JWpeCHZ4QfeYeMy9AEBk5QpwEsRROOwvQkvrrx8nCNPS3pdiKcuW35eDY0ZjIWN0h8fpARPsuggwoWkzD+tVJCqSOyMTMwNS95ZO0ZYkPj6rSRGBRDkC7I2LkZjnHcVA8JxZQucReorIiVNJWIdv0NmAry0omOH1IELozgetsvHCmEz025OjI6KrTOXDotLujQNs36hLLPzdzb0SRi5UhiMOt62tXMWcZuhEo3CyrPzqAJ0lXXCOJCHdHofB/sJVfGsiva7XB5rNqPVDYW8S74RUfk+j5oZIrRO/7DesJT0NF5uK6ZkNWaQJN8jaRLgYYp5Jfup5W8WEcIxDqdN7Ha+BBBDArPqq3IeUvB4C6uW9t9JUhRs//sbAnQgEJUyExiSJitIVBLIfyJOqGcYVe322SHuffkWD5cp6qp0RCrrHMfR9SJ84JTcWTuGvAiCPGq0BqRrw7mit76XFFhKGsGDmyvqgBc0W5qNa8s6cGLJMtwfUaIzOaQwvK+fkMi8De1cjV3ITsH7jPEjcm+b8JO5/nMZ0M/dNsq5h9BAdKK/Ztyl3svK4rsZvtY/yyy8UMyH3ahY00j1XoIytnbo4/NOSKQAi8tZwqhJTyBz2WkgPs+u2FVXn5upmoKtSwKaX9WvIAS
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde3e7cf-0bca-4a94-2b03-08dbf1adc585
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 14:08:04.8514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYS4wVhgyRP37O3qzqGOS+XGmdrkq7Rqp4ug9DqF7nHEdjg0ZbIw1WKTDPTYeEio4wQHkRX36q7ImsJsoh39yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300103
X-Proofpoint-ORIG-GUID: _VbsW6idVX6hioCv0tvknZSESD6Aas43
X-Proofpoint-GUID: _VbsW6idVX6hioCv0tvknZSESD6Aas43

DQoNCj4gT24gTm92IDMwLCAyMDIzLCBhdCAxMjoyMuKAr0FNLCBTdWtydXRoIFNyaWRoYXJhbiAo
aGUvaGltKSA8c3VzcmlkaGFyYW5AcHVyZXN0b3JhZ2UuY29tPiB3cm90ZToNCj4gDQo+IEkgbm90
aWNlIHRoZSBmb2xsb3dpbmcgaHVuZyB0YXNrIHBhbmljIG9uIDYuMi4wLTM0IGtlcm5lbCBkdXJp
bmcgUkRNQSBkaXNjb25uZWN0DQo+IA0KPiBbV2VkIE5vdiAgMSAwODowMzo1NCAyMDIzXSBJTkZP
OiB0YXNrIGt3b3JrZXIvdTE2OjU6MjI3NDY0NiBibG9ja2VkDQo+IGZvciBtb3JlIHRoYW4gMTIw
IHNlY29uZHMuDQo+IFtXZWQgTm92ICAxIDA4OjAzOjU1IDIwMjNdICAgICAgIFRhaW50ZWQ6IEcg
ICAgICAgIFcgIE9FDQo+IDYuMi4wLTM0LWdlbmVyaWMgIzM0LVVidW50dQ0KPiBbV2VkIE5vdiAg
MSAwODowMzo1NSAyMDIzXSAiZWNobyAwID4NCj4gL3Byb2Mvc3lzL2tlcm5lbC9odW5nX3Rhc2tf
dGltZW91dF9zZWNzIiBkaXNhYmxlcyB0aGlzIG1lc3NhZ2UuDQo+IFtXZWQgTm92ICAxIDA4OjAz
OjU1IDIwMjNdIHRhc2s6a3dvcmtlci91MTY6NSAgIHN0YXRlOkQgc3RhY2s6MA0KPiBwaWQ6MjI3
NDY0NiBwcGlkOjIgICAgICBmbGFnczoweDAwMDA0MDAwDQo+IFtXZWQgTm92ICAxIDA4OjAzOjU1
IDIwMjNdIFdvcmtxdWV1ZTogeHBydGlvZCB4cHJ0X2F1dG9jbG9zZSBbc3VucnBjXQ0KPiBbV2Vk
IE5vdiAgMSAwODowMzo1NSAyMDIzXSBDYWxsIFRyYWNlOg0KPiBbV2VkIE5vdiAgMSAwODowMzo1
NSAyMDIzXSAgPFRBU0s+DQo+IFtXZWQgTm92ICAxIDA4OjAzOjU1IDIwMjNdICBfX3NjaGVkdWxl
KzB4MmFhLzB4NjEwDQo+IFtXZWQgTm92ICAxIDA4OjAzOjU1IDIwMjNdICBzY2hlZHVsZSsweDYz
LzB4MTEwDQo+IFtXZWQgTm92ICAxIDA4OjAzOjU1IDIwMjNdICBzY2hlZHVsZV90aW1lb3V0KzB4
MTU3LzB4MTcwDQo+IFtXZWQgTm92ICAxIDA4OjAzOjU1IDIwMjNdICB3YWl0X2Zvcl9jb21wbGV0
aW9uKzB4ODgvMHgxNTANCj4gW1dlZCBOb3YgIDEgMDg6MDM6NTUgMjAyM10gIHJwY3JkbWFfeHBy
dF9kaXNjb25uZWN0KzB4MzNmLzB4MzUwIFtycGNyZG1hXQ0KPiBbV2VkIE5vdiAgMSAwODowMzo1
NSAyMDIzXSAgeHBydF9yZG1hX2Nsb3NlKzB4MTIvMHg0MCBbcnBjcmRtYV0NCj4gW1dlZCBOb3Yg
IDEgMDg6MDM6NTUgMjAyM10gIHhwcnRfYXV0b2Nsb3NlKzB4NWMvMHgxMjAgW3N1bnJwY10NCj4g
W1dlZCBOb3YgIDEgMDg6MDM6NTUgMjAyM10gIHByb2Nlc3Nfb25lX3dvcmsrMHgyMjUvMHg0MzAN
Cj4gW1dlZCBOb3YgIDEgMDg6MDM6NTUgMjAyM10gIHdvcmtlcl90aHJlYWQrMHg1MC8weDNlMA0K
PiBbV2VkIE5vdiAgMSAwODowMzo1NSAyMDIzXSAgPyBfX3BmeF93b3JrZXJfdGhyZWFkKzB4MTAv
MHgxMA0KPiBbV2VkIE5vdiAgMSAwODowMzo1NSAyMDIzXSAga3RocmVhZCsweGU5LzB4MTEwDQo+
IFtXZWQgTm92ICAxIDA4OjAzOjU1IDIwMjNdICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+
IFtXZWQgTm92ICAxIDA4OjAzOjU1IDIwMjNdICByZXRfZnJvbV9mb3JrKzB4MmMvMHg1MA0KPiBb
V2VkIE5vdiAgMSAwODowMzo1NSAyMDIzXSAgPC9UQVNLPg0KDQpIaSBTdWtydXRoIC0NCg0KVGhp
cyBpc24ndCBhIHBhbmljLCBmb3J0dW5hdGVseS4gSXQncyBzaW1wbHkgYSByZXBvcnQgdGhhdA0K
dGhlIHRhc2sgaXMgbm90IG1ha2luZyBwcm9ncmVzcy4gTW9yZSBiZWxvdy4uLg0KDQoNCj4gVGhl
IGZsb3cgd2hpY2ggaW5kdWNlZCB0aGUgYnVnIGlzIGFzIGZvbGxvd3M6DQo+IDEuIENsaWVudCBp
bml0aWF0ZXMgY29ubmVjdGlvbg0KPiAyLiBTZXJ2ZXIgaGFuZHMgb2ZmIHRoZSByZXNwb25zZSB0
byB0aGUgZmlyc3QgUlBDIG9uIHRoZSBjb25uZWN0aW9uIHRvDQo+IHRoZSBOSUMgKE1lbGxhbm94
IENvbm5lY3RYLTUpDQo+IDMuIE5JQyB0cmllcyB0byBzZW5kIHRoZSByZXNwb25zZSBhcm91bmQg
NiB0aW1lcyBhbmQgZmFpbHMgdGhlIHJlc3BvbnNlIHdpdGggUk5SDQo+IDQuIENsaWVudCBpc3N1
ZXMgZGlzY29ubmVjdCAocG9zc2libHkgYmVjYXVzZSBpdCBkaWRuJ3QgcmVjZWl2ZSBhIHJlc3Bv
bnNlKQ0KPiA1LiBTZXJ2ZXIgY2xlYW5zIHVwIHRoZSBjb25uZWN0aW9uIHN0YXRlDQo+IDYuIENs
aWVudCBydW5zIGludG8gdGhlIGFib3ZlIHBhbmljIGFzIHBhcnQgb2YgZGlzY29ubmVjdCB3aGls
ZSBkcmFpbmluZyB0aGUgSU9zDQo+IA0KPiBJdCBsb29rcyBsaWtlIHJlX3JlY2VpdmluZyBpcyBz
ZXQgb25seSBpbiBycGNyZG1hX3Bvc3RfcmVjdnMsIGFuZCB0aGUNCj4gcmVhc29uIHdoeSBpdCB3
b3VsZG4ndCBiZSByZXNldCBpcyBpZiBtZW1vcnktcmVnaW9uIGFsbG9jYXRpb24gY29kZQ0KPiBm
YWlscy4NCj4gVGhhdCBpcyBwb3NzaWJsZSBpZiBkaXNjb25uZWN0IG9uIHRoZSBjbGllbnQgc29t
ZWhvdyBibG9ja3MgYWxsb2NhdGlvbi4NCj4gDQo+IHZvaWQgcnBjcmRtYV9wb3N0X3JlY3ZzKHN0
cnVjdCBycGNyZG1hX3hwcnQgKnJfeHBydCwgaW50IG5lZWRlZCwgYm9vbCB0ZW1wKQ0KPiB7DQo+
ICAgICAgICAvLyAuLi4gKHNvbWUgaW5pdGlhbGl6YXRpb24gY29kZSkNCj4gDQo+ICAgIGlmIChh
dG9taWNfaW5jX3JldHVybigmZXAtPnJlX3JlY2VpdmluZykgPiAxKQ0KPiAgICAgICAgZ290byBv
dXQ7DQo+IA0KPiAgICAgICAgLy8gLi4uIChzb21lIGFsbG9jYXRpb24gY29kZSkNCj4gDQo+ICAg
IGlmICghd3IpIC8vIDw8PDw8PDw8PDw8PDw8PDw8PCBQUk9CTEVNIEhFUkUgPj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pg0KPiAgICAgICAgZ290byBvdXQ7DQo+IA0KPiAgICAgICAgLy8gLi4uIChwb3N0IHJl
Y3YgY29kZSwgYW5kIHNvbWUgZXJyb3IgaGFuZGxpbmcpDQo+IA0KPiAgICBpZiAoYXRvbWljX2Rl
Y19yZXR1cm4oJmVwLT5yZV9yZWNlaXZpbmcpID4gMCkNCj4gICAgICAgIGNvbXBsZXRlKCZlcC0+
cmVfZG9uZSk7DQo+IA0KPiBvdXQ6DQo+ICAgIHRyYWNlX3hwcnRyZG1hX3Bvc3RfcmVjdnMocl94
cHJ0LCBjb3VudCk7DQo+ICAgIGVwLT5yZV9yZWNlaXZlX2NvdW50ICs9IGNvdW50Ow0KPiAgICBy
ZXR1cm47DQo+IH0NCj4gDQo+IHN0YXRpYyB2b2lkIHJwY3JkbWFfeHBydF9kcmFpbihzdHJ1Y3Qg
cnBjcmRtYV94cHJ0ICpyX3hwcnQpDQo+IHsNCj4gICAgc3RydWN0IHJwY3JkbWFfZXAgKmVwID0g
cl94cHJ0LT5yeF9lcDsNCj4gICAgc3RydWN0IHJkbWFfY21faWQgKmlkID0gZXAtPnJlX2lkOw0K
PiANCj4gICAgLyogV2FpdCBmb3IgcnBjcmRtYV9wb3N0X3JlY3ZzKCkgdG8gbGVhdmUgaXRzIGNy
aXRpY2FsDQo+ICAgICAqIHNlY3Rpb24uDQo+ICAgICAqLw0KPiAgICBpZiAoYXRvbWljX2luY19y
ZXR1cm4oJmVwLT5yZV9yZWNlaXZpbmcpID4gMSkgLy8NCj4gPDw8PDw8PDw8PDw8PDw8PDw8PCBU
aGlzIGlzIG5vdCByZXNldCwgc28gd2FpdCBnZXRzIHN0dWNrDQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4g
DQo+ICAgICAgICB3YWl0X2Zvcl9jb21wbGV0aW9uKCZlcC0+cmVfZG9uZSk7DQo+IA0KPiAgICAv
KiBGbHVzaCBSZWNlaXZlcywgdGhlbiB3YWl0IGZvciBkZWZlcnJlZCBSZXBseSB3b3JrDQo+ICAg
ICAqIHRvIGNvbXBsZXRlLg0KPiAgICAgKi8NCj4gICAgaWJfZHJhaW5fcnEoaWQtPnFwKTsNCj4g
DQo+ICAgIC8qIERlZmVycmVkIFJlcGx5IHByb2Nlc3NpbmcgbWlnaHQgaGF2ZSBzY2hlZHVsZWQN
Cj4gICAgICogbG9jYWwgaW52YWxpZGF0aW9ucy4NCj4gICAgICovDQo+ICAgIGliX2RyYWluX3Nx
KGlkLT5xcCk7DQo+IA0KPiAgICBycGNyZG1hX2VwX3B1dChlcCk7DQo+IH0NCj4gDQo+IENhbiB5
b3UgaGVscCBjb25jbHVkZSBpZiB0aGUgYWJvdmUgdGhlb3J5IGFyb3VuZCB0aGUgYnVnIGJlaW5n
IGluIHRoZQ0KPiBjbGllbnQgY29kZSBpcyByaWdodD8gSWYgbm90LCBjYW4geW91IGhlbHAgd2l0
aCBzdGVwcy9kYXRhIHBvaW50cw0KPiByZXF1aXJlZCB0byBkZWJ1ZyB0aGlzIGZ1cnRoZXI/DQoN
ClRyeSBhcHBseWluZzoNCg0KODk1Y2VkYzE3OTE5ICgieHBydHJkbWE6IFJlbWFwIFJlY2VpdmUg
YnVmZmVycyBhZnRlciBhIHJlY29ubmVjdCIpDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

