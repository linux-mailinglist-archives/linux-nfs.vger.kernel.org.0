Return-Path: <linux-nfs+bounces-2508-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D030188F451
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 02:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350BC1F23AC8
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 01:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657DDBE58;
	Thu, 28 Mar 2024 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oKf2fUq7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LF+awRdf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974D78465
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711588179; cv=fail; b=fZlbLnquvsEPzeWWH5VpeO9H0U7hVuOZhMqPs1YuFQALyLauGCfOjBboKfdNqveFJsqQOrjLmeDQBW2LCiIVOfHfgIGcFAXlN8R9zBibVAM0lWY57pme04jSxihCmYO8QP2ssl7RXZPtauZJ2Och+cP7C6//x3DWJeXDcCFgK2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711588179; c=relaxed/simple;
	bh=0YhfAhtIOuJPwR/i/BSBGJigQ+xtmbjSqwFkS7/LUgM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X7/2uvgZgFKM9oiEJVdKwiZ1R3uGa34+5qa01nr71iZ0Fo3jhmgaI7NoxbEYYQ51Ld7ZrKODrDetk0aKRbmDTSJKeMSmHgnTDmbj1YzM6FDcPJK4MjL3Ij1YdQDZC2c8EM/r1MznuO2CcxHSrETdhn0Pj6iq5uUlxUoOf9guAUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oKf2fUq7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LF+awRdf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42RJudlP017291;
	Thu, 28 Mar 2024 01:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4oQ+IgbM3U2TACPoMzey8bFiRiViBvBOl2SMQ++5frg=;
 b=oKf2fUq7m0cKiMT+wx96otRaoTzbGsctn6KIml5Z5L6lRRTSW/3hBekO/LQB/HVy91Yi
 f1bB7q2cFyiM8+Xo1siLiMtFmrIhWdOYii7cgilM0pC+kUKA+YuEemTRkjzYMXD4joc4
 /iEAFAOdaz8u29EUbPaWgUQwBmZWkmA5eBsxjQhnzsPiC2XGF1YUBcvZMezxYNZxkW7b
 dJytAnMr5t4DH+OOpp/hg1H3BA44rbys8uKgd7qJE4zh0DD042kSUxrfNsVsaYxRjene
 7BsCywTod0kSlk899yN8Pa8IM1uECue5nyEpAbkxfUkR6HLHjQhnfoOcd9XwAzwwEjjT zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1pybrkvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 01:09:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42S0bmho008879;
	Thu, 28 Mar 2024 01:09:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh9n2vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 01:09:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRXXiXRzXmYiqEMeEbkh6bzrojdoPFFVYzTmt/sOj3/Z0OuL+tbO1FUZK0WWSEO8VfqBtNeyQzl6/eRKfNJszjDR72lceTC0KHRw5MPRgJ5My4yNT8rzZbuXvHdYMIESHHWnXxjt5oADnnBH6aYo9TAXkTo9nSklqGcmTebfNTBBbZWfXMeBKMeF2lNAo6pKAXWZVZDdtCjyNbwyojnFgzE92hYGWiNtkJF714YOrp+Km2HXAOytUdM5uPnFIeBUDv7n9C+nsI0AKKiKSgveQJUukePd3RSMu/8HwjjAeJdJcRbcyZNca7N0CKXcrY2JG1ACZbt9sh0tG8jQhyakyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oQ+IgbM3U2TACPoMzey8bFiRiViBvBOl2SMQ++5frg=;
 b=QuwBUdL6nL45dBxxWtJXv+hPXx1oAJ70VAZ2TQmE8OORuGxvf+EJUva+8XeIiYQjrE3T00I+vP152NdykqQNbovsMWFChZvJwHFRt9cYezp7dPMcXaNNnW8aAWRy2PfHC4Bv2Azdl3wXK57zpqa3fcZwyjAheR4PB0kF2e5W+yycAFiEqVvzxgByQXpFl0+M5EAGwkyA8R+eCOoYYx12hsDgUzbyDbuS0tTM6fz1DsWYSwLHg+Q9dJhcKW67bn8RIzZYKJqzmMNPbkeKC4c4KPNm58t/HhkL3a3yGfcpBPdK040YxnHVryHtvwmRktHA9XA1Tx6BVRDpES4nUundXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oQ+IgbM3U2TACPoMzey8bFiRiViBvBOl2SMQ++5frg=;
 b=LF+awRdfji47KgNricv10DPhSF3YgzmWrZEc47TAANBTyrRut7Vb5BI9zLDIzkdjnYt9o/eToVVhdwgotzhgV/SmCziyccEYGBdvKhgMkjYXW8YI1y7vTqcpQHk9SXOtipcADddh10+6gCQxVg/i5Cdlgtaj62Xe9sDsV++T06k=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 01:09:31 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::b7ab:75e7:2cf9:efc3%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 01:09:31 +0000
