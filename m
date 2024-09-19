Return-Path: <linux-nfs+bounces-6552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC33F97CA5B
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 15:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D30EB22A8B
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B763441746;
	Thu, 19 Sep 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GwylnoJJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SJjc6gaz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF381DFF0
	for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726753612; cv=fail; b=FLnjkBq4KCeH49HpmdNoqaH6Mk7MHaFRKUcKbBhEXl1wiDDbVYKyRpcUuO2hP10+8lHX+28Wo+dvV0yBsHPmqTOqoXvfdBfMi9/gEP1QMgwLkY//qpxMS1VlX8t8bQ/IxIlIaf5tC8l5oAf5YTadgUI+zO+OHPvjfzC1DiwHxwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726753612; c=relaxed/simple;
	bh=lO/H44IJEUmTTeeQWGJTmRQnRtBxWa0s4MaGub7FGlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j+A0nYK14E6DW+9OpIXfbHgzR7nbULe4J5ch3FQ2oMwvFDuSEDdWy9f/td3IE+a4Hec3SxiQmG9+lcMqQ0RzchMeFYUbGuqaW3o1LSAlSDqpOPtuIUEhHhmHwwzVqGCx/wrH6bwXS29tOg3vQoD2rQglP762d4uyBHwsQ/ui7bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GwylnoJJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SJjc6gaz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J7tavR014325;
	Thu, 19 Sep 2024 13:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=lO/H44IJEUmTTeeQWGJTmRQnRtBxWa0s4MaGub7FG
	lw=; b=GwylnoJJe2+etG/xSIVrXvJ0wvhNJ+gXZQTu5d+hL9LBHHRL9E5+pWcSu
	YQU8F7EAHIXZQ0gPF/Kp9gTPCO1m4SA/G0uqki5cgib7CvOMXQs1ym9LHT28jcmZ
	nly6zv67Jx7+ayF+h5J+aBR3ZgGawsGYm3L6lNaZfHvi9TR0Uka4MT/HwtVIhEDF
	saR8pjRRfCKXLCseksMvDtvsk3XXtt/2lyqIPTs9UCR9LAsmjev3L7qsN+lflzpM
	hZ/Zp/9HmdeIpuUh6a4qIqNlopOrFHpS7+MUfX2INfmDRT3qZ/ydNS+4sk0SoE0W
	+sX4cCj61THyeM5fsjC+a9H64rbSA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3n3m6cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 13:46:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48JCSakc011136;
	Thu, 19 Sep 2024 13:46:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyb9rv2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 13:46:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyxVl8Mo5N/X6MM/Mxx9VUrLDZy6cFa8asJ9yD2I3ZYEHCjCYSUS69zAYvapLYCi3Tui5BgJQaKKEhBaBrAezbk+F3Dx7x5o0cF7UuGnL6O0sHhBTMrjnbNwPAKvWnvuWVZiAbkTAFVdd+nuaXzYAsDUVgxo9SASLZJ+p2OnNRnKOgNtYhe/4bvpFAVErVcqMA6yiUbtcQxLuSTFo7FQgLd2KklPmaR3URP89Vv2FgS3+rIPPHdCWkQk2+Do3cz2y3lpdyBJh1WtMV8LtbDO1v92THVM9tzT444nF5ISgyf3FjOKDwA43G/T9f/whLW3wR8QBD3b6lhPr7O5Wx4JNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO/H44IJEUmTTeeQWGJTmRQnRtBxWa0s4MaGub7FGlw=;
 b=yzpo7Ouoh+zZbeWrRQPyH37l20S1R7zQLlLiqWY3IFW1O1fBOA0DinEwBg4AYNB3Y47YlhEM8lINS00ITd3UoFQWNJ9sgKJPFZESCYqPDJ+HYncwu1VIkqhRNoINL3DUAz1Y0wDAijxLUpoA028UYyw7XP0mk/U0xo2dwgeD4IhTc5+YjL6v7vJj/b399cz7WLZSyXQl7eVkjwysu7zEsY+AV5HUK9ar+LKqmF0/frXDvSfD3nzuB3AJeXO1egyEWyIfDB25q4KfKxxbNG7C0c9l5pxPH0MKDoieZuPi7vIws9aeRCU07AXwgsUAE4AShPqsOq4GBy9Z5qLx5PvKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lO/H44IJEUmTTeeQWGJTmRQnRtBxWa0s4MaGub7FGlw=;
 b=SJjc6gazKYG/bz7x5MgPg+JuVd540epij9aNbbovfzbqPOfaxH9bHbj2/Tdp+oR/WVhvyGGDBikdtH6CmTrD4Zm5h4evUeIceLfAI7vM3LtbsNBgkymdeYNw7XJLlmQ47AUGk+aYZNSUbRoEZUN6PIFbrNA4x0BEvF6qr6UnHrU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB7403.namprd10.prod.outlook.com (2603:10b6:8:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 13:46:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8005.006; Thu, 19 Sep 2024
 13:46:35 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Dan Shelton <dan.f.shelton@gmail.com>,
        Roland
 Mainz <roland.mainz@nrubsig.org>
Subject: Re: [PATCH] NFSD: Fix NFSv4's PUTPUBFH operation
Thread-Topic: [PATCH] NFSD: Fix NFSv4's PUTPUBFH operation
Thread-Index: AQHa7BOjrZJBg6lhT02FF4+YAZJgK7JfTMIAgAAPuAA=
Date: Thu, 19 Sep 2024 13:46:34 +0000
Message-ID: <F736A7AC-0AEF-41F4-ABDB-6FB2AEC43F7A@oracle.com>
References: <20240811172607.7804-1-cel@kernel.org>
 <CALXu0UfkjJWrzQo0Ovb-RNBJ08xBDZbKUBPmx8J8FXMVpLCAmQ@mail.gmail.com>
In-Reply-To:
 <CALXu0UfkjJWrzQo0Ovb-RNBJ08xBDZbKUBPmx8J8FXMVpLCAmQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB7403:EE_
x-ms-office365-filtering-correlation-id: 07c60e57-6daf-4bde-71d3-08dcd8b17a26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MElxSWUzUkYvRTVFY25Ja2lxZ0xRZDJtNEgweFZhZXFORURxUDdTZ0pBTmtl?=
 =?utf-8?B?ZFAwVEhjb0ExQmlRWjJoMVYrdk93Y3Y3MVJrTTA5LzVxeFBIOVgzamp0OWl4?=
 =?utf-8?B?MnFQRWE5NkY1MWJSYjV1UGlNL3NwQUwzcDluRkZzSjNXdlNWbFZGMUYxWDJC?=
 =?utf-8?B?V2RPUG5JOEZVN2NJai9JRDZWSUZXWGprZEgwTlZOc0hBSVZ0Nk1kUCt2aVY1?=
 =?utf-8?B?M0ZyUGNvUnFQbXZzeStQN3pjaGZoOEVibkxPKzF4dGZUU3VFMFdzNnV5UU1r?=
 =?utf-8?B?dE83d2FaT21jM2tKNWpDMHFCdENvSm9UdllxWFJCcUo3dWtPcHdwVDR6cmRQ?=
 =?utf-8?B?bkJpek1RWFc2NTl2M1pvRDFOYm0rQ2NZaVEzdXpUOWx1ZDJkN2ZQSjZsS0xT?=
 =?utf-8?B?eGRzVE9IVkN5QVJ4Q3dHVzdYYVNKT2VZaVh2YXluem1sNlRTYnpzeXFJMFFp?=
 =?utf-8?B?d24xQVMvd3NtTS8rZEQyWFZKRG9rTi9ONjRtTXgrcHNwNzF2TGdGNmlCRHhh?=
 =?utf-8?B?MC8xQzlNMTYzbHJpb1VzL2QrUzEvZzNtK0NUdDlnSGY4YmRHOFFjTTc4Z0pZ?=
 =?utf-8?B?ZCt6TENab1kwVlZtajh4UkVxMm9UR2dpTlRPSzN2TTNCcEVZcnFoc3llb0pT?=
 =?utf-8?B?UFV0SXV1NHZzcHczTCszMVJxQTNnTUUySFg0S0pWeTY4Uk9CZHBDTk56UUZv?=
 =?utf-8?B?WldoUVVjOGZib3hIMHVERHRvY1d1MWxMS1FNWXlMaUdxRENKMWhXMVg5NThn?=
 =?utf-8?B?akxZbVJBTStqSnpTN0llWGFsRnh4dVNESmpkTVp1dkw0UTVGTFNwNXhCQjlv?=
 =?utf-8?B?TGdZTHFuRzMwK0cxU2tZWUtPS1dLSEM0RUdHZUxJb2QxU0VRbTJsY09ORVV3?=
 =?utf-8?B?YTdCdVB4NjI3WmVlNXFrYXErSm42MHhYVWdxNVNFYjd4WUVDQTBhRFpjU3pl?=
 =?utf-8?B?bkIzVTFkOXJPVHcvdzNwN2NjVmw3ZTdTU3IwY2NjMkNYRDNiSkRGbVRSemda?=
 =?utf-8?B?SG8vV0lNMzVOZWF5am9jNEJXTVYzRUYvVy9VejhkcTNydGU3c1B5VnAxcGxN?=
 =?utf-8?B?Z040cjZ4UlFuSmhsb3BzNUErUWpoa1JoMjBROGE2ZXMxUCtVc2JwWUYycU51?=
 =?utf-8?B?Y3Q4dmtZMERtZVBlYWxuSGtlMnlWUnYzZklvakVRaGd6NXBXcXdWV0tVRUNJ?=
 =?utf-8?B?ZTArNU1uVnJDRVhFSlgyeWRUMlBUek91L0xKaGVrcDE4dER3QTE4L24wR0M2?=
 =?utf-8?B?VWhlVXpnSlRnVDRhU2Z6YTVZY1RVaFRpTEFyL3dyMXNvem1uMTFuQW1FQmll?=
 =?utf-8?B?V2ZGSExtS1VZenRIc1pjU1Nxc1ZCL29lM0RxSFhhYUExUkp6aXlnb1VneWx6?=
 =?utf-8?B?VHNjVnQ4VCt6djlTZ1VSeGRsUFl3eXNVZG5PcGV5QmZuRmpZWXAvZkJodGJx?=
 =?utf-8?B?UldyOGtFNTFoUVFrdmNYWDNwSDJmNTNnT05kTFVDRTJmb1NndmNWcWFBNGtB?=
 =?utf-8?B?L3FCekpJSzhIRTg3SzVvTTFJbW82ZzRrVklwQklkWFdOWDhBdFdpMExQN0tr?=
 =?utf-8?B?Mkpvc2tWLzVUM0wrbjBrTlg3OG9KVWErNDMreHVFbE85dUZCRHVTMjFVU1l6?=
 =?utf-8?B?MWxCdXl3ZmJWZWFWb2l1RFFQUGwyMnlidWFWNnA1ZGJnUXVSV3JxQkg1YTk0?=
 =?utf-8?B?by9RQ3QyTVUwc2Y0L1pHc1lReW5RMWYvRlpLaStWenBRMHRpZFhRM1MwRUZ2?=
 =?utf-8?B?YzRTS1NmZDRsUEc0aU1EOTRZL04zZGR6Ni9xQnZRNVdlSGFwRkZsSklZQ213?=
 =?utf-8?B?bzJEK05FYnd6YTZMTk91VkRtY09WZTVrdHFGTlF2dVhUTFVoQTljTWt6Nmo1?=
 =?utf-8?B?VHNLS3V3cmgxeFRuNHBIOXlvTHM4RDFWWXEycm13Si9oT3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1V0VzZIYVJuaHlzaUQxOWNiWkJxa0ZxcTJyMGlGU0poYVVkQkRQYjNEb3pK?=
 =?utf-8?B?Tm13MisrSkpmY2V3a05oWVMxelh1VUVsbXVSS2o2QnI2UEs4RkNuOXFvVC9q?=
 =?utf-8?B?QUcxYWZPMytOTjRScnFmVkxaZFFQVW1kWFBFa2tZS2hsLzQ5ZzlZN3cwSFp5?=
 =?utf-8?B?QVFOSk5vUkFhY0hHamYxelhaYjBiQUhYRnc0Sk5VT2ljdEprcW52bHJJNU95?=
 =?utf-8?B?TzY5OFhEcUVrVmhUY29udXdGRVNLdmNGUmJidjlmU1liUWxFcVhuTWsvejlW?=
 =?utf-8?B?cHVyamRvOEVEOWxoSHAySnowcGdJb053dVRBYk9rcHNXemxPQkJCc3BHeXF1?=
 =?utf-8?B?ZE9QK2pMZG1ma0oyYzVVK0hCeGRTTnRKY3NaTVJjNzhEVUo1ZXpVSU9OcGcw?=
 =?utf-8?B?SW5HTlZ3VW5PYnkrSkl0THpoVDNFUEpTS3VZd0szbmNOMmxCbnhIcnY1ekFI?=
 =?utf-8?B?eXF4ZHFxV3BjS3YzaW8xVENFRUZMVEVaa25xeFU1WFVzVVNnQ3VFV1hKbkhJ?=
 =?utf-8?B?QjJDcUNuSW5lZHpCOW81M0xhVkhvbVFyMTJoaDlFSzNqaXhYUXRaL0E0N29P?=
 =?utf-8?B?VXordng1cGNWd2VMMVF2cnNKL2U0MFExWURaUFRTNEpZVHJjMHBVRU1Xc3lE?=
 =?utf-8?B?dWJiSmF2ODVPUzIybXkwKzNuTkZrWlQ1VlNxdDNXaFE4K29JdlRRTTRXenhU?=
 =?utf-8?B?RUd0V2RKbS9TRkx4WE51dExYY2lmQXZNeWFuUXNkcDIxSlVhemwxVlRROWhy?=
 =?utf-8?B?MGFua0tBU0NwajY1VzAvMjhMNmtOcmx4aUdacjc3RzZBN2g2djY2WWN5NjFF?=
 =?utf-8?B?akQzSGNuZGZkMVZYVlloY2tEVTBZbzU4T0VPYmEyNEJZZ3VpTjZsSGRHczRJ?=
 =?utf-8?B?emU1OEdDNFJRa3o3bDJMRHQvdUhTVjNYa1FFVkpoK3M0ZTAyRzhSMGlHaHA5?=
 =?utf-8?B?Q1Q0emM2ajgwZm1kTDRvbW96eFMwU1NTZ1RpWXNzSnZmQ1htUmp5Rjd1MDlS?=
 =?utf-8?B?b3FFM2NzUmQ5RitHVG5hRU93TFAzSUo4R3hsR1QvcE9FNWNESWdKQzdHaEZv?=
 =?utf-8?B?bDd4N3JhTTc1NEVBNXhDT0ZxOVpmTllVMmJPbjJ2MGUzQnpDLys3cVZIYXdk?=
 =?utf-8?B?MGthT29WcUEvV1BEQW9ibCtrelc3UE44bFJxbjlJV2c1eWpaUW5wRysyK1hN?=
 =?utf-8?B?NmtBT1huRnZvdURteFhWVU5jcytYTm1rTmJ0Sms0b2xMYXRQcnJDOW1uVG1X?=
 =?utf-8?B?WnNYeFBPVnA0bC9aaUpwSzNoUmI5ZWY3WlZHR3I4WUw3WkhBNW0rWHg0c1FB?=
 =?utf-8?B?ZDg2QWlOV2J3Q2lmVkFTS0JXZnJCTjFNRjYycWN5T2JnYVhXWm1sYXprenJy?=
 =?utf-8?B?UFFnenM5eDhOcTZmSGhSRm82aUZVZGZzSm9DWUxuUERNalh1Y29MdjRaSG90?=
 =?utf-8?B?RUJXWFVNRnNWUitxam93R2luRGxmaTJxa1hTNHVUdEpobEd0Q212SENzUjlJ?=
 =?utf-8?B?SkJuUjQ4K0ttOUlheTA0SHh4ZWNCUEc5T2FIelpLMCtRQWJiMnVMZGlxaVBO?=
 =?utf-8?B?ZXU2SFRjYmpkYUVlU1hZeEVZZkU4eitTek5uT0RrMUhxOTFBcHF2am1ud2Fh?=
 =?utf-8?B?a1BIVzA4UURnNzJqazVFK3R1ekJqck5GSzBTaDRLZEd0YUZwd25tMy9aQklX?=
 =?utf-8?B?UHNQVXZ6bjc1UUZva0JKRjhBMGtSMEI1d0dFQjN5STkrZ1NCMHFGN3BqSGc0?=
 =?utf-8?B?aUlzVmdMcjZMZ0ZhdmExSzVpcG9OMEtORHI3UG9iUWpZZWxoY0d5bXpLQW1E?=
 =?utf-8?B?bm1zUnpRSXFHRVNRQUkzSmduSW5CVUh4YjIrWGpxTzBhZVhMcmlpazVaVzNh?=
 =?utf-8?B?d1loUWJXcHI1RWp4cEIxRFVrUjVhM2IzMHN2RVF5MEtQblZXNXRoRFJvdW5T?=
 =?utf-8?B?NysxQnRWdFdlbnN4aWhzdUs3T1NVSzQxUk5Fc2VobkJzWHlKKzN5bVhYZWla?=
 =?utf-8?B?MVJld2swb3lML1NzV3pZam93bEtOTHFuNEtGWUlEaE8vd1hMK0JDVkdTM0ph?=
 =?utf-8?B?VU1DR0s2WHhKZVkyTHJ6aE9JQUcvWUtGZXk5c0lJZzMyU1hQUDFxSkxvQ1lz?=
 =?utf-8?Q?T1q2D2erJ73mruhuVb7T6BfuP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <261C4B8728B4AE47A5D58845739BBECF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vw1/8DNIPoU34swUvuq5fqkReSarV1dfw/IrjWSGBMreOZRlfx745ZXG2jG4FL54Iw5kQiWe4yp2gnFPj1AWEqxW4zUh9kHM6xPOVJw7ARamb80OeYlqK/WUrhoxSt7lHbf+oOkk4K/R0zoSlBIKYGKC39IbmRpS6ZtSR2GRT1Rr4d82B0yNX1LlMOml3I63ch9ObEPpoS4iEB01XEdfsPPFqwq3wl+jwBC1ACoKJvQwbk/pyc9tnKTMKT+ZOPjYlb4rPI5HB6zQYFdg2Tw6ATxTT9o7/zPCTmxPrAQYwSO4hqCWfta0BtuAuFI0e/GfABKRUBXXE6aBdmOIqnMdc4vhvU2crQuY6rPPF6S4f24CQ6Scoom0BCcBfMRuLC3LORNKN+ecEG6RJA0MjIbWv5a46vWnwtAHz/6PDGLap00auUyTho7UCGx1RpKlnCFaayM4wOW84SLhBxkxv7zmRHNmafKtOgFGD0NEx3IIwwmX/b/bzdDmJPOsEKvQCt2+8VLb9e8dq7Pau6wuOgWOmrcXnPDBqj5mR/0w/YOsEx51yTZ7/d7VnXAo8dZioeGyv4SGpp1Sc7A+VkGPoJAmRv21DRXakgfFDRpDB5UhnBI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c60e57-6daf-4bde-71d3-08dcd8b17a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 13:46:34.9786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYTonwdEIeg5Juy6KMJCF2elGpyM975nYqfNSJl0b63TwcOOEWknNuOO3boz+7tQzJXnmHW9BWS1SIZDjsma5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_10,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409190090
X-Proofpoint-GUID: AToE5u3fMtYoqVX4Wf67o5AHivSqHQo9
X-Proofpoint-ORIG-GUID: AToE5u3fMtYoqVX4Wf67o5AHivSqHQo9

DQoNCj4gT24gU2VwIDE5LCAyMDI0LCBhdCA1OjUw4oCvQU0sIENlZHJpYyBCbGFuY2hlciA8Y2Vk
cmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBDb3VsZCB0aGlzIGJ1Z2ZpeCBw
bGVhc2UgYmUgYWRkZWQgdG8gdGhlIExpbnV4IDYuNiBMVFMgYnJhbmNoIHRvbz8NCg0KT25jZSBJ
IHN1Ym1pdCB0aGUgcHVsbCByZXF1ZXN0IGZvciB2Ni4xMiwgdGhlIHN0YWJsZSBmb2xrcyBzaG91
bGQNCnNlZSB0aGlzIHBhdGNoIGhhcyBhIEZpeGVzOiB0YWcgYW5kIHB1bGwgaXQgaW50byBhbGwg
dGhlIExUUyB0cmVlcy4NCg0KSSdsbCB0cnkgdG8gcmVtZW1iZXIgdG8gY2hlY2sgb24gaXQgb25j
ZSB0aGUgdjYuMTIgbWVyZ2Ugd2luZG93DQpjbG9zZXMuDQoNCg0KPiBDZWQNCj4gDQo+IE9uIFN1
biwgMTEgQXVnIDIwMjQgYXQgMTk6MjYsIDxjZWxAa2VybmVsLm9yZz4gd3JvdGU6DQo+PiANCj4+
IEZyb206IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPj4gDQo+PiBBY2Nv
cmRpbmcgdG8gUkZDIDg4ODEsIGFsbCBtaW5vciB2ZXJzaW9ucyBvZiBORlN2NCBzdXBwb3J0IFBV
VFBVQkZILg0KPj4gDQo+PiBSZXBsYWNlIHRoZSBYRFIgZGVjb2RlciBmb3IgUFVUUFVCRkggd2l0
aCBhICJub29wIiBzaW5jZSB3ZSBubw0KPj4gbG9uZ2VyIHdhbnQgdGhlIG1pbm9ydmVyc2lvbiBj
aGVjaywgYW5kIFBVVFBVQkZIIGhhcyBubyBhcmd1bWVudHMgdG8NCj4+IGRlY29kZS4gKElkZWFs
bHkgbmZzZDRfZGVjb2RlX25vb3Agc2hvdWxkIHJlYWxseSBiZSBjYWxsZWQNCj4+IG5mc2Q0X2Rl
Y29kZV92b2lkKS4NCj4+IA0KPj4gUFVUUFVCRkggc2hvdWxkIG5vdyBiZWhhdmUganVzdCBsaWtl
IFBVVFJPT1RGSC4NCj4+IA0KPj4gUmVwb3J0ZWQtYnk6IENlZHJpYyBCbGFuY2hlciA8Y2Vkcmlj
LmJsYW5jaGVyQGdtYWlsLmNvbT4NCj4+IEZpeGVzOiBlMWE5MGViZDhiMjMgKCJORlNEOiBDb21i
aW5lIGRlY29kZSBvcGVyYXRpb25zIGZvciB2NCBhbmQgdjQuMSIpDQo+PiBDYzogRGFuIFNoZWx0
b24gPGRhbi5mLnNoZWx0b25AZ21haWwuY29tPg0KPj4gQ2M6IFJvbGFuZCBNYWlueiA8cm9sYW5k
Lm1haW56QG5ydWJzaWcub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNr
LmxldmVyQG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+IGZzL25mc2QvbmZzNHhkci5jIHwgMTAgKy0t
LS0tLS0tLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA5IGRlbGV0aW9ucygt
KQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnM0eGRyLmMgYi9mcy9uZnNkL25mczR4
ZHIuYw0KPj4gaW5kZXggNDJiNDFkNTVkNGVkLi5hZGZhZmU0OGI5NDcgMTAwNjQ0DQo+PiAtLS0g
YS9mcy9uZnNkL25mczR4ZHIuYw0KPj4gKysrIGIvZnMvbmZzZC9uZnM0eGRyLmMNCj4+IEBAIC0x
MjQ1LDE0ICsxMjQ1LDYgQEAgbmZzZDRfZGVjb2RlX3B1dGZoKHN0cnVjdCBuZnNkNF9jb21wb3Vu
ZGFyZ3MgKmFyZ3AsIHVuaW9uIG5mc2Q0X29wX3UgKnUpDQo+PiAgICAgICAgcmV0dXJuIG5mc19v
azsNCj4+IH0NCj4+IA0KPj4gLXN0YXRpYyBfX2JlMzINCj4+IC1uZnNkNF9kZWNvZGVfcHV0cHVi
Zmgoc3RydWN0IG5mc2Q0X2NvbXBvdW5kYXJncyAqYXJncCwgdW5pb24gbmZzZDRfb3BfdSAqcCkN
Cj4+IC17DQo+PiAtICAgICAgIGlmIChhcmdwLT5taW5vcnZlcnNpb24gPT0gMCkNCj4+IC0gICAg
ICAgICAgICAgICByZXR1cm4gbmZzX29rOw0KPj4gLSAgICAgICByZXR1cm4gbmZzZXJyX25vdHN1
cHA7DQo+PiAtfQ0KPj4gLQ0KPj4gc3RhdGljIF9fYmUzMg0KPj4gbmZzZDRfZGVjb2RlX3JlYWQo
c3RydWN0IG5mc2Q0X2NvbXBvdW5kYXJncyAqYXJncCwgdW5pb24gbmZzZDRfb3BfdSAqdSkNCj4+
IHsNCj4+IEBAIC0yMzc0LDcgKzIzNjYsNyBAQCBzdGF0aWMgY29uc3QgbmZzZDRfZGVjIG5mc2Q0
X2RlY19vcHNbXSA9IHsNCj4+ICAgICAgICBbT1BfT1BFTl9DT05GSVJNXSAgICAgICA9IG5mc2Q0
X2RlY29kZV9vcGVuX2NvbmZpcm0sDQo+PiAgICAgICAgW09QX09QRU5fRE9XTkdSQURFXSAgICAg
PSBuZnNkNF9kZWNvZGVfb3Blbl9kb3duZ3JhZGUsDQo+PiAgICAgICAgW09QX1BVVEZIXSAgICAg
ICAgICAgICAgPSBuZnNkNF9kZWNvZGVfcHV0ZmgsDQo+PiAtICAgICAgIFtPUF9QVVRQVUJGSF0g
ICAgICAgICAgID0gbmZzZDRfZGVjb2RlX3B1dHB1YmZoLA0KPj4gKyAgICAgICBbT1BfUFVUUFVC
RkhdICAgICAgICAgICA9IG5mc2Q0X2RlY29kZV9ub29wLA0KPj4gICAgICAgIFtPUF9QVVRST09U
RkhdICAgICAgICAgID0gbmZzZDRfZGVjb2RlX25vb3AsDQo+PiAgICAgICAgW09QX1JFQURdICAg
ICAgICAgICAgICAgPSBuZnNkNF9kZWNvZGVfcmVhZCwNCj4+ICAgICAgICBbT1BfUkVBRERJUl0g
ICAgICAgICAgICA9IG5mc2Q0X2RlY29kZV9yZWFkZGlyLA0KPj4gLS0NCj4+IDIuNDUuMg0KPj4g
DQo+IA0KPiANCj4gLS0gDQo+IENlZHJpYyBCbGFuY2hlciA8Y2VkcmljLmJsYW5jaGVyQGdtYWls
LmNvbT4NCj4gW2h0dHBzOi8vcGx1cy5nb29nbGUuY29tL3UvMC8rQ2VkcmljQmxhbmNoZXIvXQ0K
PiBJbnN0aXR1dGUgUGFzdGV1cg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

