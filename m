Return-Path: <linux-nfs+bounces-5805-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0797960D8D
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 16:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F20D1F245C1
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCA51C4ED0;
	Tue, 27 Aug 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GdpZdCGs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CjpKfueZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC9573466;
	Tue, 27 Aug 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768865; cv=fail; b=ZEAno2rx+tQZjsyG8tG+2PNfD0ATS8rhX2hjd3OLF5Nv2jg3GC1sZ2H4BYLq/utihcQK1Fu9mFnIvHYkh0OiSS4C46xqRRMqxLWmUknLTlqyMemFatTwxts/1cmubpeN+3xVdU8F/UixCioBrK1WfM8oR/hzeiqqjfqWnvYM8ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768865; c=relaxed/simple;
	bh=1kbZ2lUzZD1olGmMumXgg8C+PiL1d+yKafW80Kv+jLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pfgzz3c3MQfQePaw/bSV8iOgT2Q5Lhr/1Bq5e6w4hqcaXgpL/APy5VGtuw1VJrM5IvSrnQtuuM6fcNkJt3OPfhJgt7UH48chhth/+5XNUnCMEOhLYTlRnPaxeIvTPYGWgMhHty8l4z4xMuCWVm8q8J3N4ASEyB1esLjHE83JbDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GdpZdCGs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CjpKfueZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RCBTwI012520;
	Tue, 27 Aug 2024 14:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=1kbZ2lUzZD1olGmMumXgg8C+PiL1d+yKafW80Kv+j
	Ls=; b=GdpZdCGsSgajwhXjXbGRJZdAPxCavSVDTRsqUh2TSuqPxEWXncJF2+HFX
	SgVUSb/AitW1VyqRllfmwodOYcUddYKuXFIFWsOq1Fr4bf7jlyi4WjNvQxMbFKyH
	p022J87w4YcyWMd1Xs0xWDCmQDbUhW+lEjf6uJgAkEBOeSGWmY6e8VGHtND2EnmN
	sawVZO5HhPQ+9Uxh+sP+Sc+xRfrWn3bv8Iz9toDkTIa38gYuYcZeAc8tBByKn0c4
	c9/0ilYnn8tQxgxIsr2TkcNpYddihxc8mSJpIusvGIFm0XGDt6zjLuOpfrAKfXPc
	/QaKbXgick6hQZJeJUIDpXlMTnt6A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177n45p9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 14:27:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47REPEl2034724;
	Tue, 27 Aug 2024 14:27:34 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189st3tr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 14:27:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBxj8+xV2LArca+kEboniBPjPnWkL7gzrmetM7n+vGSFuqLMho9hRsCY1OTUAGLEJHAG2yIfaSz0WFu+wUjIFu3schcwvF3byiXzCBp/0bxwHQUfbjPfARNV5cTdPgkJWtAIzgL22OJRHMGN8BO8ySmko8gHWG37Sqf3qpTnHKP12NEArH0d/bUIst6/AY5kXBekqq2vM5kK+AB/EK40gMQKn0XDVKPJvuBgFMIKMTrqk3MqHNtm1dCLmI6m/rVOaH3i1K8Nx9FVrR3HSEw1Pcvx54qiF/cZ8xp2MFwXg6c5Zaft6tDmv3VUZ+U0iy7CL6CgVsQq47I4fj+QXWx7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kbZ2lUzZD1olGmMumXgg8C+PiL1d+yKafW80Kv+jLs=;
 b=Wc7B1BKYrp0sQVr4r+8zvWSxjZBWYg3dI7ECnhe2pI6B1swQkBROAtba0dNj7y8jgQgqIHUIor9OaeftTUu4gM5aBW6/wP4SosM5xcX4eT5HDcjT3FOXM5d3xPf09vgQGefN3pnNS2TOmqj9lScmZ0rwy1JYzAcOLGMxVisvutzzrlq+miPHeOY27p1hRaGAAi9nFmGmP/pgHscwCxiMVuvo13Iem19LLtl/uVPsJMlzAw9uzuDK7J9DTZxkbaf1MC1aDeaZ0W32x3iYKd9KwStRcGpCA91fGdovtFPbwvupxSaLlNYFhYzoMS5R002KDPXEOJNVp5hvwwi1g5yGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kbZ2lUzZD1olGmMumXgg8C+PiL1d+yKafW80Kv+jLs=;
 b=CjpKfueZM04PCJZEuCF0bBFE37WoPSTSBrtUCO8b3GWrnI+FGtoVA5cLvdrYVxpd0RQfMfpaQAqPmuo7p4eUEwsS16xkTsXWKFD5fgwUeKNd4hOr+cyygv91ri7PxdvhAFobbrkLxXEdNESixh9p4EH1uST6ACQwJYpAa15dlc4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5166.namprd10.prod.outlook.com (2603:10b6:5:3a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Tue, 27 Aug
 2024 14:27:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Tue, 27 Aug 2024
 14:27:30 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Petr Vorel <pvorel@suse.cz>
CC: Martin Doucha <mdoucha@suse.cz>, Neil Brown <neilb@suse.de>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-stable <stable@vger.kernel.org>,
        "ltp@lists.linux.it"
	<ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v2 1/1] nfsstat01: Update client RPC calls for
 kernel 6.9