Message-ID: <69914825-e9d5-4859-a5a8-60d17e8e8bf6@oracle.com>
Date: Wed, 27 Mar 2024 18:09:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: cancel CB_RECALL_ANY call when nfs4_client is
 about to be destroyed
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, linux-nfs@vger.kernel.org
References: <1711476809-26248-1-git-send-email-dai.ngo@oracle.com>
 <ZgMToHNkkGEHNb/y@tissot.1015granger.net>
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <ZgMToHNkkGEHNb/y@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH3PEPF000040B0.namprd05.prod.outlook.com
 (2603:10b6:518:1::5c) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CO1PR10MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 03878f45-324a-4682-bbbe-08dc4ec3b928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5xEgu6d4NLK1qXMy/plkLRyRjnlKtpopboOrvpf1G0VtJRIdWW9sDFe4j0BCPSA4eCk7kvSKEUC4jq+eYfICLm18dVPr/z1a2CAjjlnLh7Ir3jZHN3I03jzYnD7e+QJXyJP2mLlPexWPcROx0i6F8VpkNNPQ/dHUNwcN+QhfE9G/TqWi8cSRplVK5AGAsjL8JpL8tzW4MX/qK/CQn431043JibmHqQQkOGJwUFU7Y0Ay3WE06vcmVwLTqmn3oem+rrsaivIeAfOPxbTPgPq4i3o1BGe89i1E+BxHUP80IhGLYPn7jIj/HtLpndRKZG0+Qj0hMQAZIgb8yGU2UqeYOZ/ssJThgMMF+b+wEN5/eUguS7soPQ6RNV9fnfT6vZKWHhHZo7E+Z1r1Wltl3QwbmRvqQmfJqCH1ja0yXHKHYnhjeWVHeKkN/Y3rENSxEPU5Zfmde8KwHxVT4QWaba2W5IJzxX+wd/QjkG97OUaLb4prbwUFi4xt7/qZbV//8VPCuztursivQo3dr0cJEWfCbLer67qugrzXbcO51yQTpTTxfGCuOQ9TpFEus9VgK3zVzCKGGj2EjOlC3qiZLM2heuYYsfvg8NfMcVcVdo0ziKIZ7Ea86JqThyZXq/cqqA6JMOltVxVbyfOj7uyBMkK4pSqjDtRUCUM9N16HtLPOUPk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bXk2cGhFOXZLem5HV00wYXF0ME9kVi9SbFdiWDFrRmwzcWorbGdYam5iY1cy?=
 =?utf-8?B?OEh5ZGN6SDFTemZra08yaWlJWThvVnJlcklyQWpwWTNPVnh0aTdzQlBYQWRB?=
 =?utf-8?B?UnpHeis5Ylo0YURQbndVUFhTZHdzZk8zYVBOczRwRjQzakdwZkJ0a3pBSW8x?=
 =?utf-8?B?RjNqdnBGZnFBc29UaUkwTUJCbDlPcHhtQ2M4YUZWcHVNWWRQWUt5aWJDRjMy?=
 =?utf-8?B?TmJCQXFHMUMzenRtaDQ1ZmtxdUhvU1BZRnZDUGRDVkdycTdoY0cvdCszRVFW?=
 =?utf-8?B?OXoyNkdRMzhMcy83TkU0cGVKVmZibytqaWMxOTF1S01SSHozbmZhNFV4d3Rz?=
 =?utf-8?B?RnN2TUxRRTRqM3d0TlM0S3RNSGNjUkRyUzl4RXNTNmxZU0tyTTVCMVRPNDdy?=
 =?utf-8?B?Zjhqb2ZqMTVjM1I1dmQ3ajRXYXBpWTNGNXU4QkZseGlpcVBITnpVZ0kvVU5C?=
 =?utf-8?B?Q2h3VTNsOGhhbEdSVUdsLysyMzRxUDAyaWRPR2VWZ3B6NkhVYjFsMnVNZ3BB?=
 =?utf-8?B?dlEwdE1EVktVNTVPOEVISUNCOE9nd3VBVnVRWmhwQm5qMVlCejdjZHNlQXh1?=
 =?utf-8?B?Z3BhMktURmk3R0lsRjZBRUd2ZVRBY0gxU1AzTk5sR05yRkkxVkJIVkdoeTdV?=
 =?utf-8?B?dXBvL3ZlOUl3OFBFbU13SnpyZkdoUVBsU1lyUkVtM2tsUUNPK2ZCc2hUTU5H?=
 =?utf-8?B?a293MnNUdGZXUUF0VURvV1NBTC83dk9RS20wOEF5ODRiZGk4UU9LWDdOSUh1?=
 =?utf-8?B?VWF4bzFnSUlON2gvcjh2Zi9SMWM0ZngzcUVGVnljS1hYek81NURkTDFkbzJU?=
 =?utf-8?B?c3FBZVkrZUl6YThmWEwyNjJoQ3hjdjM1WGFHWDlrd29PcDYrdjlnNVl2bEo3?=
 =?utf-8?B?MnRreUM0VGlTdFROT2VCVlc4bGJZVWV1ajFlQytZei9mbUhGT1o4MG43SCtG?=
 =?utf-8?B?SHBwUzA5clZIRnpnZ2czS0xGdXhoMnQ3VmxHZTRFMVk2bm1lNGZzSzlxS2hm?=
 =?utf-8?B?SDFadks0KzZNbUZpL1FCZThWbDE3MHdtOFZCbnBHcUF5cWxDQWp2bU8zMnFT?=
 =?utf-8?B?NUFDWFVpeVI2emlnL0ovQWhWclV1YnZBNGNMRGN5dDVWZFRCSEgyL1lIRzBT?=
 =?utf-8?B?R1ZqM2JqU2VlTlBrQmdKRlliNjdGNXJXL2hTdDMwWVJiMHc5aS9lSk1Da1Y1?=
 =?utf-8?B?TEJmWHIxTURHNi8zd3Bvcm1tampuTjBxemtVcHVzMGJNS2lndW9aL09LcHp3?=
 =?utf-8?B?WHUrblZieTV1UGJKL2pzVm8vc0E5U2VlZ1BJaS85UGZNMXJQcFNxamxqYnZo?=
 =?utf-8?B?d2RDYzErWkkwSVdSRS9MSWVWODNOajF5NTBBZjBLNWRITXl4aW9obEYxZnBK?=
 =?utf-8?B?dEpkSDhDUk5uWnVHekFETEJoKzZRVGIzbm5oOFYzUCs3SzZmVUNhRUdHclBZ?=
 =?utf-8?B?UmZVYUg1VGM2V215YU1NajVHT3RZU1V4THhTWlRWckdvRXNwVG9WdCtGdHhl?=
 =?utf-8?B?anhIbTVmOWVnRzlNOXAybEhTbzliRzh0NnZwQ0F3VlMzRnR2WGxFUWlReTh2?=
 =?utf-8?B?bVR2ZmYwRTBLY0hraldKUFRlSTk0b0pBMHY4L0NSdGxLZHQ2SENEL0syWXVZ?=
 =?utf-8?B?dEVsVmZ6dHg5bXhFY2h0VVd3NnljWnlOUTE3aVprdEw4Q1FRWG01LzI5dXdC?=
 =?utf-8?B?Sjh2UTZtZzZYWXhZQlVSNW9JZyt2NlRBVFJoZzRGZFRZaE9VZjFOZ05IY3hK?=
 =?utf-8?B?SUFFUzJUeFNpS2RZYW1IbVR6TS9KWGM4Qkl4QnRmcDlLaVBnb2lEVjFXczA2?=
 =?utf-8?B?Mml5NDJQbGM1VE95RXcwRDlKSWtHUFZ0MTZKenlDNnphZ3JjNkhEc3J2U0R0?=
 =?utf-8?B?RXRtMmxJSDJ6QnJ0elpKdGpRc21PVVZUakdZWUFvd3hBaktJV3RGK2lXcWNr?=
 =?utf-8?B?VUZiVHkyU0RGVDV2SWFFZmtWMzlLZ1dmeFowdThVWUVFRVRWUDIvUWpPRzZR?=
 =?utf-8?B?bUVYQW8zR2xDTXljRzlJdzloT3FTcWx2MTMxaTJuZVl1RGlsNEJYSGk4Mjk4?=
 =?utf-8?B?MzkxVUtGaWQvOUZ2bDhDdTB0THdYMFdjVjFkRGJrSG9QSHdScnU5UDlWb3Fu?=
 =?utf-8?Q?RonQG6pLDJq+Ehe72Te+0Yl2f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vRR6UenPdRqaKqOnRAmeKUeXhmRq0tVUjf91sAuJ/2uS36zql4Vo5r87b9I4R0xmReWWC7WNQDuCYIfOcntC0j7fpYZoHMoMKjaHSG0CfkdLvP2QntkOAsJOn9Xe/+mnQrPi+LzqjhxSVN1vm3MCfOQK0X0tI8GxeSGK3t/NDd+pOl5cnVtL4vH0RR9xb02neVkhuZDw+eMOiUPd3UUzVTQSpti9rNxYoFfY/2UBiKDX2oe8kicYJMc3ZAk1d5lE6DfOtRuTDDXhmh5lTZF4dsWQPI/+D87AKkIPr+IoDax0ohgLe1w+Rbh4K9fKbwuhwBTVhctYnNQ10Ow8wm2LpFGU1BEFLyfOK0PWD2wbbLLb2rCikPIEl3wA30bpN+X1lMxK7eaiJn1hJkkpRGDZ1QO5uelazH8VgkhAUhUjvMNFXElv9qfK1lwk5T9QznN1iWbnUOLbOfs0l8VYqPSINxkcCMbwlGfdB6TVHyv7CmapRmODO14evAFRmHw8OaraymTLHLD41MXg7DWSBXVzYRk4MhGyp2vsgjCQh5Yd1xfKQnc6Cz+A8JJU2NHymZFGAttBSQsta+vj72ebas4BuCCO+4TO4D31MA1AIIwVTYw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03878f45-324a-4682-bbbe-08dc4ec3b928
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:09:31.3282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIa/er8ETVtYN4X8fzJexiy62gZnCo+QC2osvLqNoDmOAP9FbINNKuwaln/1A5eBxw0EEODbiS27dWKcoiM8+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_20,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280003
X-Proofpoint-GUID: hQeE3HckhaMd9_pT4mw65QVu9hhAh7nT
X-Proofpoint-ORIG-GUID: hQeE3HckhaMd9_pT4mw65QVu9hhAh7nT


