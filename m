Return-Path: <linux-nfs+bounces-3411-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED578D063C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 17:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA7D1C21829
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E9D17E8E8;
	Mon, 27 May 2024 15:32:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384517E90C
	for <linux-nfs@vger.kernel.org>; Mon, 27 May 2024 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823958; cv=fail; b=gVsAbusfW0i4Icnl5xMTn8+HzuqUuUnyglN9oVsFxetzk8FurTItBy0eIdrjoRx3OatPeQiE6ccnoi5qW3gXYSJwqoJP2KJKWv2O8pneD7Fogm6gMJU/X7QIXEZqYvxtopMJuKw9vDFEg5B2nfo6NkkAO9XBQKgxk47YQE+439M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823958; c=relaxed/simple;
	bh=Hl76omAr798a2pkzxcFRzgsNMtcXfwWamMFB8ULR8x4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sqMs90A2lkYOAZdJzxuDbRWqkppWURIhJrJFoWsxMtys6Xv4RLDXajSiL9c+top3HboDCfnxZ1XOD9yXFrRnHpgmSx4bPJtanoB9EkIHUe3xyBiZIHS0gTM/K2mgYqyzm4CC/w0hWdEb0+62V/+amAijvN1cQb2DqUP0caWQ1xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44REO86F025939;
	Mon, 27 May 2024 15:32:35 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-id:content-transfer-encoding:content-type:date:fr?=
 =?UTF-8?Q?om:in-reply-to:message-id:mime-version:references:subject:to;_s?=
 =?UTF-8?Q?=3Dcorp-2023-11-20;_bh=3DHl76omAr798a2pkzxcFRzgsNMtcXfwWamMFB8U?=
 =?UTF-8?Q?LR8x4=3D;_b=3DX/IYK+qFX+zMd01oMrKaxryReXhV28CJXbdlA/wkrWN5xySVC?=
 =?UTF-8?Q?bIHjBWCx685kIdrGLAq_JbvLmz7vr7PjaMprNmSj57CAw1teqeI7EVv1Ipd7Ull?=
 =?UTF-8?Q?rq0bCPzAAdMpH9EPtyIXuQz4w_3D4EterVVyIZUS2k3mci+TrPZ8agySr0vvNFv?=
 =?UTF-8?Q?HjIWusjqEQkf+4dV2rPn3wJUkNr61+W_tQJzFbA/RdSJxw9ti7nXsOufGZg1CB9?=
 =?UTF-8?Q?wxE6k7pZCCQMq41u+3rpDkHsLHzMIGBo8pbVD_a8HlMNM92Eul16hya8ZhFY+d1?=
 =?UTF-8?Q?FslrapIyG5CxV71+fbP3F57e/9NisTbH6YIJxMrs2Jb_GQ=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kb2rka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 15:32:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDe2GJ036785;
	Mon, 27 May 2024 15:32:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50vxbre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 15:32:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZzKvo/dUBhHxVrCEvHyef+TbalMOD2elFchzjkkgnjLXpI+gNIj7XwAhwA+GcxMAjoqVgWa11cgcL1AEArhWoPx5GEunX6ZlRTNqkkrwVLSovxc69PUaDTRY6VzDvRbaicIqovRv9veKTUAl9HlMXU3pQDya4S4Q/2fp+SzEWU06xLEP9AoEa3vfDOOkNHP/c/6V6Bc8yC4p2HxcCTZ7U6BZLeyFLft1Fx1iVna+/R9xfw3CL9ULL1ZGJ25ye7tBpmtS68qskh6qxmCYRI/Xgad98MSLIgS+rMDwnSoH+u5khPPNPo97qfjNmpIJ8p7yXhf41pLN4otlIh8OJzNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl76omAr798a2pkzxcFRzgsNMtcXfwWamMFB8ULR8x4=;
 b=DXjudBgJBbbHSVMo4uA0Nv7lZFPJLVmvb9MgBlWLhwtanJMJXZJ1oL7vVcslVpKF0d8yQu2sbSMO5WLSLVyoV4vTg/TgSoydp2KvtItiOpQnI0N847Q2mXZ/b2BHxByuOAbUZzUlhBoSvTrXYfpA2w/4/wmHSjeIbAppHzAmndId+SI8Vd21QgxnHuybRG6RxUuL/vHpE6FNgq5imKPqUlAYA6c5g0d+HQPLPR7hIHZJqvEoLwUJesv94rd8dltrVihl19i5i13ZXaI+gO5X1yxsGWXUpS8y3R2MODONE26qTD0ZxUQu/2AUrdZhoAWcOfujc8zA3qmIQa4VxwxH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl76omAr798a2pkzxcFRzgsNMtcXfwWamMFB8ULR8x4=;
 b=dtuPAGYn0hOMlccoKv4NmyBXE2SsVLZ5CB8/KtVew+yfcOqpVbnlbISIiqlIawA0U0RzN11ndPvOujrdmTSSptyl7j823HA/UoJ6ZeKacXQFbKp0d/tUN0mjL3b5Jhbj5+uIbpKX0hU84xfJXdSeQ8TJiHkKDTKCmrtb8ErzXJk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY5PR10MB5985.namprd10.prod.outlook.com (2603:10b6:930:2b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 15:32:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 15:32:31 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: gaurav gangalwar <gaurav.gangalwar@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS4.0 rdma with referal
Thread-Topic: NFS4.0 rdma with referal
Thread-Index: 
 AQHaUFYzzofr1t4B40+h8GIuot6lBbDz9hqAgA+fpQCAAAOqgIAAAdUA///jD4CAAtALgIAAhp4AgBeB/YCAjPJMgIAArDQA
Date: Mon, 27 May 2024 15:32:30 +0000
Message-ID: <7BC770F6-8865-4A45-BC5D-53F3EC8F6F06@oracle.com>
References: 
 <CAJiE4OkE5=6Jw3kf+vrfDYsR5ybJDKUffWGXAQd2R2AJO=4Fwg@mail.gmail.com>
 <CAJiE4Okdie0u0YCxHj6XsQOcxTYecqQ=P-R=iuzn-iipphkwHQ@mail.gmail.com>
 <04BECFE4-7BC0-40CE-90DE-9EEF0DB973BF@oracle.com>
 <CAJiE4Ok5FLgk0Asq92m7HhDwAgbiTuWo57ff=i_zaOxhnV6YvA@mail.gmail.com>
 <CAJiE4Om+HWMCuQYsxsaOCnTAZAuLxA4B+3phqeTJNT81gp_mJw@mail.gmail.com>
 <CAJiE4OnNpnJb7EYfujgcRbaUPqruo2j3hOdmmt3LHNHEJ8bw6g@mail.gmail.com>
 <ZcecJNwQnXPpJ3fT@tissot.1015granger.net>
 <CAJiE4O=7C=6rAfkzw4dT9bs_VrxLCqYhp1tszn2h62P2ZVuiGg@mail.gmail.com>
 <36C42C4D-E296-41B0-8418-1CFC5AB61107@oracle.com>
 <CAJiE4Okpwnh4aQvfaVqaSt=vHo6cVuid4w9Xd4_yGEaa3ZkGQQ@mail.gmail.com>
 <CAJiE4OnAwurNwF+jRB84H3sfM2VK5+4Ci3a6ovrZk75zmV2Hdw@mail.gmail.com>
In-Reply-To: 
 <CAJiE4OnAwurNwF+jRB84H3sfM2VK5+4Ci3a6ovrZk75zmV2Hdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY5PR10MB5985:EE_
x-ms-office365-filtering-correlation-id: 0b590855-ed76-4404-2fed-08dc7e62391c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TVcyNXc0cDhpS1BiQ2RKelVPRW9vZGJxU0dxZDF4VTNjcWluVzhHaG1QVzJi?=
 =?utf-8?B?NzhQU1JIbGE4QUNtVVJCR2wrcXMwaTlWSkYySDJKeW1sY2p6WDdQUDZZc0kr?=
 =?utf-8?B?NDZDZ0hwS3VXd05JSzVoaTFSNjc0d2piK0JRV3U0VUlZOE0xRyszMGZyYXFx?=
 =?utf-8?B?YnVmdnNxQ0orV2wxRG81TEprbjdCNWlicmNVZTBFTGlMTEdjWmxGRDZXemlJ?=
 =?utf-8?B?TGZERDl3OGJWRXczc1VqdlVkZHpqWHRBREcxdjlEZ1cyT1N1Rk56SHJQM3cx?=
 =?utf-8?B?VVRFeHh3TDI1NnZ3MGloaFVxZFhaQUVqNytHY2RiTTBmWHFIa0EwckJMY09E?=
 =?utf-8?B?VDFZd3FOZmxoLzNoZElQeXB5cnF6VHNHR1l5KzRVclFPR1cyZHpRY3RIY3BP?=
 =?utf-8?B?WjRleXVUMkFqVDIrcTZiVk1xVjI0L1kyQTlpdWMxZzdEb3drWnVBODhjdjVj?=
 =?utf-8?B?QVBpY3d6Vm5vWi9ndjhING5pZmhHL1hDYjZsTVk1MzVMdVhYTXI1djNUam5V?=
 =?utf-8?B?eE0yR1YyRVQ1cDFqeDFhS1lTbHRsdGt3dDNzVU9vQ0hRU2JzWXV0c0lyc283?=
 =?utf-8?B?SGhzSVJpeXppMEhvNlN2M2N4WTRZemhrRmR6VlgyamNKQWY5ZXJQVWZBYWNZ?=
 =?utf-8?B?ZzRTWXIvZ3hDWTI4NmIyTy9UcnAxVitHOGNBSDBoZWZNWHhkQ0hEb1BDb2FG?=
 =?utf-8?B?SHgvaE0wNHJ2YWNEamRJOWtOZjcxWTZKK3ppZUdWRWFpOUdXT0V6aE5Sem1p?=
 =?utf-8?B?MnE1OWZYaGhkQzlVMlVEdVhSRGdQTkdIejR0ZFNwSm5pZEhnc2RIWEVFeDN1?=
 =?utf-8?B?dUtNMU9sZXB2djk2Yyt4VXJyQVpaRTZMeHZlUWlVbzZYN2lZUE8xM3VSVzVU?=
 =?utf-8?B?RGhLWVFOYWNjRWxzdXRpRmkxd04wYzQwajEzdFJRZkg1VEpnUTF1VURaUy9w?=
 =?utf-8?B?RjZpQzhDTno2MHJkKzNDL0szOWk3aHk3elpVenRRbm5JcnlDMXZZYmd4em5w?=
 =?utf-8?B?eXVHdzV6RzYySk0wc1NvNUF6Tkt0akVNK1I5bWxHYTVXNG92NlB3L3V2WWNN?=
 =?utf-8?B?cis5VWRrVk52elRlZmhjL21JQisxK2kzeXRCTDlLY1VrcU90LzMxUmtqUmxO?=
 =?utf-8?B?SVp6eU5yckwveFZ3N2pub0ZwNDd5clZpQS9GSVk5Qi9ITndacWJ4RE5CYUVP?=
 =?utf-8?B?SHA4RW9xM3ZGZjhnTjE2c2o1cStkbnQyKzVGMHdsVjJJQm9DQlZsbTIxRktT?=
 =?utf-8?B?U1dtaXZCTVZwOHhFUXU5R1kwOTZ4ckdsZ1NqYUd2MDNmcVFLYUFmZjJMeUt6?=
 =?utf-8?B?QldtNmp3QTNaYlpuaHJaTkhudEU3ZkZVeFh1bUxjOUN2ajJWc2hBMFBWVSt3?=
 =?utf-8?B?dFltM1RWVUc5MmhDdWh4NGd5Wjg5ZjFlMHRaU1ZCeGJqeUdac2tlOE5SeUFo?=
 =?utf-8?B?eFpvc2NUb1VaMkxaTjJnTTNxbUpmMlBFN216V1VBb0l6RjdNTjJoRkVnWFZh?=
 =?utf-8?B?QlZBT2RweWM0c29waUpwK2FjcU5zMFFmNjJZd0F1VXB5ZHdLZmVvNkt2MVp1?=
 =?utf-8?B?d25RSTk2dnliSmZqcHVXTVZUV0hvYzhkcEFoOHlCNWl6K0lEQmZWWEQwMWY1?=
 =?utf-8?B?bW5hK3BKNTR6bXNSbmZ0My9vUTNCdEJKOU5FYjQzYTArWGwwMmowTnJqcmxT?=
 =?utf-8?B?VHFwVXNJRXNVUjlCRkRhV3RaOGIxMGpGNUF1ajhvMzZuTCtQNE1teXNCYzhE?=
 =?utf-8?B?TmZpMFRRaWlkc1FPNlVLMzRQSVBUejNCTnhPNFF0b2E5U0ZRcXlkcGtYYTIx?=
 =?utf-8?B?eUQyYkt6NHZJYVR6dmlwdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RVcybjQxYVlUdVlkZjdlcCtUVDFsN25mN2ZpaXpxRGkzMUYxMUJyNFJxL1hz?=
 =?utf-8?B?MHI0MVQxOHVPWVpPRXJwc0x3YkFtRjhmK2tpNU5RVkZRRElWaTE2Uy9nQzh4?=
 =?utf-8?B?QkQ0WFZqV3MzMVNMSmZRc2EwM1BzUVk4RGtwQ1VRdHlJNkhuSXhNYU0ycEha?=
 =?utf-8?B?aFNyMzZJRmdMYlFCRWdPdHUyNzBtak5aK00xd2JoWGh2TVlHUkROSDBPMmdJ?=
 =?utf-8?B?dlNWY21va05Ed1hnY3ZHQUNuRk1oQkRvbkNHc09aK2VwbHFvcXM4YzBuNmx1?=
 =?utf-8?B?enN4Z3hRMkF2WWRqSzVWNWREdnNJRlJFUUNxNndOUTVzdGhOZDZYVnR5TW9C?=
 =?utf-8?B?S2c2ZXl5eUFXM2l0TXcvRjR4MXZud3ZwL0RFRUtkbkM2MjFBYU9KRmVpMUxI?=
 =?utf-8?B?QTdudER6aWJNbEtPYWFzaU85Ym9Rb1RqVGYyYUhyeld0MTVnTXJkeUxuMDMv?=
 =?utf-8?B?azBwVTRMK3dHNGFUQTFoMEgrRFNQNEtielU4NnZTUld6Y0F0SEJGc2xGMS9t?=
 =?utf-8?B?a1lRRGNPL2RHa3BuNXcyMDVkVEhKME5SZmdsVXNzdHpLTWlSWUs5NkpHeFhk?=
 =?utf-8?B?NENuTnBPdjIyY3pkb0pxUHlYLzFpL09kUHdRZGN3UGhZNm92bmoybWhwbC9F?=
 =?utf-8?B?TWdxVE1GNjM1RVNHcDdiZVJxdDZjVzRYQ2ttVE1TYUtTTmVCcUVmR2gvZ3Bk?=
 =?utf-8?B?VWxuK0lhTnJXS3ZuODJNRHhZNlVKMVU3dGszOFo3ZXVFdC8rNU1CeldPeng4?=
 =?utf-8?B?dUhDRTJBeXRRdWg0THpjWDBUTG9zSDZmTWQ0Z2xXZ24xbjVqK2ZqTVVUR2Vw?=
 =?utf-8?B?Q3p3OGU5Qi9IWVRBUVFxazNYdGtIZmM0cTE4YVRKeEdCSlhKSy81WU1TNlEv?=
 =?utf-8?B?ekkvQkpRckFKbndLUkNwMEw1WUR5eEhwZkkwY3JZZm8wV2d6OTFFWjNlMnNm?=
 =?utf-8?B?TUUyd0VsNWRIZk1PSXdJTW92VlB0NEpDNnp0WVFhbEU2ZjJ4bXpxWHVleDdR?=
 =?utf-8?B?VUEzK3pRQktKNW84ZHFjNEJrN1kzemhhYkYvakt6T2F4U0E3amJkM2FmTEVP?=
 =?utf-8?B?cmNSN3pkWFZUMjNoWVRnaTArNDM1TUphZVBFY296Z3RGajhZYWhnZ2duVkJu?=
 =?utf-8?B?b09ENUJGRUZ6a1hIQU5zWnovOTBmcjJacXoxbHhKUXVZeEZHL3MzZnhtUXRh?=
 =?utf-8?B?ZjhMcTZBNE1aVGhnUTdrYm13UGJGb1lUSjkvL09BYXEzcW11QXN1NFhXUVd6?=
 =?utf-8?B?aGpPTUlzdG5HQ0hBM0k4N0hKeStkRWNzeDRzQ0gvVmlKbUFIaXhLU2QvNG9E?=
 =?utf-8?B?ZkdsbGphMFpQWU5jZllmM0p2WTE3VFBDRFBwbVVTUGhncTgwdUVRV1IxSFI3?=
 =?utf-8?B?YTZWNFBrRmFxT2NwdnFhSm5RWnNCVkFVRFVLN0k3eHQyRDRML2p0aEs4eldL?=
 =?utf-8?B?bnJoSStvcm5rMExiR2pzK1psM2xYQ2RRRmdQYytOckwrdSsxQ2FUYzJha1g3?=
 =?utf-8?B?WmRIL280T3FwRk42V1ZPRWVIUWhDZVQwN2QvWUpJd1pESlNmOE9VWlUrZDdN?=
 =?utf-8?B?M2RtcHA3V1JZK1hMZnFXRWI0RitaRzB6TGY0emdXQTFmckJ5YmtmZnlDTGVx?=
 =?utf-8?B?R1R1ay9weW1aeUJrSDFsTFlWNHlvek9vaW02QWR0dlhrNHNaV3RJK0dNTGlV?=
 =?utf-8?B?eGpnN0hLWHhaWlBSVmpQTWZLaFFBNm15c0E3eS85M0R5VUNLV0wzdVhEbWFX?=
 =?utf-8?B?eFFHOUxiTFhDR3BXK0x4dXZGSkRUTVQwYWg2WDhwTGZDSjhTMjd4QS9uQ0lY?=
 =?utf-8?B?MVhKZVB3ZTlPdUx1ekV5SnN4U3hOenBPSkg0M05ZRUo0SnVBNDFlUVZjK292?=
 =?utf-8?B?NnN2SE5sSjV2NTIxcGFlckJCNDk0MGdWZzMvZm1tanlPMDdXSnlKQXFueDZh?=
 =?utf-8?B?WTZIZ2JOa1cwbWk5emRTb2wxSmVhN0xGaW5acjBCY0Fhc0FHai9EaEpPeG5J?=
 =?utf-8?B?MGVGcTBJZEFGU1grRkZNWDFuYmFSL2FscTQzUDVEbWJRTDZwZm9mQW9kTkxh?=
 =?utf-8?B?Z0dkL2JTSFBPUVRqN2d1TFVYNnQ0QU5ydHZHZmhZR29NcHlSMitJSk5KM2Rj?=
 =?utf-8?B?RXJQOUYydkRYZFpKSGlRRWNzTkNrZnRqU0huVkZJTFkweHlMazZNa0s5Nnpk?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C55033F44C0FDB489B789D841E46F78D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6k1dwcy3qhGGOrC+FS5OvuiRIJgdZkvbK9C2RTKBPbi4ezHQk2nK3bosKNmKUYwOlcG55j9LJSTCRf3PoUbdmsO4Kq0DDC/VBRXxOiNJQtnwqWLY+kVgQ3Pb4RzbsW5rNx771j88VArY/RZlvyJsQ7Q/nuQUTOENMJn1HjlSzF0JLmfQJmcENZ7Tf+PiYjk63GPVwCiKZVjCVO6sYBcBJzbaUK+mAih1cwPyVUcZhkJYmf/ncgxzFSwKdU6Cg0saW5oLAiFhTx27uoa1EYC+wmhSFEpAo3jRsenqI7ipCmIuBrQN0VF/LYK71efScjtnhul3j7/+q1wbRdP0XQxfcf2v21+HZBc0ySoRMNM7SXri2d6QRFF1qx6Rc0Rm/wg4U7FslPlT1/R5fV+riW+P3uORTq+tlMhixiORmccHx/1gJb/ym939Fq8QMfjoR0O/kqTKp6fqKlnMbjmB0mW5LSFnWE1Dzng2PIb51QsVZvwXHjF+Jj/DV9VyOycocidYXwGsCmnaJeLVIuuo3xTNhBeBrbt2cAURq6XFjWTTYseaxeOhvHNKU9X9yJrpHKAelPZf6SZNXmERDz7gOkNEGBwLm9wq90nJE89+eSN6DjU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b590855-ed76-4404-2fed-08dc7e62391c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 15:32:30.9472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 760kG1yYw3knzx/wKZgTbjZMYmcO3vzCuDXaVvBYPhDv1EvjQ7lUn2gUejAiloMq+ghZAuIYKSCBTYVQkLsDRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405270127
X-Proofpoint-GUID: ASpHaRtsmA47-tkkykjLsQRiNsLsh79p
X-Proofpoint-ORIG-GUID: ASpHaRtsmA47-tkkykjLsQRiNsLsh79p

DQoNCj4gT24gTWF5IDI3LCAyMDI0LCBhdCAxOjE14oCvQU0sIGdhdXJhdiBnYW5nYWx3YXIgPGdh
dXJhdi5nYW5nYWx3YXJAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEhpLA0KPiBGYWNpbmcgb25l
IG1vcmUgaXNzdWUgd2hpbGUgdXNpbmcgcmVmZXJyYWxzIHdpdGggUkRNQQ0KPiBJZiBSRE1BIGlz
IGVuYWJsZWQgYW5kIHN1cHBvcnRlZCBvbiBib3RoIGNsaWVudCBhbmQgc2VydmVyIGFuZCBJZiB3
ZQ0KPiBtb3VudCBwYXJlbnQgd2l0aCBUQ1AuIFRoZW4gcmVmZXJyYWwvc3VibW91bnQgbW91bnQg
d2lsbCBiZSBkb25lIG92ZXINCj4gUkRNQSBpbnN0ZWFkIG9mIFRDUCwgc2luY2UgZm9yIHJlZmVy
cmFsL3N1Ym1vdW50IG1vdW50IHRoZSBjbGllbnQNCj4gdHJpZXMgd2l0aCBSRE1BIGZpcnN0IGFu
ZCB0aGVuIFRDUCBvbmx5IG9mIFJETUEgY29ubmVjdGlvbnMgZmFpbHMuDQo+IA0KPiBBcyB3ZSBj
YW4gc2VlIGhlcmUgcGFyZW50IC9ob21lICAuMTYwLCBtb3VudGVkIHdpdGggdGNwLCB0MSBpcw0K
PiByZWZlcnJhbCBtb3VudCBtb3VudGVkIHdpdGggcmRtYQ0KPiANCj4+IC9yb290L3RjcC1tbnQx
IGZyb20gMTAuNTMuODcuMTYwOi9ob21lDQo+PiBGbGFnczogcncscmVsYXRpbWUsdmVycz00LjAs
cnNpemU9MTA0ODU3Nix3c2l6ZT0xMDQ4NTc2LG5hbWxlbj0yNTUsaGFyZCxwcm90bz10Y3AsdGlt
ZW89NjAwLHJldHJhbnM9MixzZWM9c3lzLGNsaWVudGFkZHI9MTAuNTMuODcuMTU4LGxvY2FsX2xv
Y2s9bm9uZSxhZGRyPTEwLjUzLjg3LjE2MA0KPj4gDQo+PiAvcm9vdC90Y3AtbW50MS90MSBmcm9t
IDEwLjUzLjg3LjE1NzovOmhvbWUvdDENCj4+IEZsYWdzOiBydyxyZWxhdGltZSx2ZXJzPTQuMCxy
c2l6ZT0xMDQ4NTc2LHdzaXplPTEwNDg1NzYsbmFtbGVuPTI1NSxoYXJkLHByb3RvPXJkbWEscG9y
dD0yMDA0OSx0aW1lbz02MDAscmV0cmFucz0yLHNlYz1zeXMsY2xpZW50YWRkcj0xMC41My44Ny4x
NTgsbG9jYWxfbG9jaz1ub25lLGFkZHI9MTAuNTMuODcuMTU3DQo+IA0KPiANCj4gQ29kZSB3aGlj
aCB0cmllcyBSRE1BIGZpcnN0LCBjYW4gd2UgZ2V0IHRyYW5zcG9ydCB0eXBlIGZyb20gcGFyZW50
IGFuZA0KPiB1c2UgdGhlIHNhbWU/DQoNCllvdSBjb3VsZC4gSSB3YXMgZ29pbmcgZm9yIHdoYXQg
U29sYXJpcyBkb2VzIC0tIGl0IHRyaWVzIHRvDQptb3VudCBhIHJlZmVycmFsIHdpdGggUkRNQSBm
aXJzdC4NCg0KU28gSSBjYW4gdW5kZXJzdGFuZCB5b3VyIHVzYWdlIHNjZW5hcmlvLCB3aHkgZG8g
eW91IG5vdCB3YW50DQp0byB1c2UgUkRNQSBmb3IgZWl0aGVyIHRoZSBwYXJlbnQgbW91bnQgb3Ig
dGhlIHN1Ym1vdW50Pw0KDQoNCj4+ICNpZiBJU19FTkFCTEVEKENPTkZJR19TVU5SUENfWFBSVF9S
RE1BKQ0KPj4gDQo+PiAgICAgICAgcnBjX3NldF9wb3J0KCZjdHgtPm5mc19zZXJ2ZXIuYWRkcmVz
cywgTkZTX1JETUFfUE9SVCk7DQo+PiANCj4+ICAgICAgICBlcnJvciA9IG5mczRfc2V0X2NsaWVu
dChzZXJ2ZXIsDQo+PiANCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPm5m
c19zZXJ2ZXIuaG9zdG5hbWUsDQo+PiANCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmY3R4LT5uZnNfc2VydmVyLl9hZGRyZXNzLA0KPj4gDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY3R4LT5uZnNfc2VydmVyLmFkZHJsZW4sDQo+PiANCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBwYXJlbnRfY2xpZW50LT5jbF9pcGFkZHIsDQo+PiANCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBYUFJUX1RSQU5TUE9SVF9SRE1BLA0KPj4gDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFyZW50X3NlcnZlci0+Y2xpZW50LT5j
bF90aW1lb3V0LA0KPj4gDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFyZW50
X2NsaWVudC0+Y2xfbXZvcHMtPm1pbm9yX3ZlcnNpb24sDQo+PiANCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBwYXJlbnRfY2xpZW50LT5jbF9uY29ubmVjdCwNCj4+IA0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmVudF9jbGllbnQtPmNsX21heF9jb25uZWN0
LA0KPj4gDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFyZW50X2NsaWVudC0+
Y2xfbmV0LA0KPj4gDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnBhcmVudF9j
bGllbnQtPmNsX3hwcnRzZWMpOw0KPj4gDQo+PiAgICAgICAgaWYgKCFlcnJvcikNCj4+IA0KPj4g
ICAgICAgICAgICAgICAgZ290byBpbml0X3NlcnZlcjsNCj4+IA0KPj4gI2VuZGlmICAvKiBJU19F
TkFCTEVEKENPTkZJR19TVU5SUENfWFBSVF9SRE1BKSAqLw0KPj4gDQo+PiANCj4gDQo+IFJlZ2Fy
ZHMsDQo+IEdhdXJhdiBHYW5nYWx3YXINCj4gDQo+IE9uIFR1ZSwgRmViIDI3LCAyMDI0IGF0IDY6
MjLigK9QTSBnYXVyYXYgZ2FuZ2Fsd2FyDQo+IDxnYXVyYXYuZ2FuZ2Fsd2FyQGdtYWlsLmNvbT4g
d3JvdGU6DQo+PiANCj4+IE9uZSBtb3JlIGlzc3VlIHdpdGggcmVmZXJyYWwgY29kZSBpcyB0aGVy
ZSBpcyBubyByZXRyeSBvbiBjb25uZWN0aW9uIGZhaWx1cmUNCj4+IA0KPj4+IEZlYiAyNiAwMTo0
OTozMiByYnQtZWw3LTEga2VybmVsOiBuZnNfY3JlYXRlX3JwY19jbGllbnQ6IGNhbm5vdCBjcmVh
dGUgUlBDIGNsaWVudC4gRXJyb3IgPSAtMTExDQo+Pj4gRmViIDI2IDAxOjQ5OjMyIHJidC1lbDct
MSBrZXJuZWw6IE5GUzQ6IENvdWxkbid0IGZvbGxvdyByZW1vdGUgcGF0aA0KPj4+IEZlYiAyNiAw
MTo0OTozMiByYnQtZWw3LTEga2VybmVsOiA8LS0gbmZzNF9nZXRfcmVmZXJyYWxfdHJlZSgpID0g
LTExMSBbZXJyb3JdDQo+PiANCj4+IA0KPj4gSSB3YXMgZXhwZWN0aW5nIHJldHJpZXMgZnJvbSB0
aGUgY2xpZW50IGlmIHN1Ym1vdW50IGZhaWxzIGlmIGl0J3MgYSBoYXJkIG1vdW50IG9uIHBhcmVu
dCwgYnV0IGl0IGZhaWxzIHN1Ym1vdW50Lg0KPj4gSSBjYW4gdW5kZXJzdGFuZCB3ZSB3aWxsIGJl
IHN0dWNrIGluIGEgbG9vcCBpZiBmcyBpbmZvIGlzIG5vdCB2YWxpZCwgdGhlbiBjb25uZWN0aW9u
IHdpbGwgYWx3YXlzIGZhaWwuDQo+PiANCj4+IFJlZ2FyZHMsDQo+PiBHYXVyYXYgR2FuZ2Fsd2Fy
DQo+PiANCj4+IE9uIE1vbiwgRmViIDEyLCAyMDI0IGF0IDc6MjPigK9QTSBDaHVjayBMZXZlciBJ
SUkgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IA0KPj4+IA0KPj4+
PiBPbiBGZWIgMTIsIDIwMjQsIGF0IDEyOjUx4oCvQU0sIGdhdXJhdiBnYW5nYWx3YXIgPGdhdXJh
di5nYW5nYWx3YXJAZ21haWwuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IEkgdGhpbmsgSSB3YXMg
dXNpbmcgYW4gb2xkZXIga2VybmVsIHZlcnNpb24gb24gYSBjbGllbnQgd2hpY2ggZG9lc24ndCBo
YXZlIHlvdXIgZml4Lg0KPj4+PiBJIHRyaWVkIHdpdGggdGhlIG5ld2VyIHZlcnNpb24gdjUuMTAs
IGl0IHdvcmtlZCBmaW5lLg0KPj4+PiANCj4+Pj4gVGhlIG9ubHkgaXNzdWUgSSBzZWUgaXMgd2Ug
YXJlIG5vdCBpbmhlcml0aW5nIHBvcnQgZnJvbSB0aGUgcGFyZW50IGluIG5mczRfY3JlYXRlX3Jl
ZmVycmFsX3NlcnZlciwgc28gZXZlbiBpZiBJIHVzZSBwb3J0PTIwMDQ3IGluIG1vdW50IGl0IHdp
bGwgdHJ5IHJlZmVycmFsIHN1Ym1vdW50IG9uIDIwMDQ5IG9ubHkuDQo+Pj4+IA0KPj4+PiBycGNf
c2V0X3BvcnQoZGF0YS0+YWRkciwgTkZTX1JETUFfUE9SVCk7DQo+Pj4+IA0KPj4+PiBXZSBjb3Vs
ZCBpbmhlcml0IHRoaXMgYWxzbyBmcm9tIHBhcmVudD8NCj4+PiANCj4+PiBUaGUgY2xpZW50IGlz
IHN1cHBvc2VkIHRvIHVzZSB0aGUgcG9ydCBudW1iZXIgaW5mb3JtYXRpb24gY29udGFpbmVkDQo+
Pj4gaW4gdGhlIHJlZmVycmFsLiBUaGVyZSdzIG5vdGhpbmcgdGhhdCBtYW5kYXRlcyB0aGF0IHRo
ZSB0d28gc2VydmVycw0KPj4+IHdpbGwgdXNlIHRoZSBzYW1lIGFsdGVybmF0ZSBwb3J0Lg0KPj4+
IA0KPj4+IFVzaW5nIGEgY29uc3RhbnQgaGVyZSBpcyBwcm9iYWJseSB3cm9uZyBmb3IgYm90aCB0
aGUgVENQIGFuZCBSRE1BDQo+Pj4gY2FzZXMsIHRob3VnaC4NCj4+PiANCj4+PiANCj4+PiAtLQ0K
Pj4+IENodWNrIExldmVyDQo+Pj4gDQo+Pj4gDQo+IA0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

