Return-Path: <linux-nfs+bounces-8114-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 319ED9D2793
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 15:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0213B2FFA8
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07161CDFD1;
	Tue, 19 Nov 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IvoOxMjI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jaucl1Bd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F81CDA0E
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024299; cv=fail; b=KoG4LC+HC1MA9EuRIeUSwUblhBsZWuYST0hsP2t30fenwskdUPlqy0WF1nk0uUkUc4YlCxFF3yCdkfBgoTAZuctKmMFflCC/oJtX53CWqrHwd4xY9Axr30frfkz/l38lodnfGtp6lLMYVC1mszEcAC2rdqnoPBxmlgEmrqqXFKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024299; c=relaxed/simple;
	bh=ISfDjmUS97dDrV2NpRT2wKOS61QgkZkdaJ82Q8WEy9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h/bdFjG2BFwoRY+0xloRB38goXIZMEwr8S03yEQzKO6UoLW7kVbVBUtSOdv8/cSGX3fUxZynv6nzEKHQzTsdKVAvVzL4j0Eg7a+NuFkIPgkEOPHSCA53Fd8SK61rtzYVXuv+pE3cRu7aeXkzcIdHhjAXcnaDHpzsPCekYXQnimo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IvoOxMjI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jaucl1Bd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJDhNdv009211;
	Tue, 19 Nov 2024 13:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ISfDjmUS97dDrV2NpRT2wKOS61QgkZkdaJ82Q8WEy9M=; b=
	IvoOxMjI6VR0ZGWURH6oEomvJ56VUcYkB8+5wq4dLXmafW0aZgsyh5/j6FdVVIAu
	7DD881Z0zwkI20/imtRfuSJa01zB6LdbmjzNtB2OndlhfTtUKOpxeJ5oQV9uxT87
	cc6QOvsB2zW4VRifD0RUbLSHs5iT9GuWfn1oKHc/YciYK+g0J2IYOIgQlqR8r7yo
	3kLpwYwGtdE4+a5ruC54t4K4kMu04IYnZnfn6SpFVjzNE2E31FWhvritAc9TK0vW
	jUKs6e41OxUojCs/IM1cSNILxjBmxuqfSw/VoTQq2RpniUxBwBz3Yo9mp/1X1xss
	TcGT6lytmpp2qrnmd/Z6GA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98mvhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 13:51:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJCU5Ci008132;
	Tue, 19 Nov 2024 13:51:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8hxms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 13:51:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYVRFk6HVxGpt33kOKIm9WL6QjN3AHxerhcpv4r2AI9IT7dXBkb003AzofK5IsOJH8SABGhj+VAAP0sXGIUHkUWN0cTr6oTH0YxnGLOV5ibGbds6icKX/8eueiTsJfE/hDv5MIzQPhsZDDKeJDALvxjOKLBseoVupbsmuGF07TJAJRPeGvF1Hq93Hl4h6o3jig3KhxKPOZCH6OOGECpZUie4cc/9evOw2h3tKe8fJcDMatxh6/IhY5VLdiUT/3jJz8rg9+T+uLwquHZSSPF8GA1K7EMkhiBY/f6DxOzMZad7UCELPfH3o4caMSc/EQMsrkw3YF1TUfcGmLAmYQTXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISfDjmUS97dDrV2NpRT2wKOS61QgkZkdaJ82Q8WEy9M=;
 b=P9QJ5fwUL3oin/3P+81VY06ixT35skWSwXk5d8fGZdz3m29ivaHVD+IPihxVZ+Tjdl4IxfdhQO+zQjbYq/A0zpQc8D8T2aRluUJXgIC1K1VwscE7iTucdj82BN0nm7jssx0ocmAB4b8kIDJ//PY8FQTqpgZWaoETQfwqYtZnJYq//nWTsGQZwGszePyNukJVgozwjDGKoUNwyjpA1IFjVi3x3tUnKyMZTrmqxdf6q9a+Pa2dBcSPAhB/HHv5w3ZIoqt8GsDTAB7rYmFP8YFf0VvXhig/C0zv46cGA+Lz5286E5fJHnB89r+5RqA4czW/tyYIdBWKWqo0uVoWnFjBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISfDjmUS97dDrV2NpRT2wKOS61QgkZkdaJ82Q8WEy9M=;
 b=jaucl1BdZSXpbSFqiZBHBEZn/uuPxRvOq7zW6zEje8Killca9M74TybZl4Vt75QRudkhn+r29drhXgE4nU4cYxehUQYlGrM++VkH22g4pnWfiC+Br8KvyfLXZf9t4o7+m7AINs/DWSzdjHaA4KLgYc0Bu3RlCqY4B3oHySoujXs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 13:51:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 13:51:10 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Roi Azarzar <roi.azarzar@vastdata.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Sagi Grimberg
	<sagi@grimberg.me>