Thread-Topic: [LTP] [PATCH v2 1/1] nfsstat01: Update client RPC calls for
 kernel 6.9
Thread-Index:
 AQHa7i0UNj/LC/EjQE2iBvWdTJluHbImuy+AgA244QCAAP8bAIAFnsqAgAAaFACAABIOgA==
Date: Tue, 27 Aug 2024 14:27:30 +0000
Message-ID: <44DF7F99-3FDA-46C0-BC93-B6679F04B7AB@oracle.com>
References: <20240823064640.GA1217451@pevik>
 <172445038410.6062.6091007925280806767@noble.neil.brown.name>
 <9afef16d-52b2-435d-902a-7ccfa5824968@suse.cz>
 <20240827132242.GA1627011@pevik>
In-Reply-To: <20240827132242.GA1627011@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5166:EE_
x-ms-office365-filtering-correlation-id: 3c66898d-4d26-4e25-fd2f-08dcc6a4621e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aTVlYWF2N3NLZmVzMW1acXRBdWw2Nis5dHRiM3VhV3h0d2xhNFJOb0FrS0hP?=
 =?utf-8?B?elRrRkg3QU56R0NqVG16cVZIblI2MWQ2RTg0OUpYVGE5T1BMRVRGUUp3S0t3?=
 =?utf-8?B?NjljOFptVmllOEhhQmlQK3JXenJ2em5sZlc0T0NWbC9sUVVYM05qSFRqK3Fw?=
 =?utf-8?B?NVJoeWE4UjBKTkVFL3lDREFRWEltdldiUE8vSWk0cGM4NE5CWGdTc2R5ZDhP?=
 =?utf-8?B?TXRkUGg3TjNwOHFld2VCa3IwTlRFT2lLQUFLVzRRV2J1czhDM2xRTVU0dXl6?=
 =?utf-8?B?MmtoNjlKOTFxNGYrQUEvZzRNVm9IZTFkN21nS21PMFpxVWdyZTlvQVlzcUZw?=
 =?utf-8?B?RWlWNGV2TWhyUlpXbmhQdjUzRHBEVEx2eEg1WHZZMlZDa0ZzdjgrNXlJd1R2?=
 =?utf-8?B?U2Jkc0xNSHJKV3cxSXNCQ2RJaVZESURaVHlWMlNjNnAvYVBnU0lzZlFpM2Va?=
 =?utf-8?B?WFRGMkt4VmNkd24veGd6Ymd0am5LdHpaSjl2cjU5djhoNEx3VlZUVURzVkJu?=
 =?utf-8?B?cWIvSmhmTTB6akxGQ0xvaVkzYkNqS2FJRFYzTXdWK0ZGckZLSUYvL1Q5eHo3?=
 =?utf-8?B?M2RabE0vOU5xbi96aGx4ZTRyWStKWXRhampKMG81Ym5vdGpIWXFPbVE1Zm5k?=
 =?utf-8?B?RjlwVVQrRy9QUnMvVnhDN0QveHdBdjQvS1doeGRLQ2tmcGgwMG41RGZRb3JL?=
 =?utf-8?B?Ny8rOFJwTnRDUklIUFBScGFFQnBIUDBHc09INFZLUmRDYUt3cWhiSEo4ZEY5?=
 =?utf-8?B?OWdMTG1GZnZSbVZLekJHMzJ5bzNQUG1aRDVUNVpnNVhhS2hJR2NIRVA0UmhG?=
 =?utf-8?B?NVJySjJaa3l5VjRVdy9vdWQyRStOaHRuK3NYUzN5UlYrUXh5U0xrYnErc0NF?=
 =?utf-8?B?ZllPblRKZHhxaTZGM0pkUlMybGFEUWxjcS9xb0MrYjNpdUhYUGMvN0t3M3Y4?=
 =?utf-8?B?bGRvMnk0VmxXYzdUQlJLYitrTVAwVTFWNm9NRTVrZUxRTFAzb2xjYVJFYUdo?=
 =?utf-8?B?V0VzcjZwSFZWZHBTRjNXWEo1c3c1WGVIOE9kaDhyN1VGLzNNVDRmMU9ScUpJ?=
 =?utf-8?B?UmNDUTJCSzVQUWw5UFRWKzF2b1c1MmJqUUkzQmc5YzhDSFJsRGk3Y1R0WGNG?=
 =?utf-8?B?UGlPZEdIaCtHeCtBR05DUTY5ZWYvcTlNMlI5OTZ0Tyt5VERrMDhnUFZqMU9R?=
 =?utf-8?B?NmVlaVBkTlFqdTNWQUFINWRzaUgxd0VqWGdhaVN3VkZBT05CaHF1Z1E3bEhw?=
 =?utf-8?B?TkhGZk1kaWJYbWpJcktXdzNxaHNrZUtobE9Wd0ljOWd5SENDTE5ndnZpOUo0?=
 =?utf-8?B?dHA0bWhMRzVPN25tS05RWVRLVXRLYkp4VFRtTUV1dEluWm0vVCtnUkh4TGo0?=
 =?utf-8?B?L2l3TkdPRy8zcnFsU2JROHRkUHNBZUl3M3ZNYlhqR2NDbEs5TjhBdGJ1Z3M3?=
 =?utf-8?B?ZWlJVytPeW5pMlRoSTBJTE43UnhDTkVOTEl0R0VLd2dTMnNNaFV0WnhQVktL?=
 =?utf-8?B?ZVdjK2sza2w1MjdGVktQbjJOZE9vbWVxWHROWTJ0ZWd5SEtOUWVCQm50UTc3?=
 =?utf-8?B?aEZTdy9FWWFNcXY1ZVBMbGM5RkJvaEpoZG5lZzNsc2p5OVR3Ry9LOXd6cmJZ?=
 =?utf-8?B?T3J0bGtyU2pubkdmK05kOUVMa3ViTGJuSWVaVytONUVRT1Z2VnNPL2kwNzZU?=
 =?utf-8?B?QkV1Z0x6ZmhTSWtjaDFuK3FQejR5cWNFZmlkaUdJbFdmck0vS2VGeHQvd05W?=
 =?utf-8?B?TlRIVlo2bXFxTEpKTGx5bXZheGtYRENwREp0SnRXbjRTSkxsQTR2QzlseXY0?=
 =?utf-8?Q?Igb22q7ovVdiOtj5TyU0tB3LDrlNqgyJOk3Uo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cy9XK0Vnb3dQb2xSZmZDRjJZV0d1b0VWa1pReU9Xcy9DRWlXUG80bnlBbUFh?=
 =?utf-8?B?UzlPR0J2NGNlQ3NObGt1ZDByak90QmJvcTdmTEVLVlNOYnAzQmFCcG91VlVk?=
 =?utf-8?B?aTd5TG5OeWdYRzFNcTg1cy9vMWF1bm1jTWdPS3MxazZHWGJpSUhrQld5bUp0?=
 =?utf-8?B?QXlxK0NOTkJoSStSY3NrWkN0d1o4L00yK0htaE9WYW56YzFwclpFM3BtREZN?=
 =?utf-8?B?RXJvYTlOLy9qZGFUUStXK3NRNG1aVDJJS2V3bmtwbGt6b3Q0QmtaQzFzQk1p?=
 =?utf-8?B?ZXZYQmtVVEs0Y0Z2d055eFhEMGQ5UkhUcXZoOWNUbzJOOXRXcDI4QXZGaFFV?=
 =?utf-8?B?d3ZJNVg1eER3OFFWT0NKMlhoaWRLbGFQb0xLN1dhRVA2L1hjS2lNeDVNRHlH?=
 =?utf-8?B?MGhMMEVpTENUMVdOa2Fna08ybWJIU2hURXB5d2tSd1hvS0hzVlR6cmlqWU1H?=
 =?utf-8?B?UlB3Z1NUQWxpcm41c1cwSHNtTVI0emRFWmZCdXhaRVZGdlJzYWxqVUdybFE3?=
 =?utf-8?B?NmlBYkxHREg2SEhGQ2taSGFma3hkV0RxcmZUK3A1aWVscy96Njl5a1UyNEFr?=
 =?utf-8?B?MzhEd1cwYUtLVkdNa3oxTE4vc3ZCdVFoY2UxcFBvcjg4OVdoU0p3KzdxVXNr?=
 =?utf-8?B?SFQ1Z1NwZm53allvZm9CQXVXSnV6dE0yVE5HS084WTlZVy80SVgwYzdIWFNQ?=
 =?utf-8?B?U3pSc1JFY0U2aWZSenVtYzFoRkpoRjd3VFQ4ZVRIdEhRYjBsbTVCMEFFbmUy?=
 =?utf-8?B?UGxyaktGZWdPVXdEVjliOTBmTG53MDFhRHZrY3EwRytjVFZUVkRvS2lmUlV6?=
 =?utf-8?B?eTVFYk1iMDNIMTFUcGRubDh1cFRvYzY5TmJoMnRGZmhnYlJ6OVg3eDdFcThU?=
 =?utf-8?B?MmlTdXpTbmJUMDdFcjRJZmRsWnIvRTIrNXl3c3lveU9Nam1FVHpjdnE1Q2wy?=
 =?utf-8?B?RlJ2WWF3N1ZUdEM4dTJERVpJOS85WHNCeWtWVzdnMlYxam9qTXlQUVZlSE02?=
 =?utf-8?B?azdNK2FES0VmMDdoNFJsTERRZ2NYR3JCQTdsdDM3RktocFFKK2JhWFlzdmdN?=
 =?utf-8?B?ZmZjR0F0VmluZkMycnRBbFhQeWtaeGlGMGtUZWFiUGw5aTNIT3lyUFV3Vnp0?=
 =?utf-8?B?eVlYbEdvak5qSDFJUjZqTTlvR2wwdWtqZGU1YjROQXVxZi9jUHVYakxVR3Av?=
 =?utf-8?B?U2JTa2x4V0ZxZEFPSnFVRTdtYUU1VWdqM3RQc3ZpMHZ1b3FoS0szNnhNazBk?=
 =?utf-8?B?K1AwRkdhZmZQNEFyRlJCRmdYTGhBMXFBRDk2aU9xMmNBckpDVXNEZmJqZ0hB?=
 =?utf-8?B?clpSWTY1YnJxNWFwMkFVTzByK1BQL1Bzc3dGUERMOVB6Zm5SWFNuR2V3UUhw?=
 =?utf-8?B?N2dMWlNEUFJGKy9wdzR6blUwSzd3ekpOdFRUMnZhY1Nqc2R4ZGlpUjc1eG11?=
 =?utf-8?B?bXpPUnJrNkxsUFhCc1ViMVYxU2dPNDdONlhSUURBcU1nYWtaRUVJM0hOOVJU?=
 =?utf-8?B?Wk92VWJIdTR6OEdLRTRjTm5JUUIrbCtCMTlTcmdORjM3SW9kMDBmcjU2Q0RF?=
 =?utf-8?B?aTNKY1hKV2NrODk1WHRWaHlRcXVLckxxZGN1eXJnb2hxUmJiNWJNdEpNRVlt?=
 =?utf-8?B?cXYwdXNmd1ZZNFd5Mmd2L2VGWlBrS3g0dCszemszMUkxajZDM0tJdWdUUy95?=
 =?utf-8?B?ODIxTGhiR09aQysvQ1hkMWJoOTBEM29INkxVamYvWUpkamxTbVJGWUhwRWFw?=
 =?utf-8?B?bWQ5OG1kbGIvSzFJMDBCRUJKa3RlQlgyamdKdllpbjllT3R6V1NyKzZXUzJv?=
 =?utf-8?B?WEZlVGl2Ymw2US9oZ3piaEhJLzdTMytCQzIrQm43K1E2QUhXTWtmWlZvcU9x?=
 =?utf-8?B?ZnB5NDJENjJaam80TUdpV0hNLzZRV0xzVU4yOStlYy8wVnR4OFZ6YnhLK1dW?=
 =?utf-8?B?S1NQanV0N1VGYWJKbFhMWXBnNHE1WktvUmU5OXpOOUdMQVRrSk01RlFyTGJS?=
 =?utf-8?B?dzhTYVAzalFNSXB3T2ViN21EWG84T1BLV3RmUWpPU2hwUFVNcUZRK25qNDFY?=
 =?utf-8?B?UkxVY0Z2dnZPdS8yMjJIVzUyTVRuUmpnN3ZpVjNwYVRKc3VMNjlXaTIwcFVD?=
 =?utf-8?B?T1ZVQkViUHBoMlFHTVhySHUyOE1ZcXI4c0cyV0U4VEJlT1ZxNDIwblRvQkIx?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A2A049F49E8364E9C629085A85F715D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rNXe1weJArLxuORCZ6RVJNpAuUAKspIxscqV5529rV/l2+8aQ7GOlHk/x3OM/jhtjDf6kHMHrXbRRtvZp0AkQFXIhgczR4uNNBA1J5OJLdQEEoJJZQzHyjHg+hiP2qG2tIt7RiLxKoh/zrdHrlUAp+iQuozOstuAtYGojQO508FT/jzIe0Pztgy0ewkt04h9d7DrnPEiUXQsAzMJDIILSSqUgZiGMH6soI3Pq/9WcJylba7dVKiQtI6Oi30cgz2XwhfvqVveldJ/wtWjrJUHgPPsWXM9mx7AYxVU00o1k1j1PIV9sSHxRHaIar//5huYvxtOwp3ff5ENwmRaKxnJPlWnWRkvomHXOti6FSxHNNEUu9/hp6f1Uk8W3iOVZZPG4RhMobXaypbRC59N9FFZsuRt3YgQLAUyAJ1LQ+mf/1ZiNDjlIUXxSlwYsNzNMUVdM4rAV2YK1y3988SDi/dqNP93i4LMpF5G02Ios7VXOUFGcKrPWHqx2YOFGLiFbD5oi/SwJ+RJ+cK2uSGBaCTfQpYWFbabmv6jXqmzBoqlv0OitXe+k5S9FdDavRw5luD+z/SuvPIESMWJd0/bVErkT3N+QUsdRYGryr2Y46nC0Ro=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c66898d-4d26-4e25-fd2f-08dcc6a4621e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 14:27:30.2331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgfWOIhd/reG1RLNj7EAowP35z8jDSlef82k3fd5rkCOJkgJV9E+ywQMIfa2goJnJAj5d845egAuwmK9xeAISw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_08,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408270107