On 3/26/24 11:27 AM, Chuck Lever wrote:
> On Tue, Mar 26, 2024 at 11:13:29AM -0700, Dai Ngo wrote:
>> Currently when a nfs4_client is destroyed we wait for the cb_recall_any
>> callback to complete before proceed. This adds unnecessary delay to the
>> __destroy_client call if there is problem communicating with the client.
> By "unnecessary delay" do you mean only the seven-second RPC
> retransmit timeout, or is there something else?

when the client network interface is down, the RPC task takes ~9s to
send the callback, waits for the reply and gets ETIMEDOUT. This process
repeats in a loop with the same RPC task before being stopped by
rpc_shutdown_client after client lease expires.

It takes a total of about 1m20s before the CB_RECALL is terminated.
For CB_RECALL_ANY and CB_OFFLOAD, this process gets in to a infinite
loop since there is no delegation conflict and the client is allowed
to stay in courtesy state.

The loop happens because in nfsd4_cb_sequence_done if cb_seq_status
is 1 (an RPC Reply was never received) it calls nfsd4_mark_cb_fault
to set the NFSD4_CB_FAULT bit. It then sets cb_need_restart to true.
When nfsd4_cb_release is called, it checks cb_need_restart bit and
re-queues the work again.

> I can see that a server shutdown might want to cancel these, but why
> is this a problem when destroying an nfs4_client?

