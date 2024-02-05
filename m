Return-Path: <linux-nfs+bounces-1789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC82849DC3
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 16:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B2D1F21020
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB02C690;
	Mon,  5 Feb 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AJYZpETH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mB/p3x9r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB02C69D
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146032; cv=fail; b=S0zF0C6SDgLv+GEg1G/YXc6PLAfsT8yklDdk1MYTwB66icQBYnJKoQ+5ZPwFD987UIpiuE+yFDKWerMnASragqemEa0Xp06zx0oZVES2Ugsnc6eSODwBR1SAKLPH7ey8BslCTmI2oXSDVXesIvK4d0blhboDAZ1AxWT6eKFmdo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146032; c=relaxed/simple;
	bh=30pByaLn+tyYcbxfjnNwAs95QjObB+VqSQqCyAyGadQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tbmQCVrd1iboCQ98f6ZhHElMHhOj7u+ALyueP5BA3M68F2hUs3guO7h5I8Y9y0s4Z59vKPQ5j2pW3n1YDPm07pCnnI6un/Uh4H/Lobb7WFoorKdWu/BIS0lorie/FV39CbR+p4M7+BEj5jvED4hyCCIelbi1w2POtxmNDpHKm4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AJYZpETH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mB/p3x9r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415DWQCF001794;
	Mon, 5 Feb 2024 15:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=30pByaLn+tyYcbxfjnNwAs95QjObB+VqSQqCyAyGadQ=;
 b=AJYZpETHbrfFj9npAY81DAVERFT4rRD8fHipMmF5ghNA6T6EotyxHKnlEIlQJ62zU3Qz
 cdooq6AJaYz4BGeFPajFyE4hYDI6nSocQ3gOh3OyCDlVMxPZzvG0lDousRVDSYGzqB6z
 Cl/IQ2A46v1Lqu36pUPaw9rbDZsyiW7YjxeXV53UJYIlpntDrWeSBCnpRFjgmLYPavg8
 GgmIqwkgKWqoSXZ0VNm4qTGC36DszOj+nLojh/3RXnJdtHr/9kvJGurwMRTg/X6RvCPZ
 8ONIfffTsMeISNb2u7FPJQLf8MjbTaGWHpLBAz36QX3o2kbGkiyuU8UZnnOM/4YIHmSj 0Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c93v8q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 15:13:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415Ev8LJ007131;
	Mon, 5 Feb 2024 15:13:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx5yat0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 15:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StnReQrIPwoaH8wpB7Mo7Icu/kDam24CJi0XouHqUTqPUwwDuqkBZTr8i0NA6tw/HJM+lyUwi/qgqHZdJKZy97Mz/RL//KC6FLLQvqP73s0g2zglCDDuhvGYAmVXr16uWLBauLoJ6XUCJqUb4QZwqYw60hxlYpE9eGHrt/9VYhT3ZYkCh7pXzt+ZdkMwljODTXE3zIEeavXEu2f4Y++FdgYwjCSD0G8loLeli04+2J5Zyvsaml8Eru6b/4yCd/9zIGdHZYib5CEeCXQdv0coR4HGd9YJzR7cM6l+KwzaSDXE05431MT4SP9UKVNVV141eX56DjZxFia1hHHMWntGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30pByaLn+tyYcbxfjnNwAs95QjObB+VqSQqCyAyGadQ=;
 b=K6V/EaO0RMzSzI9F95xjrDwrBSrd36y6n+csHqylVX4xkUUa0ZMk7d8OrD4sPFp6TiRpf6oAquIkyDnNlBS1DBJcQbbG8A/kIe6E15X22iTr+MX3tU5Uy5d1/br28YOkSJjine+7+wYr5RRlzH4uneTgoP1Dy37RBJ4QlrFQoul/I3459fhK69u6949sh0Cc4ysvYY2FGpLtLy7spFIZM+thLfEfx1qkEnzqvYp1iRJ29NRkdCTN/mFMPL3sgzDMXcw/4vyftWBcuGXYjSCCZN9rIfytw038IsfCyooNhlM7YumyRiGyUSESqrU3dAZgSHwXXWCrCz1PJVIbDQel0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30pByaLn+tyYcbxfjnNwAs95QjObB+VqSQqCyAyGadQ=;
 b=mB/p3x9rpDxsBwFcAp9l36ZJbO1UvtEDJkYP+F7mttbezbSgqeKY+3LmntmvB9RuiV7TbraZbd2rRppPomKVmhGzIeR1jbENLnERSQREwkAd5x3I3Udg5NmSoCVMvdH6qaHs+w/WHTLv+EagsgA/AatXY97hiG9r/cWoK+TXkYg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6896.namprd10.prod.outlook.com (2603:10b6:8:134::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 15:13:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 15:13:27 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Martin Wege <martin.l.wege@gmail.com>
CC: Cedric Blancher <cedric.blancher@gmail.com>,
        Benjamin Coddington
	<bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
Thread-Topic: NFSv4 referrals - custom (non-2049) port numbers in
 fs_locations?
Thread-Index: 
 AQHaDKK/5xxTBJcRKkGtisdr07fPibBlifCAgA2y6wCABUQbgIAAbzOAgAA1BgCAeNxKAIAKcPKA
Date: Mon, 5 Feb 2024 15:13:27 +0000
Message-ID: <93DA527F-E5D7-49A4-89E6-811CE045DDD3@oracle.com>
References: 
 <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
 <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com>
 <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
 <5ED71FE7-B933-44AC-A180-C19EC426CBF8@oracle.com>
 <CALXu0UeZgnWbMScdW+69a_jvRxM2Aou0fPvt0PG6eBR3wHt++Q@mail.gmail.com>
 <8FCF1BB3-ECC1-4EBF-B4B4-BE6F94B3D4F5@oracle.com>
 <CANH4o6P2S1mOXAbQb9d4OgtkvUTVPwdyb8M0nn71rygURGSkxQ@mail.gmail.com>
In-Reply-To: 
 <CANH4o6P2S1mOXAbQb9d4OgtkvUTVPwdyb8M0nn71rygURGSkxQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6896:EE_
x-ms-office365-filtering-correlation-id: cb90fd07-8e8b-47ce-c257-08dc265d0156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FO4SIPDE4fEjftB/OXEt1y95D15tYKdMVJUoMPeaK7ZUWVJTCCo1VEi8wZZB7iBLTvRx8+CcfzlCT1+JP4MUWSuxSOCliTDHlRbs1R5vOiBy2n0B4a2GS0b4s9r5WvaMU8gnIZ8TFOPBWuGUFlsJ+vyw7O+T6/bnY9Uz8L2lSz/6IDLA6uve3mOFLN8Y4+gJ/gNKc0ti1TgRouqOrHD4rF0F+pP2U/HFLjnQ6xe8n5nxzEyS0GDRMkq0sCkClWLLpirJIZSGcUwA9JeMQoehyP1Qju4Wo7/Di+Dp1qRFhPtYPR/dQwey808x8SffueZJnMD87W8skvTleJHXtrUWY+i7NfTqHf9j9168+e2D6qIp1jZFT5C2yU6CvshrkZ6aicjr2A627qPyaRcWSwLE3KVJ+5/wrM/2jOb0FOweo0oW5sUNYK2Tk5SUltN3TVZhG/Xxd8QXE8juwxPu+55y+DfEVNpEKljeryA3zGFYqeaGJR6YMA6joVGlU005F2IJNlsjVFml78hZeqUs1HcAu5ZDGb9gYpQqyUVZ7KZ+uLPWj4mS7ZyZOfNWxfXgJlgIMb0fWcAs3Ozukd81urylLIrVXWQu3dbD1dLPZVq8NQCOV+6zArBPQ6oDzTMNgjPsii00/Qyami+i8fD4p9n3MBNNaqD5DpglIPpTC1ntYnk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38070700009)(66476007)(66556008)(41300700001)(64756008)(66446008)(66946007)(76116006)(36756003)(54906003)(6916009)(316002)(5660300002)(2906002)(4326008)(8676002)(8936002)(83380400001)(38100700002)(122000001)(33656002)(71200400001)(6506007)(6512007)(53546011)(478600001)(966005)(6486002)(2616005)(26005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T0RlcWZwS3dxV2oxQ3dubzVuVEFYMUhTcS8zd2piZGQ4TUNLSEMzVFFvcWZh?=
 =?utf-8?B?YWFiUlpMOWFPZnJyZE1CRXBNOVRBVnpPMkhzL1B4OG1HRjRSQkxOaVVyL3FP?=
 =?utf-8?B?aGhMbE91NVA4NXgrQUNLRzRhNjFsUjRDKzgxUWd3STRvTlUreUx5cVZBcEM0?=
 =?utf-8?B?YUNKZDd2eC91QWU3eEhoTzlqV3ZqRmNTaUZkZVJWZEIxSUZOd1RGRGZuejVj?=
 =?utf-8?B?OTlpaFNKRUREMjR3QVJhalFtelRQRFJCZVRwcXRNcktKZzR3L29mSWdXWWds?=
 =?utf-8?B?dHo1RHcxK2FmcldqYjN6N3JLNGRTU0hGNkRRMXluckF2TWs3YTc2Y0JZL1JZ?=
 =?utf-8?B?OWFhdkJGYk9nV3FxRFJPb0JyN1NzVmVSUTZkNklPUUQ0aXpzRVFLTkRrRm1W?=
 =?utf-8?B?L1hUZEhKY3g0c1Y5VHA5dGhXN2k2Y1ZmVGc3Z3NUUU9PNlg0OXRhUXJrNmdJ?=
 =?utf-8?B?NFRRbUlBeit3V1A5d3VrY1ArSG82SFdKeExLVjJBUTNuQXFybDJHWkJUZFN3?=
 =?utf-8?B?UVpRanc5Nkd1bGo4U2w1TFJqUWlZRDdDK2pyZ0hTVVpsWnpiYk1oTGNnVTZ4?=
 =?utf-8?B?eFNKemdab1AzMGtzamdMa05YdThxWmtxUTB5U01kVi9rK1R1R0VvYWE0QXFM?=
 =?utf-8?B?WGQ5L2Z6ZmxFYnZjTTFkRUJ5R2VPV0E3Z2pVbmh5UGVlc0djcjBkTmp1MU12?=
 =?utf-8?B?RjJKM1ZvaWpGZysyMzdxaml3d1l3YVQ0dU5DN1ZOK1ZVY2IvbVV6Q0tFMndD?=
 =?utf-8?B?NnRRYjhwR3lRQWIxUHZsZnRUdWh1QW95MVpSRzdPc2k3MHJ5T1c4SUtUenAr?=
 =?utf-8?B?eVRhTnBQL25jTG1nRVFIUGUwNjZiYzBBNThyVk84ZSsya2RhUW9SMXJzV2JY?=
 =?utf-8?B?N2FTZGt3Y0RNTG5DOWdiNW1WemNMc1BQcXhhSjIwK1pobFl5azNtdVgycEVq?=
 =?utf-8?B?a3JRMjY4NGhkb1hBWTNJdnh2MGgybTlaSTRsdjdIcUdSNGMvUXRUdm1XTFgw?=
 =?utf-8?B?eFBPTHIrUndlU0d0cWM4RUxLNWdYdU9SZU52K004U1Z1QVhrV2lBUEQyY0tM?=
 =?utf-8?B?b1hmb2o2N09vbUxoZW1xaW1LWEZScE04c2NFaTNrZXJuaU95K1ZycHl5alY4?=
 =?utf-8?B?bHBFN3Ira01TSTZhdFFZSThvazJFU0pxZVpYNVdCaGlUTHZqbmFVR0QwbXYy?=
 =?utf-8?B?dkJJWVB4elBjZ0EvZmtTTlNlMStaVzBHRlM0R2RUWlBoNkduQXJRd0dRM1p4?=
 =?utf-8?B?MTV0Y0hFMVFjNTF3dEd2bkN1ZUVGZHZXWDRFbEV6VlU0NnJpZzdTUFJDWlBI?=
 =?utf-8?B?YUVuakFmVlZ6dlBYWithOEZBM2U1UkpLbi92alMzM0JrTEYvN1JTRmEvcUx0?=
 =?utf-8?B?NDhFMXF5bStxRmJXVUhlbnU3NjcvdVM0TlNDcTQzRjlnbGRjQTNralRkbHhp?=
 =?utf-8?B?ZXczdGQwY0hXVEdnUjRsTHpsTHAvclA1Zi9vTGJQdXJKK2VISkMzWnljbmtK?=
 =?utf-8?B?VG9oRFFwWGZZaGVwT3pHVHlKWHhteGsySWRUaktsNDNoQ2V3anNUVk1iR0Jj?=
 =?utf-8?B?dE1OQU5FTXZIS09yWG15VjdLMzN5MURaY2dsV051RW1ldmVWQ1Y2NStlTDNs?=
 =?utf-8?B?dXBIZVhjMklKVDBmbS8vSUlPaHNELzA0Zm1LRU0rT1ZZd0J1UkpuR21GRTht?=
 =?utf-8?B?ekxNalUwSFIrWVJ4SHdEK0JaMWN5azZxMmRMVXZXT0xCUkdLSGgwQUFsNUpu?=
 =?utf-8?B?WVB2Zk04eDNuQzk1dXJ1V2l1YmNLVjNzMjZ5SEVoTnFFeVgwZmF1bzFRSVVO?=
 =?utf-8?B?VkQ1L1NLdURXa252SUovenM4RzNJbCtTSXdvZzM2YmxtQlYwbnRMMVMwbytm?=
 =?utf-8?B?U2Q2Nmc4OWx3ZDFBQ29nbjk0b3NsSzVkZFhTSHhjbk5oYjVIeklkOXJ3cks4?=
 =?utf-8?B?QnlES1hERlRrZmwwbHVFeG1Nb092SXRqRldjOGFFRGRINGpVcGJvSjhmWWJx?=
 =?utf-8?B?eFNjTjNxNWJ2ZkVNeUxKVHFhWVNWY2RkTlJ6MW5IRkQ3Ym5oZEx6TVZOM0V6?=
 =?utf-8?B?aWthVlhpTUNHWFExOTA5eG1TTUM3N3UvZ293YXlsYUdwZkNOaXRtSU1PQWtC?=
 =?utf-8?B?dUt4bjVpZVllOFRDYUhQTUR3ZlZweWJOVVVYVEhLaS9wUmQ4cys1anhzTVJn?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40BEC02E9B918B4583702028F5E96D55@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	quJelmUpZf9IEYQOmsPVxCZa9PAz0lS8GFMNIw2i/4dgsjR4u4xwqwg3WzZ+bipoKNzCbIug/3Nz8sAti/Drl2t+e+U9d5TkVQ2NRecLg6055OM/OBxk5zVn6LNqc/tb1vr1ajS8hGvVfZ9wFgDWV1XHyI9/vlHZrBx8iYjlwNivfmYHq45b25qiQ/18JEPHyJfVDtQLGuR80nVhd9lZZAeaqLBlqTP1cB3GjHbILSMeExdxMRW1w4e+dfIrN2y8MR1kJ/p8C+RNxVtk/Z/IDH3OG+aPxqprL71rsJHX8k//eHD2vCdEYKO8+YUQU757qeIAsPyLFvn9VJBSxOZIYWcAVKYRnB21nxRHxUhrFJsehIZ81u4vhYLgUqFQW4arOPbdTOtmFP/3ZJKiB7GUbr1/FTtOayTjiFu0jOUvQfiLLWAqv6TaXx9TulkvlRoyck6VPX5WncxpdN/symj3kdW/fVrMuBSL4m6dp1LQfolqWHU4h2IyENdmVibPGyNYBKAb+sHOTWMDE90kqKFkWQNSNLu7Twjx7VkeUNsPXPAB0fB6KvQ7y/VYz7ySe4DJ0BVw6dkGa8ZpmHgjFF+kuEXXTD2OBbFOl5uxczLC+Ec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb90fd07-8e8b-47ce-c257-08dc265d0156
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 15:13:27.5703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5n4NFnsdDzmlq89xtOgSLpGh8eCq6ptyIZeo/uLTo8nY6TES6wTIqnh72w6EgiqVYPotuP5ppKKCtANG2YcfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_09,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050115
X-Proofpoint-ORIG-GUID: siMWDr0NXyzm37GQrO5H2ckYTqXsRH2F
X-Proofpoint-GUID: siMWDr0NXyzm37GQrO5H2ckYTqXsRH2F

DQoNCj4gT24gSmFuIDI5LCAyMDI0LCBhdCA2OjQ24oCvUE0sIE1hcnRpbiBXZWdlIDxtYXJ0aW4u
bC53ZWdlQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIE5vdiAxNCwgMjAyMyBhdCAz
OjA34oCvQU0gQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToN
Cj4+IA0KPj4gDQo+Pj4gT24gTm92IDEzLCAyMDIzLCBhdCA1OjU34oCvUE0sIENlZHJpYyBCbGFu
Y2hlciA8Y2VkcmljLmJsYW5jaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gTW9u
LCAxMyBOb3YgMjAyMyBhdCAxNzoxOSwgQ2h1Y2sgTGV2ZXIgSUlJIDxjaHVjay5sZXZlckBvcmFj
bGUuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4gT24gTm92IDEwLCAyMDIzLCBhdCAy
OjU04oCvQU0sIE1hcnRpbiBXZWdlIDxtYXJ0aW4ubC53ZWdlQGdtYWlsLmNvbT4gd3JvdGU6DQo+
Pj4+PiANCj4+Pj4+IE9uIFdlZCwgTm92IDEsIDIwMjMgYXQgMzo0MuKAr1BNIEJlbmphbWluIENv
ZGRpbmd0b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IE9u
IDEgTm92IDIwMjMsIGF0IDU6MDYsIE1hcnRpbiBXZWdlIHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+
PiBHb29kIG1vcm5pbmchDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBXZSBoYXZlIHF1ZXN0aW9ucyBhYm91
dCBORlN2NCByZWZlcnJhbHM6DQo+Pj4+Pj4+IDEuIElzIHRoZXJlIGEgd2F5IHRvIHRlc3QgdGhl
bSBpbiBEZWJpYW4gTGludXg/DQo+Pj4+Pj4+IA0KPj4+Pj4+PiAyLiBIb3cgZG9lcyBhIGZzX2xv
Y2F0aW9ucyBhdHRyaWJ1dGUgbG9vayBsaWtlIHdoZW4gYSBub25zdGFuZGFyZCBwb3J0DQo+Pj4+
Pj4+IGxpa2UgNjY2NiBpcyB1c2VkPw0KPj4+Pj4+PiBSRkM1NjYxIHNheXMgdGhpczoNCj4+Pj4+
Pj4gDQo+Pj4+Pj4+ICogaHR0cDovL3Rvb2xzLmlldGYub3JnL2h0bWwvcmZjNTY2MSNzZWN0aW9u
LTExLjkNCj4+Pj4+Pj4gKiAxMS45LiBUaGUgQXR0cmlidXRlIGZzX2xvY2F0aW9ucw0KPj4+Pj4+
PiAqIEFuIGVudHJ5IGluIHRoZSBzZXJ2ZXIgYXJyYXkgaXMgYSBVVEYtOCBzdHJpbmcgYW5kIHJl
cHJlc2VudHMgb25lIG9mIGENCj4+Pj4+Pj4gKiB0cmFkaXRpb25hbCBETlMgaG9zdCBuYW1lLCBJ
UHY0IGFkZHJlc3MsIElQdjYgYWRkcmVzcywgb3IgYSB6ZXJvLWxlbmd0aA0KPj4+Pj4+PiAqIHN0
cmluZy4gIEFuIElQdjQgb3IgSVB2NiBhZGRyZXNzIGlzIHJlcHJlc2VudGVkIGFzIGEgdW5pdmVy
c2FsIGFkZHJlc3MNCj4+Pj4+Pj4gKiAoc2VlIFNlY3Rpb24gMy4zLjkgYW5kIFsxNV0pLCBtaW51
cyB0aGUgbmV0aWQsIGFuZCBlaXRoZXIgd2l0aCBvciB3aXRob3V0DQo+Pj4+Pj4+ICogdGhlIHRy
YWlsaW5nICIucDEucDIiIHN1ZmZpeCB0aGF0IHJlcHJlc2VudHMgdGhlIHBvcnQgbnVtYmVyLiAg
SWYgdGhlDQo+Pj4+Pj4+ICogc3VmZml4IGlzIG9taXR0ZWQsIHRoZW4gdGhlIGRlZmF1bHQgcG9y
dCwgMjA0OSwgU0hPVUxEIGJlIGFzc3VtZWQuICBBDQo+Pj4+Pj4+ICogemVyby1sZW5ndGggc3Ry
aW5nIFNIT1VMRCBiZSB1c2VkIHRvIGluZGljYXRlIHRoZSBjdXJyZW50IGFkZHJlc3MgYmVpbmcN
Cj4+Pj4+Pj4gKiB1c2VkIGZvciB0aGUgUlBDIGNhbGwuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBEb2Vz
IGFueW9uZSBoYXZlIGFuIGV4YW1wbGUgb2YgaG93IHRoZSBjb250ZW50IG9mIGZzX2xvY2F0aW9u
cyBzaG91bGQNCj4+Pj4+Pj4gbG9vayBsaWtlIHdpdGggYSBjdXN0b20gcG9ydCBudW1iZXI/DQo+
Pj4+Pj4gDQo+Pj4+Pj4gSWYgeW91IGtlZXAgZm9sbG93aW5nIHRoZSByZWZlcmVuY2VzLCB5b3Ug
ZW5kIHVwIHdpdGggdGhlIGV4YW1wbGUgaW4NCj4+Pj4+PiByZmM1NjY1LCB3aGljaCBnaXZlcyBh
biBleGFtcGxlIGZvciBJUHY0Og0KPj4+Pj4+IA0KPj4+Pj4+IGh0dHBzOi8vZGF0YXRyYWNrZXIu
aWV0Zi5vcmcvZG9jL2h0bWwvcmZjNTY2NSNzZWN0aW9uLTUuMi4zLjMNCj4+Pj4+IA0KPj4+Pj4g
U28ganVzdCA8YWRkcmVzcz4uPHVwcGVyLWJ5dGUtb2YtcG9ydC1udW1iZXI+Ljxsb3dlci1ieXRl
LW9mLXBvcnQtbnVtYmVyPj8NCj4+Pj4gDQo+Pj4+PiBIb3cgY2FuIEkgdGVzdCB0aGF0IHdpdGgg
dGhlIHJlZmVyPSBvcHRpb24gaW4gL2V0Yy9leHBvcnRzPyBuZnNyZWYNCj4+Pj4+IGRvZXMgbm90
IHNlZW0gdG8gaGF2ZSBhIHBvcnRzIG9wdGlvbi4uLg0KPj4+PiANCj4+Pj4gTmVpdGhlciByZWZl
cj0gbm9yIG5mc3JlZiBzdXBwb3J0IGFsdGVybmF0ZSBwb3J0cyBmb3IgZXhhY3RseSB0aGUNCj4+
Pj4gc2FtZSByZWFzb246IFRoZSBtb3VudGQgdXBjYWxsL2Rvd25jYWxsLCB3aGljaCBpcyBob3cg
dGhlIGtlcm5lbA0KPj4+PiBsZWFybnMgb2YgcmVmZXJyYWwgdGFyZ2V0IGxvY2F0aW9ucywgbmVl
ZHMgdG8gYmUgZml4ZWQgZmlyc3QuIFRoZW4NCj4+Pj4gc3VwcG9ydCBmb3IgYWx0ZXJuYXRlIHBv
cnRzIGNhbiBiZSBpbXBsZW1lbnRlZCBpbiBib3RoIHJlZmVyPSBhbmQNCj4+Pj4gbmZzcmVmLg0K
Pj4+IA0KPj4+IEp1c3QgdHVybiAiaG9zdG5hbWUiIGludG8gImhvc3Rwb3J0IiwgaS5lLiB0aGUg
Imhvc3RuYW1lIiBzdHJpbmcgaW4NCj4+PiB0aGUgbW91bnRkIHByb3RvY29sIGdldHMgdGhlIHBv
cnQgbnVtYmVyIGVuY29kZWQgaW50byBpdC4gUHJvYmxlbQ0KPj4+IGRvbmUuIFRoaXMgaXMgc2Vy
aW91c2x5IGEgbm9uLWJyYWluZXIsDQo+PiANCj4+IEl0J3Mgbm90IGFzIHNpbXBsZSBhcyB5b3Ug
dGhpbmsuDQo+PiANCj4+IEFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGUgbW91bnRkIHVwY2FsbC9k
b3duY2FsbCBhbHJlYWR5IHVzZXMgdGhlICJAIg0KPj4gY2hhcmFjdGVyIGluIHRoZSByZWZlcj0g
dmFsdWUgZm9yIGFub3RoZXIgcHVycG9zZS4gSXQgaGFzIHRoZSBzYW1lDQo+PiBwcm9ibGVtIGFz
IHVzaW5nICI6IiAtLSBpdCB3b3VsZCBvdmVybG9hZCB0aGUgbWVhbmluZyBvZiB0aGUgY2hhcmFj
dGVyDQo+PiBhbmQgbWFrZSB0aGUgcmVmZXI9IHZhbHVlIGFtYmlndW91cyBhbmQgdW5wYXJzYWJs
ZS4NCj4+IA0KPj4gTkZTRCBzdXBwb3J0cyBJUHY0IGFkZHJlc3NlcywgSVB2NiBhZGRyZXNzZXMs
IGFuZCBETlMgbGFiZWxzIGFzIHRoZQ0KPj4gaG9zdG5hbWUgcGFydCBvZiBlYWNoIGZzX2xvY2F0
aW9ucyBlbnRyeS4gRE5TIGxhYmVsIHN1cHBvcnQgaXMgb25lDQo+PiByZWFzb24gd2UgbWlnaHQg
aGF2ZSBzb21lIGRpZmZpY3VsdHkgdXNpbmcgYSB1bml2ZXJzYWwgYWRkcmVzcyBpbg0KPj4gdGhp
cyBpbnRlcmZhY2UgLS0gdGhlIGRvdCBub3RhdGlvbiBmb3IgdGhlIHBvcnQgbnVtYmVyIGJ5dGVz
IGxvb2tzDQo+PiBubyBkaWZmZXJlbnQgdGhhbiB0aGUgZG90IG5vdGF0aW9uIGZvciBzdWJkb21h
aW5zLCBhbmQgd2Ugd2FudCB0bw0KPj4gZW5hYmxlIGFsdGVybmF0ZSBwb3J0cyBmb3IgYm90aCBy
YXcgSVAgYWRkcmVzc2VzIGFuZCBETlMgbGFiZWxzLg0KPiANCj4gV2hpY2ggc3ludGF4IGRvZXMg
YSBETlMgbGFiZWwgaGF2ZT8NCg0KSSdtIG5vdCBzdXJlIHdoYXQgeW91J3JlIGFza2luZy4NCg0K
QSBETlMgbGFiZWwgaXMganVzdCBhIGhvc3RuYW1lIChmdWxseS1xdWFsaWZpZWQgb3Igbm90KS4g
SXQNCm5ldmVyIGluY2x1ZGVzIGEgcG9ydCBudW1iZXIuDQoNCkFjY29yZGluZyB0byBSRkMgODg4
MSwgZnNfbG9jYXRpb240J3Mgc2VydmVyIGZpZWxkIGNhbiBjb250YWluOg0KDQogLSBBIEROUyBs
YWJlbCAobm8gcG9ydCBudW1iZXI7IDIwNDkgaXMgYXNzdW1lZCkNCg0KIC0gQW4gSVAgcHJlc2Vu
dGF0aW9uIGFkZHJlc3MgKG5vIHBvcnQgbnVtYmVyOyAyMDQ5IGlzIGFzc3VtZWQpDQoNCiAtIGEg
dW5pdmVyc2FsIGFkZHJlc3MNCg0KQSB1bml2ZXJzYWwgYWRkcmVzcyBpcyBhbiBJUCBhZGRyZXNz
IHBsdXMgYSBwb3J0IG51bWJlci4gVGhlcmVmb3JlDQphIHVuaXZlcnNhbCBhZGRyZXNzIGlzIHRo
ZSBvbmx5IHdheSBhbiBhbHRlcm5hdGUgcG9ydCBjYW4gYmUNCmNvbW11bmljYXRlZCBpbiBhbiBO
RlN2NCByZWZlcnJhbC4NCg0KVGhlIFJGQyBpcyBvbmx5IGFib3V0IHdpcmUgcHJvdG9jb2wuIEl0
IHNheXMgbm90aGluZyBhYm91dCB0aGUNCnNlcnZlcidzIGFkbWluaXN0cmF0aXZlIGludGVyZmFj
ZXM7IHRob3NlIGFyZSBhbHdheXMgdXAgdG8gdGhlDQp3aGltIG9mIHNlcnZlciBkZXZlbG9wZXJz
Lg0KDQpJbiBORlNEJ3MgY2FzZSwgcmVmZXI9IGNhbiBzcGVjaWZ5IGEgRE5TIGxhYmVsIChubyBw
b3J0KSwgYW4gSVB2NA0Kb3IgSVB2NiBhZGRyZXNzIChubyBwb3J0KSwgb3IgYW4gSVB2NCB1bml2
ZXJzYWwgYWRkcmVzcy4gVGhpcw0KaXMgYmVjYXVzZSBvZiB0aGUgcHVuY3R1YXRpb24gaW52b2x2
ZWQgd2l0aCBzZXBhcmF0aW5nIHRoZSBsaXN0DQpvZiBleHBvcnQgb3B0aW9ucywgYW5kIHRoZSBw
dW5jdHVhdGlvbiB1c2VkIGludGVybmFsbHkgaW4gRE5TDQpsYWJlbHMgYW5kIElQIGFkZHJlc3Nl
cy4NCg0KVG8gYWRkIHN1cHBvcnQgZm9yIG90aGVyIGNvbWJpbmF0aW9ucyB3b3VsZCByZXF1aXJl
IGNvZGUgY2hhbmdlcy4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