X-Proofpoint-GUID: eAlB97HkP4LJTKHSdnxYKzY6tDo_jEex
X-Proofpoint-ORIG-GUID: eAlB97HkP4LJTKHSdnxYKzY6tDo_jEex

DQoNCj4gT24gQXVnIDI3LCAyMDI0LCBhdCA5OjIy4oCvQU0sIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PiB3cm90ZToNCj4gDQo+IEhpIGFsbCwNCj4gDQo+PiBPbiAyMy4gMDguIDI0IDIzOjU5
LCBOZWlsQnJvd24gd3JvdGU6DQo+Pj4gT24gRnJpLCAyMyBBdWcgMjAyNCwgUGV0ciBWb3JlbCB3
cm90ZToNCj4+Pj4gV2UgZGlzY3Vzc2VkIGluIHYxIGhvdyB0byBmaXggdGVzdHMuICBOZWlsIHN1
Z2dlc3RlZCB0byBmaXggdGhlIHRlc3QgdGhlIHdheSBzbw0KPj4+PiB0aGF0IGl0IHdvcmtzIG9u
IGFsbCBrZXJuZWxzLiBBcyBJIG5vdGUgWzFdDQo+IA0KPj4+PiAxKSBlaXRoZXIgd2UgZ2l2ZSB1
cCBvbiBjaGVja2luZyB0aGUgbmV3IGZ1bmN0aW9uYWxpdHkgc3RpbGwgd29ya3MgKGlmIHdlDQo+
Pj4+IGZhbGxiYWNrIHRvIG9sZCBiZWhhdmlvcikNCj4gDQo+Pj4gSSBkb24ndCB1bmRlcnN0YW5k
LiAgV2hhdCBleGFjdGx5IGRvIHlvdSBtZWFuIGJ5ICJ0aGUgbmV3DQo+Pj4gZnVuY3Rpb25hbGl0
eSIuDQo+Pj4gQXMgSSB1bmRlcnN0YW5kIGl0IHRoZXJlIGlzIG5vIG5ldyBmdW5jdGlvbmFsaXR5
LiAgQWxsIHRoZXJlIHdhcyB3YXMgYW5kDQo+Pj4gaW5mb3JtYXRpb24gbGVhayBiZXR3ZWVuIG5l
dHdvcmsgbmFtZXNwYWNlcywgYW5kIHdlIHN0b3BwZWQgdGhlIGxlYWsuDQo+Pj4gRG8geW91IGNv
bnNpZGVyIHRoYXQgdG8gYmUgbmV3IGZ1bmN0aW9uYWxpdHk/DQo+IA0KPiBUaGFua3MgTWFydGlu
IGZvciBqdW1waW5nIGluLiBJIGhvcGVkIEkgd2FzIGNsZWFyLCBidXQgb2J2aW91c2x5IG5vdC4N
Cj4gDQo+IEZvbGxvd2luZyBhcmUgdGhlIHF1ZXN0aW9ucyBmb3Iga2VybmVsIG1haW50YWluZXJz
IGFuZCBkZXZlbG9wZXJzLiBJIHB1dCBteQ0KPiBvcGluaW9uLCBidXQgaXQncyByZWFsbHkgdXAg
dG8geW91IHdoYXQgeW91IHdhbnQgdG8gaGF2ZSB0ZXN0ZWQuDQo+IA0KPj4gVGhlIG5ldyBmdW5j
dGlvbmFsaXR5IGlzIHRoYXQgdGhlIHBhdGNoZXMgYWRkIGEgbmV3IGZpbGUgdG8gbmV0d29yaw0K
Pj4gbmFtZXNwYWNlczogL3Byb2MvbmV0L3JwYy9uZnMuIFRoaXMgZmlsZSBkaWQgbm90IGV4aXN0
IG91dHNpZGUgdGhlIHJvb3QNCj4+IG5ldHdvcmsgbmFtZXNwYWNlIGF0IGxlYXN0IG9uIHNvbWUg
b2YgdGhlIGtlcm5lbHMgd2hlcmUgd2Ugc3RpbGwgbmVlZCB0byBydW4NCj4+IHRoaXMgdGVzdC4g
U28gdGhlIHF1ZXN0aW9uIGlzOiBIb3cgYWdncmVzc2l2ZWx5IGRvIHdlIHdhbnQgdG8gZW5mb3Jj
ZQ0KPj4gYmFja3BvcnRpbmcgb2YgdGhlc2UgTkZTIHBhdGNoZXMgaW50byBkaXN0cm9zIHdpdGgg
b2xkZXIga2VybmVscz8NCj4gDQo+PiBXZSBoYXZlIDMgb3B0aW9ucyBob3cgdG8gZml4IHRoZSB0
ZXN0IGRlcGVuZGluZyBvbiB0aGUgYW5zd2VyOg0KPj4gMSkgRG9uJ3QgZW5mb3JjZSBhdCBhbGwu
IFdlJ2xsIGNoZWNrIHdoZXRoZXIgL3Byb2MvbmV0L3JwYy9uZnMgZXhpc3RzIGluIHRoZQ0KPj4g
Y2xpZW50IG5hbWVzcGFjZSBhbmQgcmVhZCBpdCBvbmx5IGlmIGl0IGRvZXMuIE90aGVyd2lzZSB3
ZSdsbCBmYWxsIGJhY2sgb24NCj4+IHRoZSBnbG9iYWwgZmlsZS4NCj4gDQo+IDEpIGlzIElNSE8g
dGhlIHdvcnN0IGNhc2UgYmVjYXVzZSBpdCdzIG5vdCB0ZXN0aW5nIHBhdGNoIGdldHMgcmV2ZXJ0
ZWQuDQo+IA0KPj4gMikgRW5mb3JjZSBhZ2dyZXNzaXZlbHkuIFdlJ2xsIGhhcmRjb2RlIGEgbWlu
aW1hbCBrZXJuZWwgdmVyc2lvbiBpbnRvIHRoZQ0KPj4gdGVzdCAoZS5nLiB2NS40KSBhbmQgaWYg
dGhlIHByb2NmaWxlIGRvZXNuJ3QgZXhpc3Qgb24gYW55IG5ld2VyIGtlcm5lbCwgaXQncw0KPj4g
YSBidWcuDQo+IA0KPiBJIHdvdWxkIHByZWZlciAyKSwgd2hpY2ggaXMgdGhlIHVzdWFsIExUUCBh
cHByb2FjaCAoZG8gbm90IGhpZGUgYnVncywgd2UgZXZlbg0KPiBmYWlsIG9uIHVwc3RyZWFtIGtl
cm5lbCBXT05URklYIFsxXSwgd2h5IHdlIHNob3VsZCByZWZ1c2UgdGhlIHBvbGljeSBoZXJlPyku
DQoNCjIpIG1ha2VzIHNlbnNlIHRvIG1lLg0KDQoNCj4gV2hpY2hldmVyIG9sZGVyIExUUyB1cHN0
cmVhbSBrZXJuZWwgZ2V0cyBmaXhlZCB3b3VsZCBkcml2ZSB0aGUgbGluZSB3aGVyZSBuZXcNCj4g
ZnVuY3Rpb25hbGl0eSBpcyByZXF1ZXN0ZWQgKGN1cnJlbnRseSB2NS4xNCwgSSBzdXBwb3NlIGF0
IGxlYXN0IDUuMTAgd2lsbCBhbHNvDQo+IGJlIGZpeGVkKS4gTFRQIGFsc28gaGFzIGEgd2F5IHRv
IHNwZWNpZnkgZW50ZXJwcmlzZSBkaXN0cm8ga2VybmVsIHZlcnNpb24gaWYNCj4gb2xkZXIgZW50
ZXJwcmlzZSBrZXJuZWwgYWxzbyBnZXRzIGZpeGVkICh0aGlzIHNob3VsZCBub3QgYmUgbmVlZGVk
LCBidXQgaXQnZCBiZQ0KPiBwb3NzaWJsZSkuDQo+IA0KPj4gMykgRW5mb3JjZSBvbiBuZXcga2Vy
bmVscyBvbmx5LiBXZSdsbCBzZXQgYSBoYXJkIHJlcXVpcmVtZW50IGZvciBrZXJuZWwNCj4+IHY2
LjkrIGFzIGluIG9wdGlvbiAyKSBhbmQgY2hlY2sgZm9yIGV4aXN0ZW5jZSBvZiB0aGUgcHJvY2Zp
bGUgb24gYW55IG9sZGVyDQo+PiBrZXJuZWxzIGFzIGluIG9wdGlvbiAxKS4NCj4gDQo+IER1ZSB3
YXkgdG8gc3BlY2lmeSBlbnRlcnByaXNlIGRpc3RybyBrZXJuZWwgdmVyc2lvbiBhbmQgdXBzdHJl
YW0ga2VybmVsIHRlc3RpbmcNCj4gZXhwZWN0aW5nIHBlb3BsZSB1cGRhdGUgdG8gdGhlIGxhdGVz
dCBzdGFibGUvTFRTIHdlIHNob3VsZCBub3Qgd29ycnkgbXVjaCBhYm91dA0KPiBwZW9wbGUgd2l0
aCBvbGRlciBrZXJuZWxzLg0KPiANCj4gS2luZCByZWdhcmRzLA0KPiBQZXRyDQo+IA0KPiBbMV0g
aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvYmxvYi9tYXN0ZXIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy91c3RhdC91c3RhdDAxLmMjTDQ4LUw0OQ0KDQoNCi0tDQpD
aHVjayBMZXZlcg0KDQoNCg==