Subject: Re: nfs4 delegation - question about share access and delegation
 types.
Thread-Topic: nfs4 delegation - question about share access and delegation
 types.
Thread-Index: AQHbOninnNW5TLFEfUCYxf5WrP+VQrK+nzAA
Date: Tue, 19 Nov 2024 13:51:10 +0000
Message-ID: <29A9D9F1-3EE6-47CE-9316-4654485E8ED0@oracle.com>
References:
 <CAF3mN6VXr2tdFTSZVttqSgjaNpjNfQHZ0Ca2Oib4XLktF-Tu2A@mail.gmail.com>
In-Reply-To:
 <CAF3mN6VXr2tdFTSZVttqSgjaNpjNfQHZ0Ca2Oib4XLktF-Tu2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BY5PR10MB4148:EE_
x-ms-office365-filtering-correlation-id: 068e3bca-cf10-4810-f409-08dd08a139c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXBLSTR1K1pkLzFkcjAwYnlvd3NnQ282dVVZQnZQZUVrVzNSWTdCTDU3QnJv?=
 =?utf-8?B?WSs0ZkIrVFVNNmdvcHpmYXB3cEhGUDh4a3FlbXA5UHpnbnpiQ3lXckJoazlJ?=
 =?utf-8?B?YmdOeGhxazZxQ0U1ekhRRU5pWEZkOHNHTlNNN2tvbWhicFl5Nzh4MzZ5TWEr?=
 =?utf-8?B?TDhNMjRrN3g3NGZEZncrRDdiU0FsLy8vTTYvdjNsQzFTR2NWaitHK05Sblgv?=
 =?utf-8?B?S0YvYzFPdU9aamErQUFsanFTWVQrMkNZVS85bHhXTGFDWGlyOGxyemxldlRx?=
 =?utf-8?B?R3g1bys3T01KVHo3MEFZbUZmWDJ5MEoyUkI0Vi9ZcmFYZE4rd2llYytDeGtS?=
 =?utf-8?B?N1piR0svVVNWUDBGcUNKNm1FVThPUXN6cUozMUtoU0VvVmN2anlqN3pnYjF2?=
 =?utf-8?B?N01YU0pMbEM5eXBQNmxEL3JLbXpxZ3ZlMW1laEZqSmx3bXZoMnJKNWRKT1Vq?=
 =?utf-8?B?VlFWRHV0T0lGVzZKZUJNckFGMkFGUzZqTG8zZmtNRHNCY1dVOGsxYVgrSlZF?=
 =?utf-8?B?cnFLT0x0WmZXblJCYVlXZFdEWm1sdEdTeDhIU1dQQmpRQmtZRWhvNWFYRnBh?=
 =?utf-8?B?aDJNYll5cXNsWDRWNGFva3RMWjdhYU1Vb0x5YjZvRnkrb01hbE5ubldPalY1?=
 =?utf-8?B?U3FKNGZXWTRMMTg2UnQvcGhTTkxKa2hxSytCN1p6dENvcTBpd0xGdnB0TDV1?=
 =?utf-8?B?UGVqeDhjL1Y2REdhVVJya1JSNllCTXRUZWg2bXFsQW5CL1hRSXJUeVplbjl6?=
 =?utf-8?B?bGZWZVU4ekVWT05QYzBYMEc3cUQ5MTkvSDF6SzV2YStKTGJobUlwUkJnZWxv?=
 =?utf-8?B?V3BLeTJCRGY2UGx2RHJSaC9CRkVpSkhlWms2OW5EMDlML1NCcXNtOHVoN0NB?=
 =?utf-8?B?QUR0WFZ2WWdCaXpndk1wN1oxSS9vVkhzL05DaUZtTUdyaEdXQ0diUllxUjU4?=
 =?utf-8?B?V0k4WDNUeE5CcTVLSkRTZ0NUdjRsdklFQVR6YTRrYys5TzhEZ2R6RWNON2VV?=
 =?utf-8?B?aTBnNUhpSjZKU0UxbGRBQmdFN0ZhQVBiQzZuOU5mTStPb1FoSGd5VFVaSjZp?=
 =?utf-8?B?d2MvWlE5eUluaDN0bzlxZnBtdTJLdWVBbit3MFQ5N0JVYXN1RWRqbnhicUcr?=
 =?utf-8?B?dG5uVkI0MjduMjRaNC9ndzlpYWNzckZsbEZhb2tTdFFsYTU4R3VzREphWVZ3?=
 =?utf-8?B?Qm9EcW9xZk02QTgwTDMxTWpYeDZ3aGNVTmpmUmlwUUlYODNWRmJBU0pQZmVn?=
 =?utf-8?B?M1hlV2lqSzRPMTBhL3hBOTlwMDlSMksxMEpDN21NZWVrMmpnSkp0N096enpr?=
 =?utf-8?B?MkprZmVFWHJUaHhtMElIKzh0OXhMNnVpZzdHWThyRUtBSzlnMUxVaUJ5OWl5?=
 =?utf-8?B?Y3cwMDhDMzRFZDcyL0hxUWxzN09QRHBrbEt1SytiTUxyS2VBdFRvMnNib3lm?=
 =?utf-8?B?NHh1UUNPS2FCTUF2cm83eUxMM05lUXFjcmVjTzVvZnp0RW10TnRHTGNZcUUv?=
 =?utf-8?B?N3BCMnFoeXpXRG9sT3BCWXNhbm45a0lPT0R4eVJ2YWVjdlpUVGlUbkdoRGoy?=
 =?utf-8?B?dVFVbFJIWmZSNDJkbHRUN3VQR3diWTJwWUs3SGx2ZmRjM3RsV3NESVZBdm9t?=
 =?utf-8?B?cDhUWlMzMzdXekd2UjVWb3JQc2JtaXpRZ0NlVGtFL3VaeDI0ZnVQc1ZUN1JG?=
 =?utf-8?B?TlNEdHRMVUJvY1VzTmNLelZqcm1qQ1gxN0hxRGxOMlNHeExTZHpNVSthZ1Vt?=
 =?utf-8?B?eGVCSHJzRmJBRFZGNkJlcVIrZCtnUG9ueTY1N2VZTStyYjRzYW8zZEgyalBJ?=
 =?utf-8?Q?CN5l+vMtWLeMQKDUstPsauNUVeNSgZmnr33Xs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2ZqU01lUHAxQ0tOaktJMGUzTkNablptalQxT2p1dTVFLzZ0WFlmcHZpU1M1?=
 =?utf-8?B?T1FCdE1hUzdZOTFQcWR3aDk5Tk9ONktTMFdraUNScVhSRGpTUmJNQ29SMmdE?=
 =?utf-8?B?Rmg0VUx2MFZCdU5OQXFxbU03SFpSYjJ6VkdpeDBKTmR0ZmFHbGNaV2ZmQUc2?=
 =?utf-8?B?Y1JQUEhXbE5RdFk4blpicmR4L0lLemd1VVBWMUdUWkpHUkJxYnQ1enIwQVpM?=
 =?utf-8?B?WWRBY0hhZ3NHRm16SzQweWMzRHdBeXRjQkRlWWZTTGtEM2pHbi95WlhsTllq?=
 =?utf-8?B?U1phTktacnNsRUVvWjZKcHFsNWpPZXBHS0tqejVDaDcxNE1rYVRjOFFtWmFF?=
 =?utf-8?B?YTRNT3dyVUF4anIwZmVpVjRpSG9XT0NkVUV1TVpMRDNUaXNydytrMUZSdGxL?=
 =?utf-8?B?NFRXdFlsODhzSS93a2F1NkExZ0FLUnlTTk81b095M0EyWTBPZGszdmE1SllG?=
 =?utf-8?B?aU5BY2Exbzk3ZTArUkc0a0JBbFBpQ0N2TGoxK2ZtZ1FSYndzaVF4OE5MS0tr?=
 =?utf-8?B?OHdQa1VIQ0Jyd3BMVVA3cW80UmhRMEtvaFVZcG1uc0dET2sweEttMkVXQTgw?=
 =?utf-8?B?dVBvN0J4bjN0RWRlbnNWY0RBSDRQRndpZjZONFI0dU5FcE5HTmkvSEFpUTRM?=
 =?utf-8?B?VDFuOUdxQmE1Rm9jVHhOZTB6ZzZ6eGdSLy9NMTlYVXh3RmxzZkxqemlHYllw?=
 =?utf-8?B?azArL0J6UFE3Q1hEUGxYVXladnBWL3VWb0h0eDF4djgyT0FxNlgrTmNxNCtZ?=
 =?utf-8?B?Qm1MTThVWVV6N2lqY3NNRmc3NkdIMGcxRVVQWm56Y01ydmIyMStCeDA0NDFF?=
 =?utf-8?B?Nko5eGc2MXdJTnNrLzRWaUhHUEZ0YS9TKytnckUzU3pZUllKRlhyd21aRjdJ?=
 =?utf-8?B?emtMNGpJZWJHLzdrUCtXcFJ5U3NmNEEzSnhXYWpLcGJ1WXlpdHJheWxGYUJr?=
 =?utf-8?B?eWtPQzNvbTRheFMvWFpIUXhob2l4RFp4T1dOTWRvaEs1U1BDTW5yNHN1bUxm?=
 =?utf-8?B?THlpZHNxemVXM01FY1BVcWZFbW5XS2lNZUZuQm5IaURKeDFIUlJ2NHQ2ZCtM?=
 =?utf-8?B?Y0U2d0VmOEcvUHhmUDVaTUxGRitEZFA5b1NsSEpQTGJYUkNEVmtnamNoN05j?=
 =?utf-8?B?RExGcUtFN2RsS1Z2QnR4R1ZWbXJYckRscGZFVkErUTRNRkhpZHBpbCsydDFB?=
 =?utf-8?B?MVV1OW8xYmRKdFlQRFZwbG1zQ2k2TUo4UEx1L1pvVGd3NW1kOHJ6Ym1hTGc5?=
 =?utf-8?B?enlTT0hqMG5TVXpSN3NyUnYzaEJEY3JKUDlBb2FzT3liSE5aREV3S3E4NEZO?=
 =?utf-8?B?YjFPcnJvYmFFSmdNVzh5SkRlelI2SmJCcGNiM1ZlWEhOVVhyUWtZWVdvUllO?=
 =?utf-8?B?d1JFelMrdG5GblJBRENRQkdtVElGTHR0S1cyOS9hMlM4YXNidExSYzc4Mmd0?=
 =?utf-8?B?cE9RRVFMS0dNYTJQRHF0bjZBQ2QvaE5ROU9yclIwNFN4YmJPZW0wRE85VVNt?=
 =?utf-8?B?Si8vZWsxRVdXWVo0N0lKak9aMHRBR1RYQjA0d0NqOXNpUU9GZm5hUzFiSlRw?=
 =?utf-8?B?RllTYURlMUZXams2NG1FMk41elI1YWJvaEF3TGZFTzVoaEFvK3NjeXZPa21i?=
 =?utf-8?B?QUVIcVdoeXh1M1FtUzZDOVlCeCtvRHBQTms0dnNkVlA3NHZpeVhxVUhGSHJJ?=
 =?utf-8?B?b09KUGFyRDFibDZQc3lFejVKVG1XWVhsNElYM3RpWmNjc3ljZm5uSEVtVFYw?=
 =?utf-8?B?ZDdWT1RabkJtTUlXN2U2L1FIMkFhRDJwbnFpaHJob2RSOGNwL2YzWGltaGVH?=
 =?utf-8?B?OGdvam9nL3lJeEV4ZkNaNUR0VTFCYmN3UitqR3V3RTdjWXo1TlFsWEM4SVpU?=
 =?utf-8?B?WVhRNlhSZlp1SnZic1VxWEw1WWE5Yyt6SG5jZktIZEhTL0NvNEM5RDBtSkxS?=
 =?utf-8?B?OHlhTmJFdUR3N0QyMXhNL0VkV0VNQ1B5REE0TUs4c1g4YkRRU0JkSlBQSStV?=
 =?utf-8?B?R1Jya3A1cTFBZkNHTnJPRmlua2NidU9QYzJ6T2xGUjZERExVeitySDJLWjl2?=
 =?utf-8?B?eXVsQjNxSmJQQUhON0pjYkt6c3VaZkNNWkNTZUhWZzR2dkJ1V1FZWlNYc3p3?=
 =?utf-8?B?NWxTL3J4SVBCY3JKNmp2R2tHYXk4S3R1a2lYS2dhLzV5MjdUQitoTCt1cndF?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E32F29469D6316408F464195E9C64C4F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VyTki4dOwik7UrLcnLUvZnfL+uKuiVw+hnLF9yFlSGY2QrW/1FCcj2A0vSHap0B02d7hxKBFuiJ/62DDYt5Ivk3V1avKHIedsMEOit5/PoUZ39tisbC1y2LtziSK360SXVKQXgLchRDZNCH/i7RB4dK2sBliWBQNsu9DxsW0DZeZ0/3SP8FBiK2T1JPefOTL6PglIxz9Sf8T1oNuXQSJxoPub1o3aGqNldFg5p/jb5ywlSqmF7MmRn+z8RSC9OSdYSq0huHgXbjq831i0fyXA/nlO34YZEY+BeyEoywTsYLX34vIBGamO5Q3cXWuZBfiB/fu1yY8OergK89qdrfEAY4JxPomrOHurttJXL8BtnKE5qrc/e0X1h+mpX+CpGRigAh4NVaj1q0HyMTP/AMK+eeOw5QEl0Eep+2aunN0DzUizhlEZC4BA5B4NcBIybpBtq7RAAMRDh28vBFW6LoL5MFP3Y7s59V/2gSPYjWjqybyjX+froOy0xMmfNfULbr5ZGjBB6EOyPHmEwCOS57N5PyNseXs1vEJmNLdDu6zpEFgIFGkN2rz/TgKFQHaZIEg0H/01rt7ZR1xTPsZlJpgIrmThKIN0vgL6koz69yyK6U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068e3bca-cf10-4810-f409-08dd08a139c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 13:51:10.7845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIRa/0oUr3Yh/MAA3Hlz5XR5OKX41s9hlSgluW0Jk52RYxouzEdf0Fwxff74wJL/JEb8qreHpMguUj9Lv++lEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_05,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190101