Destroying an nfs4_client is called when the export is unmounted.
Cancelling these calls just make the process a bit quicker when there
is problem with the client connection, or preventing the unmount to
hang if there is problem at the workqueue and a callback work is
pending there.

For CB_RECALL, even if we wait for the call to complete the client
won't be able to return any delegations since the nfs4_client is
already been destroyed. It just serves as a notice to the client that
there is a delegation conflict so it can take appropriate actions.

>> This patch addresses this issue by cancelling the CB_RECALL_ANY call from
>> the workqueue when the nfs4_client is about to be destroyed.
> Does CB_OFFLOAD need similar treatment?

Probably. The copy is already done anyway, this is just a notification.

-Dai

>
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4callback.c | 10 ++++++++++
>>   fs/nfsd/nfs4state.c    | 10 +++++++++-
>>   fs/nfsd/state.h        |  1 +
>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>> index 87c9547989f6..e5b50c96be6a 100644
>> --- a/fs/nfsd/nfs4callback.c
>> +++ b/fs/nfsd/nfs4callback.c
>> @@ -1568,3 +1568,13 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
>>   		nfsd41_cb_inflight_end(clp);
>>   	return queued;
>>   }
>> +
>> +void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp)
>> +{
>> +	if (test_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags) &&
>> +			cancel_delayed_work(&clp->cl_ra->ra_cb.cb_work)) {
>> +		clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
>> +		atomic_add_unless(&clp->cl_rpc_users, -1, 0);
>> +		nfsd41_cb_inflight_end(clp);
>> +	}
>> +}
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 1a93c7fcf76c..0e1db57c9a19 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2402,6 +2402,7 @@ __destroy_client(struct nfs4_client *clp)
>>   	}
>>   	nfsd4_return_all_client_layouts(clp);
>>   	nfsd4_shutdown_copy(clp);
>> +	nfsd41_cb_recall_any_cancel(clp);
>>   	nfsd4_shutdown_callback(clp);
>>   	if (clp->cl_cb_conn.cb_xprt)
>>   		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
>> @@ -2980,6 +2981,12 @@ static void force_expire_client(struct nfs4_client *clp)
>>   	clp->cl_time = 0;
>>   	spin_unlock(&nn->client_lock);
>>   
>> +	/*
>> +	 * no need to send and wait for CB_RECALL_ANY
>> +	 * when client is about to be destroyed
>> +	 */
>> +	nfsd41_cb_recall_any_cancel(clp);
>> +
>>   	wait_event(expiry_wq, atomic_read(&clp->cl_rpc_users) == 0);
>>   	spin_lock(&nn->client_lock);
>>   	already_expired = list_empty(&clp->cl_lru);
>> @@ -6617,7 +6624,8 @@ deleg_reaper(struct nfsd_net *nn)
>>   		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
>>   						BIT(RCA4_TYPE_MASK_WDATA_DLG);
>>   		trace_nfsd_cb_recall_any(clp->cl_ra);
>> -		nfsd4_run_cb(&clp->cl_ra->ra_cb);
>> +		if (!nfsd4_run_cb(&clp->cl_ra->ra_cb))
>> +			clear_bit(NFSD4_CLIENT_CB_RECALL_ANY, &clp->cl_flags);
>>   	}
>>   }
>>   
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 01c6f3445646..259b4af7d226 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -735,6 +735,7 @@ extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *
>>   extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
>>   		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
>>   extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
>> +extern void nfsd41_cb_recall_any_cancel(struct nfs4_client *clp);
>>   extern int nfsd4_create_callback_queue(void);
>>   extern void nfsd4_destroy_callback_queue(void);
>>   extern void nfsd4_shutdown_callback(struct nfs4_client *);
>> -- 
>> 2.39.3
>>

