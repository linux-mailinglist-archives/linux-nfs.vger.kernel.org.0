Return-Path: <linux-nfs+bounces-2946-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AA08AE7BC
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 15:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94511C22BAB
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 13:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69AE134723;
	Tue, 23 Apr 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iKAmbQTn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u71R/sDC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05BB12C528
	for <linux-nfs@vger.kernel.org>; Tue, 23 Apr 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878146; cv=fail; b=Kb6GUAVoTAdVyK3AitVJCoX3DZj0Itf0ArFmNxx3HsrUFs3Ph7ZBtrOIUqha5+vXq8KnzLmfD81xgosdlRLVF85jwmYAkEmLxGuUf4vvit+rC6ue63ryF+oAe3wmTYn3R5QoxwgJh7Ia56s8pNSzthtmMzKFSeRbPx/pJ/tmDjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878146; c=relaxed/simple;
	bh=aA41MRphHkIT598IPU6iFn4R3gyckaSmFPiQfB0/K2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KkyrzehfVJgEjWkLBHwQj9/kJ4QpNEA6g9fdsUi5twVcbExDr3mErqy8g51iRtVdmAIs4MW1gHCInCnm5r3MalxRBDFgRRyVXnRI1CZGIC6wKXYKj5sEogE/aUy9LHbc1o0hYIWCGUuhOn1rEGZpDd6CsqURCDK022dmljh4p2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iKAmbQTn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u71R/sDC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N7ZFGn004894;
	Tue, 23 Apr 2024 13:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aA41MRphHkIT598IPU6iFn4R3gyckaSmFPiQfB0/K2w=;
 b=iKAmbQTneMZopUu1tHjPmCVA0vGUmnIORmmDCfYxhtSP30aI5DWlHzrkBpuLBecSqhsK
 ijtzflUrFy/J5m4pU6D1VKo1asfUc8Ue29P9XJ6wI/2htQax2afcOpBODOR2ow+HJGuS
 mVsxII5xbKLnZu0N1nOwLdeO+HExLFPZWczNE7RaYXaG86xaL/euactwKjegkzv1rkjo
 L4SYTWzU2shpcA+OAJ0pbY9QGWmh5xPUNj3Xx4fwI7L+Z3mhEoJ3aWbVRer+iDK2p/k3
 5rvGevhmwwrqawI3ZxxQM0GrrW2T4LyuCmxzUhXzYaiz5tX7BCIsoJl2UpdqVD0m5GLt sQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md5q87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 13:15:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NCI7Pd035535;
	Tue, 23 Apr 2024 13:15:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm4576r55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 13:15:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqHwM7KqN1yGM8RNQZhcMZQzv/7HEzQhHkMYl5veqTdxzu8siksxupkkSdhn6MxSa8BaIvwGw7+5FZEbJY98ZFFBw6agfTM4jH0mXJGBSTnaQoQv7h6Sc2oGKEagpqO8YCW1mXteelroC3RWao4kkokEfrBJbfq30PsJgV2hFm/Z7CmpTPzh9goBFagczFgUxAlrzRq2hH/e7b6+2nk/3ODd18kwcCnMavTtMpugk3MlfwhM1criw0YTPtOLyGAEfxRk+o3pVVG47LkA1NgMkptDZ8FcJx+oKgb4Wjb4b1zEDih56kfj8JNnzwPXLc1g8CdRp7Xz5uIzrC0PCF0MZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA41MRphHkIT598IPU6iFn4R3gyckaSmFPiQfB0/K2w=;
 b=Np31y64c+ziPKBxcnpWMDTKs2CS49zREnpgVq2FVWi986cu4e5vXZ1tyszErWBNcgS7C3JYYBmn1cu9F4SoC4Qr8HLWyiNmNO3OQfWA9KzHgnO4opygctGksypU/wIyhbRTNMxs/citYAePC5ofKed6a+i16m1jJ3VrKUCX6U8sgW2u1CokJduQHrYZVgSHCEgzyUN9fAmKqZ323gcB1Qn2gSRco1l4Td4QtfFgITtfaNBvTk6EXXHD8qSnWhOsFWACW5RYgpxDSowXEFVCHggJoE179wGuwN0p11HJ6qLQo+MCXs4eFd/VexVkI22o91r78A0k4XVLeJlKcHiN4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA41MRphHkIT598IPU6iFn4R3gyckaSmFPiQfB0/K2w=;
 b=u71R/sDC8wZbKejp+3CCByxTZTUua6ioPlbyDb3+sTQfyeA+Gswg+/SDAneNiaGZc9RkpyfUHYWwflO6c1A7NiNsvmGJIDEfXRksjk2LjqvQ3Y1eU/cuEDUTDUdfMiUbwrrDMeKs6DbxsWxf65ad+XuQDG4Z/6ktlq9HbuX60zk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7358.namprd10.prod.outlook.com (2603:10b6:208:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 13:15:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 13:15:16 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>, Dai Ngo <dai.ngo@oracle.com>
CC: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <kolga@netapp.com>,
        Tom Talpey <tom@talpey.com>, Petr Vorel <pvorel@suse.cz>,
        Linux NFS Mailing
 List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't fail OP_SETCLIENTID when there are lots of
 clients.
Thread-Topic: [PATCH] nfsd: don't fail OP_SETCLIENTID when there are lots of
 clients.
Thread-Index: AQHalFoqrNEJoJmc9EOjZgR5U3sc6rF0Su+AgACnZgCAAOV9AA==
Date: Tue, 23 Apr 2024 13:15:16 +0000
Message-ID: <62B41B1D-0A9C-44B5-8EC3-962AC862EFB7@oracle.com>
References: <171382882695.7600.8486072164212452863@noble.neil.brown.name>
In-Reply-To: <171382882695.7600.8486072164212452863@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB7358:EE_
x-ms-office365-filtering-correlation-id: 4b86b7ac-0ce7-4686-aee6-08dc63976b01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?d0hpem4wOUlqVFNPSGNXZUdodDhLOXVOR2pmYTRaQ3hkM2ZjWUZsU0xOTDkx?=
 =?utf-8?B?clJXQmxJVU1yVFZVc044OXRFbW9OcmE2d3diRzc1MjZ2KzNDSTA1U04wbHFn?=
 =?utf-8?B?RzBjWk0vdmJJUEY2SW1NV3FBN0p4Mks1aVBtOVdUR0xFd0dZZjBnZ2tRZ2x2?=
 =?utf-8?B?Skd5YWo5MmdHR3o5dlczN3Z6cm9vT0FLSVJ2aFBOWVQyVG9BWWIzWXByRlJm?=
 =?utf-8?B?QkdIc2hnQkZlamNmN0haak9yVXZlN2V5NFZtaE9CWXNYRUdtNTFwOHN3Sjh2?=
 =?utf-8?B?M2ZOUEl5NkdIWDFrRWtWRzFIYXZVamZrRk1iZjBlSlAxTVlMMEJqUmd5andJ?=
 =?utf-8?B?d3NsS0ZFZTZXNEYraURDclhzbTFRNzV5Y0ttSlZFSStjRVFSWlFyNWpqMzBI?=
 =?utf-8?B?ZHZmRmZVb1ZndkQ4TzZtY25JZy90NUhOYW5OYjNLV29TZ2t3Y25Vd3k1ZUt0?=
 =?utf-8?B?QjROOVY3QW12RDZ1NEdUd1NCUUtMZEZ0aG9kT2plVlJXZmQxekU2Y0kxdUZP?=
 =?utf-8?B?ak9idTlJRStRRlc2WVNpSFB1dkJlbWNYZ1NUSnhYOHczYmtHQ2VBUmRRMTFL?=
 =?utf-8?B?N1NkMmhqa1A2K2twdDJiL05udmRJN3AxQzA3Tkw0bFBTZEFBcU1ZT0N1eWZJ?=
 =?utf-8?B?Nys0b1ViZGdWZno1Nk5ZWlp5NU91Skt4RXF5UHVGOTZBaXB0RTZqSTFscmxH?=
 =?utf-8?B?N0IxNWJwL2E1MDJxS0pYcWtXT1NSc2xQN1hpaHNPVkI0Vm9kSG1XTVJNaGxw?=
 =?utf-8?B?OS9hWjZEdm5jRTk0Ujk1SE9NMGVwYnozSHdTcEJaNTBKWFdBUnE5VWt5YjJz?=
 =?utf-8?B?NHZJWlBVcVA3ZS8rRTh2VmVKUXZaRklSaExFWEEybytDVXYrckVUUFRHdE5X?=
 =?utf-8?B?dnBlZHZmeXl0dTcwNkloKzJtTmQrM25pYlRtV0JqbG1YL2xNcERRMUhWQmg0?=
 =?utf-8?B?NldickxGRm1aTGlxWDdiNWNKUWE2T0pvL0x6NkkrRFBhVnVqckJsbzdFRVBP?=
 =?utf-8?B?QkIwelZSTmFoY1N1dnYvUkNnUkplYk5JM0ZNQVVLVGZlTjFzS1BaOTFlRFVP?=
 =?utf-8?B?ZXBCQU5yUmJNZ0UvZ1ZvVUNsYUFOR2QrT2dVaFJsU0VlRjlxR1FYUDRqVjQr?=
 =?utf-8?B?RlF3VFFuNUNKTjNmak1qMkkyYzRSQ1FmbFJmOXZSWXIwbzRzMDJyb2g0K1k0?=
 =?utf-8?B?dldNYnNUa0hScDdSOENBcE1NeUprVm9veU9Idnp3WkdNZEZzRXQ0b0pUbXZm?=
 =?utf-8?B?Mnp2U09ZdXo0UnNqNEZ6TGVnNXU2Q29xTlQwWDVqcHNpeUFBcTIvdE1HOE9P?=
 =?utf-8?B?eUQ1eXcwTWFObG92czZvaklpWXRZMjhweTRqVTBESnRJSFAxKzUyVW12ZHA1?=
 =?utf-8?B?ZTJxUEMxS2xydDVWaEo0TkxEYzFuRlBQODZhZWNWTHNJOXJ3YytGbWFUdVdi?=
 =?utf-8?B?bkVkWllvNXV6SXc2SUttQzYvL1llY3B0MUJBOGZrTDl5OHpzYjAxd2FmRkli?=
 =?utf-8?B?ZVJQZ1VWZEkyYVovMVc2cm9iT09MckprOEdqSm1qM0pKVUg3K0o4a0NZOWhC?=
 =?utf-8?B?WWVHUk5WM2RxaHF3T1psU1J2SXNhMjRmMFBEK2NFdUpSZm9kUUNmbHpGS0Rh?=
 =?utf-8?B?MjhhVXIwMzBVMXNVb1BNNmlwbzFVNUhHWGF3VlkrQi9OeE1BVzk4N2h3MzVB?=
 =?utf-8?B?bGRRYTJScUxoNERaZ25oK2dRUEo5Zld6RDVoekhVbzRETjNZSmkzMUsvWEMy?=
 =?utf-8?B?YTYybFA2cjk5eXplNHV4QzJWek9DQS9nUmlvNVZvYlNTNGd5Wjc5VUxudlBC?=
 =?utf-8?B?MlZOcVdQWUJDR2hyOHQ1dz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bENtMEJnSUV6cmkvQUNBQWxUTEUvK0lNaW9hdXlOSmY0SmtkNFJSMExXK05w?=
 =?utf-8?B?clFQbmtoZ3lVa0d5YWtqRUZLcjdkd200bnVHL29zVi9BbEJoQnlRbTc4OExv?=
 =?utf-8?B?VnBBYi9FbW95Ymk3anhWQzVGa2w3RWp2aTdPSjFuWUVkQlg0ckoyQ0lhZVYx?=
 =?utf-8?B?MFRqQ3VtazZSQ0x6Wm9aVDVQZ0wraWZOVVZvQUlubXRta0dIc2dKQ0RjK1lu?=
 =?utf-8?B?SUM4aWNxdEliYVAwOXNQNFVCQ21oNkFGTmNFWS85bUJoc0FwUFFkQzZBYzZV?=
 =?utf-8?B?aEZZNU9EUzdtaE5lNGN4VVVMRllCT2NMbThuc3oybXF2OVdyNTBCcHVWMERj?=
 =?utf-8?B?OEcxQmp5Wkl5c3c5WFVHREpIMlprc1grTXdraEFaNTlVSmVPZWU0RTZJYnIy?=
 =?utf-8?B?K0FVMzdaSWEybWNhMVV1cng2aUw1S3lRcFVEcE5kcXJzZ1NLSThHTFJJalRH?=
 =?utf-8?B?Q21DQU5leDV2c2VhUnYrZXFUbmo3bkhjS2svZ0hEMk5hSFN0VFNLZXpSeUVn?=
 =?utf-8?B?YWp6VXZPWnhMUWVLU2c2Qk51aG1mOER6d2Z3YWdtM3d3amtHbUh5WVU2YVZN?=
 =?utf-8?B?UmJCb1VXZU1wQVJJSGZoN2lsMEhwdE1NYUZNTkJ3MlVKT2tJUm1LNWFac0tE?=
 =?utf-8?B?SjlZdGQ4UkpqQ3U4VHpKTjZkUnBBQ0JIMEdka2tESW4vOEhtbWhPWnMzb09w?=
 =?utf-8?B?YXJDOXBDSVEveklKQnZwUE8rU2llbnY4UUl0eENLNW9YQy81UWZuSGRBbU9t?=
 =?utf-8?B?N0Roek9RRER5b1ZZeFJCVmFVQk1qZUVlQ1huaVNISkg3dnkwT011UXZWSXlz?=
 =?utf-8?B?WTZhT2xuUE5ZTjNQRWJ1N0RPQWFLY3dQZWVZNW91TG1ZQmFlOVFiSitHaVV1?=
 =?utf-8?B?M3NVekhvVHh3aTBDMFNGd09NQ3JDUi9NM3ZYazJqaGdWRzEyY1BOZW9tRnJz?=
 =?utf-8?B?dFg4N1g3Z20xYWg4R2VsNktUY1l5UnFiNmd0aXZGZUZGWlh1Y3R1MEJ4ZUc0?=
 =?utf-8?B?VWg5UlYvZHpVWkhMUm9LQW95RmF2ZkVJVTBPY2JrbzFPS0p0VkhDVXRINWxm?=
 =?utf-8?B?SkdNR2o5OGlkd3h2UGFEakdlVTQ2VHFSNzRvaE51amtBSGxQU1ZET0dHK20z?=
 =?utf-8?B?RzFnZnJVTUI3RkFwN0RpSCswR0duY3dpdHJpUHJuQ0VTTUU1YU9tK3Z6bUFD?=
 =?utf-8?B?M1dtVE5TRjl5bWpFKzdyTkdoQU9LbmJESnRuQjhodTNYekVxNTd1MGlEQVp6?=
 =?utf-8?B?QkF3d2RFZkRXRWpaT1BVaTMwNzl6QjRDN1hSdmNOUWR0V1hzbnI2VnM3S2Ni?=
 =?utf-8?B?WmlvY2tmcjBvaTk3QWNMUFhjSS96dThuZ1REOHF1SE9xR3pFS0J6OGVBZHNR?=
 =?utf-8?B?ZGRESEZwTWQ1TXJaR1ZXN0I4cjRrMWJVS3pVWVc4UWhacFlIak1VMGN6ZWov?=
 =?utf-8?B?T0NaTHRMVjluK0FHaGFGRUg4L2ZMblh4bDJ6VkNyTDJVQjQvNGk2cFVkeUpJ?=
 =?utf-8?B?ODdjck5HVFNNMERnUmo2aG1Ld1hmVk9nRlhGZkcrZVk2dHZRNVNxRSsvQ2lG?=
 =?utf-8?B?VnBUNGRFaDV6cUtoQ1J5TzBqWm9abytYRWhXc3hRSmlaMk5xZkFXZ0JvY2JR?=
 =?utf-8?B?OFlHMnVrVC9iUjJCSmM5aEx0bUNTNzlTNXI5TnQ2VzQvUWtXVjlQekFTYTNI?=
 =?utf-8?B?UWUwZ3hFak9PSFNYdE9hVmpBdFJTenc2QjA5MjFaUzJVVWJvYW1IU1ZXN2Ny?=
 =?utf-8?B?S1N1eTRCMWhHaG1HVE1iZmRxZ04va2JISUdOWDllalJ3OEI2RVNaTG5jOFhh?=
 =?utf-8?B?MW4ySXY2bFdUdkFLM0k2NHNMNkx6MlR3bEswdGVCaUVtOFZGMWJUOXJCTktM?=
 =?utf-8?B?cUhoWnlxQUFlWXhQMEZqcVpUZGI0YkcwTE9EbVphaXdLK0NOTzNKWGtVR1lX?=
 =?utf-8?B?R0k3cDRKTHB0dHdXVjR1bEF4Y2hwY0lZaDIrOWpnbUcrVk5iNGNKdDE1MFVM?=
 =?utf-8?B?dEpzWHF6ZldRZTI1R1JHcUkwd3E3VXh2T3Y1YWRxUklNcDl1T0JLdkVrY1RM?=
 =?utf-8?B?K3JZVGhQNzFIYlVDa3BCdGZweGlldGdPS0tVMlMxQmNLVFlhWGRnZGVSci9X?=
 =?utf-8?B?OENRazZPNzZUMkYwSHlZWWJJYkcyRlgwVjZlNU5UVnhTb1JIUmZtVlRKdzBT?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD8894DA20121349BAA62B126A247B6E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Jkor/Y5HFODCPRrZrhHfp+ZJ1bKb/iqFetUESTSf0lsuR/mLDp25IL8EN38BlQCP5SA0U9Sv5iYHkdKl/up2PaAqdxEeBdsbWeuuqJ8PGxYIySylAr064a+W2+84zwe9DHavhpNstE36YyCzGoitRSmZ2lE1cPqtBjWtsYq8YuftezMQR/DkZIY1dQ7bL/nbssaZmCqJ5/KjBfzDwEIG3DuN3o7N+imoM+L42Pw6nTv9LZk9zqvT/6WK0JaBiqhm75vjBE/1a1pXZHErusLM8Aeza18QL9zGyeatuvM1NuGwEFA01QUNatUppjK+TJZiMqEWAQ7nwH5Qs1xCDW5eSCaBGVkpsCG+pTDeYfxCwhGxTeIIxFTRqbsGxNEjvqxUFjuj6swgU1BEpr0fS+eptP89YC8oWJckt9nu7OmuEKA6p97ItnDiimloXGrVY6vaZ5krftNA8buCAVUb5RPKMhE0iI/lQDOVzIwsX7Wyh0qtTf2rL+R9661n7uW27juT9krtGm9CWhrhr9uztD4dYBwkqLPXAOPEbd5E/D7dTIC5AJfl8I/K+RbWBW1pH+Yo07uXIfb0/cAEgIlsvJot4hhVpgo2paGaRy8B78sPjAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b86b7ac-0ce7-4686-aee6-08dc63976b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 13:15:16.5803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VN4QKPTAfRkE2qr4cgkPvX01cVTnkQv/1KFHWRWx7BIDT1dA1k0C2kQfwhGj0RgR3ljodoajU08gErYXsZXxcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_11,2024-04-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230033
X-Proofpoint-ORIG-GUID: tgbWpVbjKDNPfdO9YwESB03XmTPlcJd4
X-Proofpoint-GUID: tgbWpVbjKDNPfdO9YwESB03XmTPlcJd4

DQo+IE9uIEFwciAyMiwgMjAyNCwgYXQgNzozNOKAr1BNLCBOZWlsQnJvd24gPG5laWxiQHN1c2Uu
ZGU+IHdyb3RlOg0KPiANCj4g77u/T24gTW9uLCAyMiBBcHIgMjAyNCwgQ2h1Y2sgTGV2ZXIgd3Jv
dGU6DQo+Pj4gT24gTW9uLCBBcHIgMjIsIDIwMjQgYXQgMTI6MDk6MTlQTSArMTAwMCwgTmVpbEJy
b3duIHdyb3RlOg0KPj4+IFRoZSBjYWxjdWxhdGlvbiBvZiBob3cgbWFueSBjbGllbnRzIHRoZSBu
ZnMgc2VydmVyIGNhbiBtYW5hZ2UgaXMgb25seSBhbg0KPj4+IGhldXJpc3RpYy4gIFRyaWdnZXJp
bmcgdGhlIGxhdW5kcm9tYXQgdG8gY2xlYW4gdXAgb2xkIGNsaWVudHMgd2hlbiB3ZQ0KPj4+IGhh
dmUgbW9yZSB0aGFuIHRoZSBoZXVyaXN0aWMgbGltaXQgaXMgdmFsaWQsIGJ1dCByZWZ1c2luZyB0
byBjcmVhdGUgbmV3DQo+Pj4gY2xpZW50cyBpcyBub3QuICBDbGllbnQgY3JlYXRpb24gc2hvdWxk
IG9ubHkgZmFpbCBpZiB0aGVyZSByZWFsbHkgaXNuJ3QNCj4+PiBlbm91Z2ggbWVtb3J5IGF2YWls
YWJsZS4NCj4+PiANCj4+PiBUaGlzIGlzIG5vdCBrbm93biB0byBoYXZlIGNhdXNlZCBhIHByb2Js
ZW0gaXMgcHJvZHVjdGlvbiB1c2UsIGJ1dA0KPj4+IHRlc3Rpbmcgb2YgbG90cyBvZiBjbGllbnRz
IHJlcG9ydHMgYW4gZXJyb3IgYW5kIGl0IGlzIG5vdCBjbGVhciB0aGF0DQo+Pj4gdGhpcyBlcnJv
ciBpcyBqdXN0aWZpZWQuDQo+PiANCj4+IEl0IGlzIGp1c3RpZmllZCwgc2VlIDQyNzFjMmMwODg3
NSAoIk5GU0Q6IGxpbWl0IHRoZSBudW1iZXIgb2YgdjQNCj4+IGNsaWVudHMgdG8gMTAyNCBwZXIg
MUdCIG9mIHN5c3RlbSBtZW1vcnkiKS4gSW4gY2FzZXMgbGlrZSB0aGVzZSwNCj4+IHRoZSByZWNv
dXJzZSBpcyB0byBhZGQgbW9yZSBtZW1vcnkgdG8gdGhlIHRlc3Qgc3lzdGVtLg0KPiANCj4gRG9l
cyBlYWNoIGNsaWVudCByZWFsbHkgbmVlZCAxTUI/DQo+IE9idmlvdXNseSB3ZSBkb24ndCB3YW50
IGFsbCBtZW1vcnkgdG8gYmUgdXNlZCBieSBjbGllbnQgc3RhdGUuLi4uDQo+IA0KPj4gDQo+PiBI
b3dldmVyLCB0aGF0IGNvbW1pdCBjbGFpbXMgdGhhdCB0aGUgY2xpZW50IGlzIHRvbGQgdG8gcmV0
cnk7IEkNCj4+IGRvbid0IGV4cGVjdCBjbGllbnQgY3JlYXRpb24gdG8gZmFpbCBvdXRyaWdodC4g
Q2FuIHlvdSBkZXNjcmliZSB0aGUNCj4+IGZhaWx1cmUgbW9kZSB5b3Ugc2VlPw0KPiANCj4gVGhl
IGZhaWx1cmUgbW9kZSBpcyByZXBlYXRlZCBjbGllbnQgcmV0cmllcyB0aGF0IG5ldmVyIHN1Y2Nl
ZWQuICBJIHRoaW5rDQo+IGFuIG91dHJpZ2h0IGZhaWx1cmUgd291bGQgYmUgcHJlZmVyYWJsZSAt
IGl0IHdvdWxkIGJlIG1vcmUgY2xlYXIgdGhhbg0KPiBtZW1vcnkgbXVzdCBiZSBhZGRlZC4NCj4g
DQo+IFRoZSBzZXJ2ZXIgaGFzIE4gYWN0aXZlIGNsaWVudHMgYW5kIE0gY291cnRlc3kgY2xpZW50
cy4NCj4gVHJpZ2dlcmluZyByZWNsYWltIHdoZW4gTitNIGV4Y2VlZHMgYSBsaW1pdCBhbmQgTT4w
IG1ha2VzIHNlbnNlLg0KPiBBIGhhcmQgZmFpbHVyZSAoTkZTNEVSUl9SRVNPVVJDRSkgd2hlbiBO
IGV4Y2VlZHMgYSBsaW1pdCBtYWtlcyBzZW5zZS4NCj4gQSBzb2Z0IGZhaWx1cmUgKE5GUzRFUlJf
REVMQVkpIHdoaWxlIHJlY2xhaW0gaXMgcnVubmluZyBtYWtlcyBzZW5zZS4NCj4gDQo+IEkgZG9u
J3QgdGhpbmsgYSByZXRyeSB3aGlsZSBOIGV4Y2VlZHMgdGhlIGxpbWl0IG1ha2VzIHNlbnNlLg0K
DQpJdOKAmXMgbm90IG9wdGltYWwsIEkgYWdyZWUuDQoNCk5GU0QgaGFzIHRvIGxpbWl0IHRoZSB0
b3RhbCBudW1iZXIgb2YgYWN0aXZlIGFuZCBjb3VydGVzeQ0KY2xpZW50cywgYmVjYXVzZSBvdGhl
cndpc2UgaXQgd291bGQgYmUgc3ViamVjdCB0byBhbiBlYXN5DQooZClEb1MgYXR0YWNrLCB3aGlj
aCBEYWkgZGVtb25zdHJhdGVkIHRvIG1lIGJlZm9yZSBJDQphY2NlcHRlZCBoaXMgcGF0Y2guIEEg
bWFsaWNpb3VzIGFjdG9yIG9yIGJyb2tlbiBjbGllbnRzDQpjYW4gY29udGludWUgdG8gY3JlYXRl
IGxlYXNlcyBvbiB0aGUgc2VydmVyIHVudGlsIGl0IHN0b3BzDQpyZXNwb25kaW5nLg0KDQpJIHRo
aW5rIGZhaWxpbmcgb3V0cmlnaHQgd291bGQgYWNjb21wbGlzaCB0aGUgbWl0aWdhdGlvbg0KYXMg
d2VsbCBhcyBkZWxheWluZyBkb2VzLCBidXQgZGVsYXlpbmcgb25jZSBvciB0d2ljZQ0KZ2l2ZXMg
c29tZSBzbGFjayB0aGF0IGFsbG93cyBhIG1vdW50IGF0dGVtcHQgdG8gc3VjY2VlZA0KZXZlbnR1
YWxseSBldmVuIHdoZW4gdGhlIHNlcnZlciB0ZW1wb3JhcmlseSBleGNlZWRzIHRoZQ0KbWF4aW11
bSBjbGllbnQgY291bnQuDQoNCkFsc28gSU1PIHRoZXJlIGNvdWxkIGJlIGEgcmF0ZS1saW1pdGVk
IHByX3dhcm4gb24gdGhlDQpzZXJ2ZXIgdGhhdCBmaXJlcyB0byBpbmRpY2F0ZSB3aGVuIGEgbG93
LW1lbW9yeSBzaXR1YXRpb24NCmhhcyBiZWVuIHJlYWNoZWQuDQoNClRoZSBwcm9ibGVtIHdpdGgg
TkZTNEVSUl9SRVNPVVJDRSwgaG93ZXZlciwgaXMgdGhhdA0KTkZTdjQuMSBhbmQgbmV3ZXIgZG8g
bm90IGhhdmUgdGhhdCBzdGF0dXMgY29kZS4gQWxsDQp2ZXJzaW9ucyBvZiBORlMgaGF2ZSBERUxB
WS9KVUtFQk9YLg0KDQpJIHJlY29nbml6ZSB0aGF0IHlvdSBhcmUgdHdlYWtpbmcgb25seSBTRVRD
TElFTlRJRCBoZXJlLA0KYnV0IEkgdGhpbmsgYmVoYXZpb3Igc2hvdWxkIGJlIGNvbnNpc3RlbnQg
Zm9yIGFsbCBtaW5vcg0KdmVyc2lvbnMgb2YgTkZTdjQuDQoNCg0KPiBEbyB3ZSBoYXZlIGEgY291
bnQgb2YgYWN0aXZlIHZzIGNvdXJ0ZXN5IGNsaWVudHM/DQoNCkRhaSBjYW4gY29ycmVjdCBtZSBp
ZiBJ4oCZbSB3cm9uZywgYnV0IEkgYmVsaWV2ZSBORlNEDQptYWludGFpbnMgYSBjb3VudCBvZiBi
b3RoLg0KDQpCdXQgb25seSB0aGUgYWN0aXZlIGxlYXNlcyByZWFsbHkgbWF0dGVyLCBiZWNhc2UN
CmNvdXJ0ZXN5IGNsaWVudHMgY2FuIGJlIGRyb3BwZWQgYXMgbWVtb3J5IGJlY29tZXMgdGlnaHQu
DQpEcm9wcGluZyBhbiBhY3RpdmUgbGVhc2Ugd291bGQgYmUgc29tZXdoYXQgbW9yZQ0KY2F0YXN0
cm9waGljLg0KDQoNCuKAlA0KQ2h1Y2sgTGV2ZXI=