X-Proofpoint-ORIG-GUID: Qfo00iU9na8eO5vDYY1iAL8GdmutI62W
X-Proofpoint-GUID: Qfo00iU9na8eO5vDYY1iAL8GdmutI62W

DQo+IE9uIE5vdiAxOSwgMjAyNCwgYXQgNjo0NeKAr0FNLCBSb2kgQXphcnphciA8cm9pLmF6YXJ6
YXJAdmFzdGRhdGEuY29tPiB3cm90ZToNCj4gDQo+IEhpLA0KPiANCj4gSSBub3RpY2VkIHRoYXQg
bGludXggc2VydmVyIGlzIGdyYW50aW5nIGRlbGVnYXRpb24gd3JpdGUgb25seSBvbiBvcGVuDQo+
IHRoYXQgYXNrcyBzaGFyZV9hY2Nlc3M9Qk9USCBhbmQgZG9lc24ndCBncmFudCBkZWxlZ2F0aW9u
IGluIGNhc2Ugb2YNCj4gc2hhcmVfYWNjZXNzPXdyaXRlIChvbmx5KSAtICBjYW4geW91IGVsYWJv
cmF0ZSB3aHkgKGV4Y2VwdCBmb3IgdGhlDQo+IG5lZWQgdG8gY2hlY2sgYWxzbyByZWFkIGFjY2Vz
cyk/IElzIHRoZXJlIGFueSBsaW1pdGF0aW9uIHRvIGdpdmUgd3JpdGUNCj4gZGVsZWcgb24gc2hh
cmVfYWNjZXNzPXdyaXRlPw0KDQpUaGlzIGlzIGEgbGltaXRhdGlvbiBvZiB0aGUgY3VycmVudCBO
RlNEIHdyaXRlIGRlbGVnYXRpb24NCmltcGxlbWVudGF0aW9uLg0KDQpBIHdyaXRlIGRlbGVnYXRp
b24gaXMgZXF1aXZhbGVudCB0byBhIFJXIG9wZW4gb24gdGhlIHNlcnZlci4NCklmIHRoZSBjbGll
bnQgaGFzIGRvbmUgb25seSBhIFdSX09OTFkgT1BFTiwgdGhlbiB0aGUgc2VydmVyDQpoYXMgbm8g
UlctY2FwYWJsZSBzdGF0ZWlkIHRvIHJldHVybiB0byB0aGUgY2xpZW50Lg0KDQpTZXZlcmFsIG9m
IHVzLCBpbmNsdWRpbmcgU2FnaSBHcmltYmVyZywgYXJlIGxvb2tpbmcgaW50bw0KdGhpcyByaWdo
dCBub3cuDQoNCj4gSW4gYWRkaXRpb24sIHdoZW4gSSB0cmllZCB0byBkbyBzbyAoZ2l2ZSB3cml0
ZSBkZWxlZyBvbg0KPiBzaGFyZV9hY2Nlc3M9d3JpdGUpIGFuZCBkaWQgcmVtb3ZlIGZvciBhIGZp
bGUgdGhlIGxpbnV4IGNsaWVudCBhbHNvDQo+IGRpZCBzb21lIG9wZXJhdGlvbnMgdGhhdCBJIGRp
ZG4ndCBleHBlY3QgaGltIHRvIGRvIChsb29rdXArcmVuYW1lKSwNCj4geW91IGNhbiBzZWUgdGhl
IGF0dGFjaG1lbnQsIHdoeSBpcyB0aGF0Pw0KDQpDbGFzc2ljIE5GUyBzaWxseXJlbmFtZS4NCg0K
DQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

