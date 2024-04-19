Return-Path: <linux-nfs+bounces-2896-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C328AB1AE
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Apr 2024 17:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64801C23009
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Apr 2024 15:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A983D12F5A5;
	Fri, 19 Apr 2024 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LWQNSakL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="csKAQs1v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F37412F59B
	for <linux-nfs@vger.kernel.org>; Fri, 19 Apr 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540012; cv=fail; b=Fs2Moaw6/dFjGOZGXis+S4f4bujBxqputgntSzZKgX3kXb84eeeiDjbNhnKMQrW+ukhYznpUMDcXfjxnbLR7A7PxXQVK7XiZjRqVy0IfmcNnAnAGKCflrMziSQCE/gS0TlOER6sLeGubSB5rAkN3KT8f9ikM3IULvWbNZV98io8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540012; c=relaxed/simple;
	bh=qpNwPAk87FIix7VI/jMr2Hpj2pNxwrN2NwYihSw1C8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=epWpmqpwJaAKfkyMrk7c3tV4HVtrwRQsKhWzfhadiAV0ce20fquRNC0HrpkduxbTMWKCODNiQM0C2Lmj5Xkt1oLY7D+DO3JCjeXS9MG+R31VbUAxZ5N6n52V2ZQjgULBIo+Y0f+wU7sltVudQ3naWuzHGWPBsE00zKvvv58L0vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LWQNSakL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=csKAQs1v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43JDBfA8027218;
	Fri, 19 Apr 2024 15:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qpNwPAk87FIix7VI/jMr2Hpj2pNxwrN2NwYihSw1C8A=;
 b=LWQNSakLG+QbTkX2BzwwDStnK8ZCxDzM3Gxwk4DYBb9Yqk7jGh9/nDcURMnq0teOaFYX
 kOI/7zJjTy9t5v6Bb2cXyay0pSShac5dmZOng23CKOroceNxAw+0x/cDTLU3whkvWD8T
 g609GI5YfnK8+7K4LVCi6VsRiaA0L/stvVL7qMcehMubpchHELQF+f+HRr8ULGlWMuZe
 nGhc9Ia6mc0wWaAXyrT7TgUuG/xp4DtmlAvne4Pr9avFWxm0BG0kJwmPYuKME5oIGmsJ
 ZLM/oYZpei7+ALAqDh2OaALHirzxn80c9j4Y+XrrqPPaezf5IYmId5V4Het6Ku46Gz0d sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbvywu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 15:19:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43JDjcOW014463;
	Fri, 19 Apr 2024 15:19:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xkc97pmne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 15:19:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yp6r6/gmGk6K2b7ZFt5ufPMia7W1fukII5INirRz+M99qqxLsso29UCeVmApRHy30a6gG1MI3KLb07urugfCxmdJCo83qbMLbA29Q58Kal/pxek/KVbf16qgS4kB7mFMiC4bzkMJftsbhY0Voq9TIewNQxZuyz006isdrzOlJrGdPM9YQBe7B/BQmqUs9sWtpuMTA1lvXauuS+KIyN3nH5HDfT5cthIffmyHoQdkqLiib7wWWPkWfgMftxpDOOBHipTplv76tqQO+AwNTtqATDr0Ta8e5qILSyb9iuv9/NEuVpH7V4jioOlGDF/Sn2O/PvMa/6yawySSTdtR5Zs6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpNwPAk87FIix7VI/jMr2Hpj2pNxwrN2NwYihSw1C8A=;
 b=NuBqL2ZYP5cAaBpR0LCb3yXSuiE0eiboecnuIXTLcaKekeQgkLHbYdIKLWc4b3RmQSgXQGLEz68YuQv6/psZMw9193Gyu9dHpifIzvQpjaPS61ZRCWXLNOpfphQDaSheoBKpb+Nl0YVNNFpBxqY41XNyN/5JqqfSc6VYKooVL9bMGd9Tr4K8bJ7vph9UMsAuaL0ZF0HUC6a1lxJRUX9z034noZApIJ++Ebafpy+nKTkc/riH0rlX+enissPeYgZWfOIyH7nd4yVs5JWpP0ni/gQ/3jByl3R1X9WqaB/FLhoQm9ITTxuuF1vqVvjgpP1GF94T3cN5Gz+f/9GITWrqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpNwPAk87FIix7VI/jMr2Hpj2pNxwrN2NwYihSw1C8A=;
 b=csKAQs1v7isij/ox6hB73GjPjB7ffzr1ualuP/pPLJi7+/fVQHUM2ygORD9Q4b+xYUnMcU4LRB37zQxgtnA23qeJISw7uZKrs04sgRBvPn+KK46wRKqGLdMTPyMPd4S4CmbXX2TsEf2jcmYI5X/ouO8tg/HZNH0tMFYp1dEkmpQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5628.namprd10.prod.outlook.com (2603:10b6:510:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 15:19:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 15:19:53 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker
	<anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown
	<neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo
	<dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [Bug 218743] New: NFS-RDMA-Connected Regression Found on Upstream
 Linux 6.9-rc1
Thread-Topic: [Bug 218743] New: NFS-RDMA-Connected Regression Found on
 Upstream Linux 6.9-rc1
Thread-Index: AQHakmxstDkmthVCs0ep3tuxfFImfLFvtSmA
Date: Fri, 19 Apr 2024 15:19:53 +0000
Message-ID: <D272E6E6-FBE8-4E86-A91D-B20F8D314FC1@oracle.com>
References: <20240419081520.57bf66c1@hermes.local>
In-Reply-To: <20240419081520.57bf66c1@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5628:EE_
x-ms-office365-filtering-correlation-id: a03e8b0a-4f04-4a26-5a5d-08dc608429da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lSlhJlRUWuuNX8aQP4+r9GYHPLa4FbcTPO4B7ZDPmyQlvgU74mtCE7qg0DkZ0xopDUOp175GghboYky1idmKsc8ipMAqUeRrxl2mLN7Trhcu40Ua1B07AnCih4cxwuu6JXhX86XY6hzaHMJ71wZGROEV38U436QMAI7fe7FEB+nelXoy/0cyAaiS6OanFDdHK4gGcLvRqxBHs6GNxkJ6ZtG2EdIzv8uuRJnJBYUPMusLidrODBDxz+gkg7i7vtC1byHIfKkQeRE67Ev4OJNUFJdtkALVnxgg5sZSDyrawujyoo+as6V2LJ+0GL6cQKGYcSHHJuC+QBH8KVedH+YQ+KQ5dENphOzpD2IdOKjnvUHfHG4GCKEIumTDNFUXqMutepYxYWdYrWSq7tQuncw+sIbfv10q6VYlAYgLugV/pZd0lckljecKiTnq/jfKLPXxjhhlagxM+1aK/32yNzEnvg+2lOAgxyHj22dwMhZYIuHEqA4+nBwsUW6Ey1Q/MjN1KV13IfUGpjlO9ZzhYtHp2kinjhDsZva3azUfpV1YvM1H88E4lalUbZZcgEd7RFhVXVAYqYF8UBDc/+V3cu9ZGDtAUmz9X7Y3yb9Aa7F8styHeVhLRpXp5PdZcZrXmgfJ7WmXYxYfqy97o4b/JURQtB/e6xnBgLErN4ixIjKXZWJtRte+ULCGSU/qn2nCDxNgqbeuaxWG3sfiwLFOBETRAA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NGh4bmxFMUdncUQxejJmYklqelUweFYrdVAxN0xhR1k0VUM1RkF2eXh0aDI2?=
 =?utf-8?B?Y1A5MGdNTWFScmdsb3RuWFVVdFl2NURienRCQUlZVjEwMUhMaVpUSUl0ZmVr?=
 =?utf-8?B?N2plL044aDRyZVVLa0pieWpnVEpxamc3bC9jZTBCNFpPMHRzT1lDL3BidFV6?=
 =?utf-8?B?djVuUmo2Sy9jMS9mSWNrbGRHbHQ5V2ZhSDJhdmxWd2hiSjdPL01CUWRHNVBK?=
 =?utf-8?B?Wk83M0szZ2ZCT2J5YTdONGt3LzNsS2o5azkvWVRRNDdyRFNZSTA3SjJRclBw?=
 =?utf-8?B?YlhyMnJ1d0g0dHdMUC9DamloOGVsT291VmVON25hd0toOUI2MkU2aExxMmdV?=
 =?utf-8?B?L01LNGZZOW81NmJmRzFob2JFTytJTk5aaVl5OGZhcGdQbEdzN2hvV1ViSTlR?=
 =?utf-8?B?cG5WSzZQRFFaSCtXVzlJQ3hrU2dMWGlEOWg2WTV1Ujd4ZUxqS1NhWGI1OXpU?=
 =?utf-8?B?c1pnNG9RSmZuOGZTWjd2OUpzRkJqQTNQSU9rUEZ1SkhKR2tqMFM2eDlVcm1O?=
 =?utf-8?B?eGd3VjgxRjNCd3paemVMZGtBVmNwckZGR01hQUZvRHozS2NSbGR6czVCMWR3?=
 =?utf-8?B?YU1OMkdJa2t2U2RBNHZMdXZJQUpXK3g5MGF4Wkl1SGlUaWt0U29VdmI0aEVD?=
 =?utf-8?B?M1lWelVlcE83VlBKMEdQU1FxNFZ2aUhNZDVKSjJUbjdlWTF3NlpVSTNLWlF6?=
 =?utf-8?B?ekR4bGh2UEN4a21VTlJ3RWdTVm5GSjZ0blR3SUFMdlFKaCs1UG9mSWcxVlZJ?=
 =?utf-8?B?MVgrY0VTdjFnRGZWcUZMdzVlTHNoQ1A0QjlSR3BjYy9Cb0ROazdoNzloYTJo?=
 =?utf-8?B?LzR5NmY0MnZRWEI2TEZPcEtwNVg5VmlveHVwQklkV0ZwZTRNcFUyQ1EvaEhv?=
 =?utf-8?B?VEVHM1g3Z0UxRUh3UlBnUWpUMFpUSkU2dVV5d1AyMkhodktvQTFkWWhBR3Vo?=
 =?utf-8?B?RGMrTWd2cTZoYVB3aGFSa2k0UGxNNFE1cmFnV3BMblp3eTUxWmdDOERpMEh2?=
 =?utf-8?B?Mnlhd1crTnNaUzk5cHFjMVI0S1BoWHFtOG5LMnkwMm1BMGcrdllON2RWNzlE?=
 =?utf-8?B?YVJ4azlyWFNPOG5yRFpORTB0Q2FLemhpU05wSGlab3pobXhub3BaMzVKc0RD?=
 =?utf-8?B?VG5kMy9Sak1mdGxzQU9nMkJhb0NsejZGbHo0Y0FybGFUTmlIRkxvc0hJN1N1?=
 =?utf-8?B?Y3Z3OTlEUmtjcnliSGV4N3BGRGFzUFU4OEN6dEJBZU5aNURxaHdERXNUTXpt?=
 =?utf-8?B?a2VtK25WUWx2a0UwN2FPWTJlTjYrUUdHWVdrcmFrR0JpbW9OSkw3dFBBSHdH?=
 =?utf-8?B?QmFnc2RBVE1zd1NOY2lFN3ArSG5jck5rOUJhd0NEUFBocFo5bUFlRnZ0NURD?=
 =?utf-8?B?dCtRTUI2Q0RUYWkweWowR29QM3ZJRE5DVGNRbG5YSGFUVXFJd0N0bjh3OURw?=
 =?utf-8?B?QUdYOGxCcHpDUXorUUZiRmthWUNEN1Q4Q1Bmak1pU05CdUlySVdtbG00ZFgv?=
 =?utf-8?B?WThQQXRZandnR0w0RjhQSHpDUGgyTDBuL1ZoTUZPWVQzZjdzaWp4MEZjMktI?=
 =?utf-8?B?Y0pXT3BXMGdBVFNzWmN0NlVOcE92OCtpaE5yUHJjUG82OWJWUmk0Wi9kNXp2?=
 =?utf-8?B?WEltK2NBN3B5NGY3bzlTc1JrVVdiejg4NUFSaW1NQ0UzNmlrYnE5Q01SM0pk?=
 =?utf-8?B?dVBybnlVVHVPeXhnV0RFSWRWZUhCNTVuTWJJUHB2b1lCaUlaL1paTUhWOUFt?=
 =?utf-8?B?MThyc3EvaHU5WUI4Nk5DVU9UbVN4M25RVVBzZ1Y5cWNNOXhYdTFHY01SQ0Ex?=
 =?utf-8?B?WEplN2JEaENpUDlUOWNzTitLOXVMSWNGSkMvNDJzbjJmTnY1dlp0U3hadzJL?=
 =?utf-8?B?MG1vRitTZEhibCtMVWlSVUgzV3dUc3VwWmVOVEM3ZHVZdzZLUFMvNHozSDg3?=
 =?utf-8?B?Ulp0MVZtL2dSZWQySFBFYklESndlMTIyREJmWWtsSDhYenVJSm51VmgrSlBv?=
 =?utf-8?B?czZxUDZXQkFNZGhWSkNxQ3kvMjAvSFU4OXlkYzNjcWRsdGtRV2RuZy8xQTF3?=
 =?utf-8?B?b2hmSUxvSElJOW41K3NpSE5OUlVEVmc1MVRhakdFR0psWC9jQitxc3QrSEVZ?=
 =?utf-8?B?MTZXc0pxWnlYOHpUYU1vVmR3SWxLVHNGQkJjbVdnZVdaNUE5UUxCTTZ1eDJx?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1217C799F3FA64ABEFB74C085810E55@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sYioTiZZIgt7UCK9vv5OevrqntIDkce6WdcbWuz7J/kLEjyr7TrEivKPwhFt1FYB4fvgIVWAqog1VxNep2hBU420Xknk3aw4NeDb1YApNbz33acg0MKWb/OWVXlnXnUW3JtE72tEcqDrfuyMffGrmTMBYxDCitoY4+fJtID+wV/T2jXbOCM5VsHhn7vUU0DcA1ius8BhvEXR8ykmSdTwijl9O5MKa7rxZFx/epJ4F+6dzJzrx4AFQGxvg6IJhQlmV7gQFLGwPNmeljAlk47gRp8P0NGulJ0uVp1PmtbjGhh01PDeyda9O2JWNAEjyZl3tbnTkUPMtj4ysN2bOQVJqEi5b3iaIPkwrNCRV6PoIlRJ94RiRjWQCWHaIHZgNRXqJfq6NzfpRQj/xC4j10KB7xHkfucypKmWNpCP+OlCFUAIfFhnsZwQXE7s7u+IGOojd0+OOPcFDsWb6F7XphdkfnvgiOSLaB7MuEOOWiryGsbCjGky3Arv2zgZgQAafjB9PK8q6FJX4k5UbaTSSFIRxy/gduwoK6LgT6QxhfYnrrPbwL4V2TNjVZKtDq3PpWsYr+1sZJfpi/FI3vwqaVTUh5KgMtqBhSZuPPTVawqWW9w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03e8b0a-4f04-4a26-5a5d-08dc608429da
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 15:19:53.3854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5nxqrB7hzpE2YvgUUYyPQMKrM28o4RQ9ZG82ve+hN8FpYA+cxkAtv9kLL7dcrcO2vWgPmXCBZ0DWU6MOS91Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_10,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404190116
X-Proofpoint-ORIG-GUID: UmVIF4IERluZtaNDuD9YKaLo9MVIXO9C
X-Proofpoint-GUID: UmVIF4IERluZtaNDuD9YKaLo9MVIXO9C

DQoNCj4gT24gQXByIDE5LCAyMDI0LCBhdCAxMToxNeKAr0FNLCBTdGVwaGVuIEhlbW1pbmdlciA8
c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+IHdyb3RlOg0KPiANCj4gSSBmb3J3YXJkIG5ldHdv
cmtpbmcgYnVncyB0byB0aGUgbWFpbnRhaW5lcnMuDQo+IE5ldGRldiBkb2VzIG5vdCB1c2UgYnVn
emlsbGEsIG5vdCBzdXJlIGlmIE5GUyBkb2VzLg0KPiANCj4gQmVnaW4gZm9yd2FyZGVkIG1lc3Nh
Z2U6DQo+IA0KPiBEYXRlOiBUaHUsIDE4IEFwciAyMDI0IDAwOjAwOjIyICswMDAwDQo+IEZyb206
IGJ1Z3ppbGxhLWRhZW1vbkBrZXJuZWwub3JnDQo+IFRvOiBzdGVwaGVuQG5ldHdvcmtwbHVtYmVy
Lm9yZw0KPiBTdWJqZWN0OiBbQnVnIDIxODc0M10gTmV3OiBORlMtUkRNQS1Db25uZWN0ZWQgUmVn
cmVzc2lvbiBGb3VuZCBvbiBVcHN0cmVhbSBMaW51eCA2LjktcmMxDQo+IA0KPiANCj4gaHR0cHM6
Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTg3NDMNCj4gDQo+ICAgICAg
ICAgICAgQnVnIElEOiAyMTg3NDMNCj4gICAgICAgICAgIFN1bW1hcnk6IE5GUy1SRE1BLUNvbm5l
Y3RlZCBSZWdyZXNzaW9uIEZvdW5kIG9uIFVwc3RyZWFtIExpbnV4DQo+ICAgICAgICAgICAgICAg
ICAgICA2LjktcmMxDQo+ICAgICAgICAgICBQcm9kdWN0OiBOZXR3b3JraW5nDQo+ICAgICAgICAg
ICBWZXJzaW9uOiAyLjUNCj4gICAgS2VybmVsIFZlcnNpb246IDYuOS1yYzENCj4gICAgICAgICAg
SGFyZHdhcmU6IEludGVsDQo+ICAgICAgICAgICAgICAgIE9TOiBMaW51eA0KPiAgICAgICAgICAg
IFN0YXR1czogTkVXDQo+ICAgICAgICAgIFNldmVyaXR5OiBoaWdoDQo+ICAgICAgICAgIFByaW9y
aXR5OiBQMw0KPiAgICAgICAgIENvbXBvbmVudDogT3RoZXINCj4gICAgICAgICAgQXNzaWduZWU6
IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnDQo+ICAgICAgICAgIFJlcG9ydGVyOiBtYW51ZWwu
Z29tZXpAY29ybmVsaXNuZXR3b3Jrcy5jb20NCj4gICAgICAgICAgICAgICAgQ0M6IGRlbm5pcy5k
YWxlc3NhbmRyb0Bjb3JuZWxpc25ldHdvcmtzLmNvbQ0KPiAgICAgICAgUmVncmVzc2lvbjogWWVz
DQo+ICAgICAgICAgICBCaXNlY3RlZCBlMDg0ZWU2NzNjNzdjYWRlMDZhYjRjMmUzNmI1NjI0Yzgy
NjA4YjhjDQo+ICAgICAgICAgY29tbWl0LWlkOg0KPiANCj4gT24gdGhlIExpbnV4IDYuOS1yYzEg
a2VybmVsIHRoZXJlIGlzIGEgcGVyZm9ybWFuY2UgcmVncmVzc2lvbiBmb3IgTkZTIGZpbGUNCj4g
dHJhbnNmZXJzIHdoZW4gQ29ubmVjdGVkIElQb0lCIG1vZGUgaXMgZW5hYmxlZC4gVGhlIG5ldHdv
cmsgc3dpdGNoIGlzIE9QQQ0KPiAoT21uaXBhdGggQXJjaGl0ZWN0dXJlKS4NCj4gDQo+IFRoZSBt
b3N0IHJlY2VudCBnb29kIGNvbW1pdCBpbiBteSBiaXNlY3Rpb24gd2FzIHRoZSB2Ni44IG1haW5s
aW5lIGtlcm5lbA0KPiAoZThmODk3ZjRhZmVmMDAzMWZlNjE4YThlOTQxMjdhMDkzNDg5NmFiYSku
IEJpc2VjdGluZyBmcm9tIHY2LjggdG8gdjYuOS1yYzENCj4gc2hvd2VkIG1lIHRoYXQgIltlMDg0
ZWU2NzNjNzdjYWRlMDZhYjRjMmUzNmI1NjI0YzgyNjA4YjhjXSBzdmNyZG1hOiBBZGQgV3JpdGUN
Cj4gY2h1bmsgV1JzIHRvIHRoZSBSUEMncyBTZW5kIFdSIGNoYWluIiB3YXMgaW5kZWVkIHRoZSBj
dWxwcml0IG9mIHRoZSByZWdyZXNzaW9uLg0KPiANCj4gDQo+IEhlcmUgYXJlIHRoZSBzdGVwcyBJ
IHJhbiB0byByZXByb2R1Y2UgdGhlIGlzc3VlOg0KPiAxLiBFc3RhYmxpc2ggSVBvSUIgQ29ubmVj
dGVkIE1vZGUgb24gYm90aCBjbGllbnQgYW5kIGhvc3Qgbm9kZXM6DQo+ICJlY2hvIGNvbm5lY3Rl
ZCA+IC9zeXMvY2xhc3MvbmV0L2liczc4NS9tb2RlIg0KPiANCj4gDQo+IDIuIFN0YXJ0IGFuIE5G
UyBzZXJ2ZXIgb24gdGhlIGhvc3Qgbm9kZToNCj4gInN5c3RlbWN0bCBzdGFydCBvcGFmbQ0KPiBz
bGVlcCAxMA0KPiBzeXN0ZW1jdGwgc3RhcnQgbmZzLXNlcnZlcg0KPiBtb2Rwcm9iZSBzdmNyZG1h
DQo+IGVjaG8gInJkbWEgMjAwNDkiID4gL3Byb2MvZnMvbmZzZC9wb3J0bGlzdA0KPiBta2RpciAt
cCAvbW50L25mc190ZXN0DQo+IG1vdW50IC10IHRtcGZzIC1vIHNpemU9NDA5Nk0gdG1wZnMgL21u
dC9uZnNfdGVzdA0KPiBzdWRvIGV4cG9ydGZzIC1vIGZzaWQ9MCxydyxhc3luYyxpbnNlY3VyZSxu
b19yb290X3NxdWFzaA0KPiAxOTIuMTY4LjIuMC8yNTUuMjU1LjI1NS4wOi9tbnQvbmZzX3Rlc3Rf
dGVzdHJ1bi8iDQo+IA0KPiANCj4gMy4gUmVhZHkgdGhlIGNsaWVudCBub2RlOg0KPiAibWtkaXIg
LXAgL21udC9uZnNfdGVzdA0KPiBtb3VudCAtbyByZG1hLHBvcnQ9MjAwNDkgMTkyLjE2OC4yLjE6
L21udC9uZnNfdGVzdF90ZXN0cnVuDQo+IC9tbnQvbmZzX3Rlc3RfdGVzdHJ1bi8iDQo+IA0KPiAN
Cj4gNC4gUnVuIHRoZSBhY3R1YWwgdGVzdCBmcm9tIHRoZSBjbGllbnQgbm9kZToNCj4gIg0KPiAj
IS9iaW4vYmFzaA0KPiANCj4gZnNpemU9MjY4NDM1NDU2DQo+IGpmaWxlPS9kZXYvc2htL3J1bl9u
ZnNfdGVzdDIuanVuaw0KPiB0ZmlsZT0vZGV2L3NobS9ydW5fbmZzX3Rlc3QyLnRtcA0KPiBuZnNm
aWxlPS9tbnQvbmZzX3Rlc3RfdGVzdHJ1bi9ydW5fbmZzX3Rlc3QyLmp1bmsNCj4gcm0gLXIgLWYg
L21udC9uZnNfdGVzdF90ZXN0cnVuLw0KPiBybSAtZiAke3RmaWxlfQ0KPiBybSAtZiAke2pmaWxl
fQ0KPiANCj4gZGQgaWY9L2Rldi91cmFuZG9tIGlmbGFnPWZ1bGxibG9jayBvZj0ke2pmaWxlfSBi
cz0xMDI0IGNvdW50PSQoKGZzaXplLzEwMjQpKTsNCj4gDQo+IGZvciBpIGluIHsxLi4xMDB9OyBk
bw0KPiAgICAgICAgICBjcCAke2pmaWxlfSAke25mc2ZpbGV9OyAjIEJvdHRsZW5lY2sgMQ0KPiAN
Cj4gICAgICAgICAgY3AgJHtuZnNmaWxlfSAke3RmaWxlfTsgIyBCb3R0bGVuZWNrIDINCj4gDQo+
ICAgICAgICAgY21wICR7amZpbGV9ICR7dGZpbGV9Ow0KPiANCj4gICAgICAgICAgcm0gLWYgJHt0
ZmlsZX07DQo+ICAgICAgICBlY2hvICJET05FIHdpdGggaXRlciAke2l9Ig0KPiBkb25lOw0KPiAN
Cj4gcm0gLWYgJHtqZmlsZX07DQo+IHJtIC1mICR7dGZpbGV9Ow0KPiBlY2hvICJEb25lIjsNCj4g
Ig0KPiANCj4gDQo+IE9uIHY2LjggSSB3YXMgc2VlaW5nIHRoaXMgdGVzdCB0YWtpbmcgYWJvdXQg
MW01MHMgdG8gY29tcGxldGUsIGZvciBhbGwgMTANCj4gaXRlcmF0aW9ucy4gT24gdjYuOS1yYzEg
aXQgdGFrZXMgMy03IG1pbnV0ZXMsIGFuZCBJIGFsc28gc2VlIHRoZXNlIGtlcm5lbA0KPiB0cmFj
ZXMgcHJpbnRlZCBjb250aW51b3VzbHkgaW4gZG1lc2cgZHVyaW5nIHRoaXMgcmVncmVzc2lvbjoN
Cj4gDQo+IFsyMzcyMC4yNDM5MDVdIElORk86IHRhc2sga3dvcmtlci82MToxOjU1NiBibG9ja2Vk
IGZvciBtb3JlIHRoYW4gMTIyIHNlY29uZHMuDQo+IFsyMzcyMC4yNTE3MDldICAgICAgIE5vdCB0
YWludGVkIDYuOS4wLXJjMSAjMQ0KPiBbMjM3MjAuMjU2Mzg3XSAiZWNobyAwID4gL3Byb2Mvc3lz
L2tlcm5lbC9odW5nX3Rhc2tfdGltZW91dF9zZWNzIiBkaXNhYmxlcyB0aGlzDQo+IG1lc3NhZ2Uu
DQo+IFsyMzcyMC4yNjUyNjhdIHRhc2s6a3dvcmtlci82MToxICAgIHN0YXRlOkQgc3RhY2s6MCAg
ICAgcGlkOjU1NiAgIHRnaWQ6NTU2ICANCj4gcHBpZDoyICAgICAgZmxhZ3M6MHgwMDAwNDAwMA0K
PiBbMjM3MjAuMjc1ODIyXSBXb3JrcXVldWU6IGV2ZW50cyBfX3N2Y19yZG1hX2ZyZWUgW3JwY3Jk
bWFdDQo+IFsyMzcyMC4yODE4MDNdIENhbGwgVHJhY2U6DQo+IFsyMzcyMC4yODQ2MzBdICA8VEFT
Sz4NCj4gWzIzNzIwLjI4NzA2N10gIF9fc2NoZWR1bGUrMHgyMTAvMHg2NjANCj4gWzIzNzIwLjI5
MTA2M10gIHNjaGVkdWxlKzB4MmMvMHhiMA0KPiBbMjM3MjAuMjk0NjY4XSAgc2NoZWR1bGVfdGlt
ZW91dCsweDE0Ni8weDE2MA0KPiBbMjM3MjAuMjk5MjQ5XSAgX193YWl0X2Zvcl9jb21tb24rMHg5
Mi8weDFkMA0KPiBbMjM3MjAuMzAzODI4XSAgPyBfX3BmeF9zY2hlZHVsZV90aW1lb3V0KzB4MTAv
MHgxMA0KPiBbMjM3MjAuMzA4OTg3XSAgX19pYl9kcmFpbl9zcSsweGZhLzB4MTcwIFtpYl9jb3Jl
XQ0KPiBbMjM3MjAuMzE0MTkwXSAgPyBfX3BmeF9pYl9kcmFpbl9xcF9kb25lKzB4MTAvMHgxMCBb
aWJfY29yZV0NCj4gWzIzNzIwLjMyMDM0M10gIGliX2RyYWluX3FwKzB4NzEvMHg4MCBbaWJfY29y
ZV0NCj4gWzIzNzIwLjMyNTIzMl0gIF9fc3ZjX3JkbWFfZnJlZSsweDI4LzB4MTAwIFtycGNyZG1h
XQ0KPiBbMjM3MjAuMzMwNjA0XSAgcHJvY2Vzc19vbmVfd29yaysweDE5Ni8weDNkMA0KPiBbMjM3
MjAuMzM1MTg1XSAgd29ya2VyX3RocmVhZCsweDJmYy8weDQxMA0KPiBbMjM3MjAuMzM5NDcwXSAg
PyBfX3BmeF93b3JrZXJfdGhyZWFkKzB4MTAvMHgxMA0KPiBbMjM3MjAuMzQ0MzM2XSAga3RocmVh
ZCsweGRmLzB4MTEwDQo+IFsyMzcyMC4zNDc5NDFdICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEw
DQo+IFsyMzcyMC4zNTIyMjVdICByZXRfZnJvbV9mb3JrKzB4MzAvMHg1MA0KPiBbMjM3MjAuMzU2
MzE3XSAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KPiBbMjM3MjAuMzYwNjAyXSAgcmV0X2Zy
b21fZm9ya19hc20rMHgxYS8weDMwDQo+IFsyMzcyMC4zNjUwODNdICA8L1RBU0s+DQo+IA0KPiAt
LSANCj4gWW91IG1heSByZXBseSB0byB0aGlzIGVtYWlsIHRvIGFkZCBhIGNvbW1lbnQuDQo+IA0K
PiBZb3UgYXJlIHJlY2VpdmluZyB0aGlzIG1haWwgYmVjYXVzZToNCj4gWW91IGFyZSB0aGUgYXNz
aWduZWUgZm9yIHRoZSBidWcuDQo+IA0KDQpUaGFua3MsIEkndmUgc2VlbiBhIHBlcmZvcm1hbmNl
IHJlZ3Jlc3Npb24gb24gb25lIHN5c3RlbSBhbmQNCmhhdmVuJ3QgYmVlbiBhYmxlIHRvIHJlcHJv
ZHVjZSBpdCBlbHNld2hlcmUuDQoNClBsZWFzZSBtb3ZlIHRoaXMgYnVnIHRvIEZpbGVzeXN0ZW1z
L05GUy4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

