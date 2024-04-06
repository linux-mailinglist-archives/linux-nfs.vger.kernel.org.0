Return-Path: <linux-nfs+bounces-2689-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C094E89ABA0
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 17:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3651F21589
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 15:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE3739FC6;
	Sat,  6 Apr 2024 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ImtJPxh3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E739FC5
	for <linux-nfs@vger.kernel.org>; Sat,  6 Apr 2024 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712417389; cv=fail; b=HrW2QG9XiNI9Eq3hWGz9h1AW0M1cS+qx2MWRR6zLcTGcrj0j5ChKoUjk0TbOTs88WYm/+NFiXiTpe4hS+acpTJsWG31GiT/4M/mfK1DZj4hy2+CXqdfyzYd+1DfYh1sKidgkaakN4LKdbWvmmw6Yz3Pz/2HEq6vCXmSCiKpKedE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712417389; c=relaxed/simple;
	bh=E4TK/1qORYj9SSnT7o46ajyCkS//EfShpj0z3O6BbQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aMLVUkiQiBMpqIMxIgiEKihll7vR25ct7jfjdXuIkN9WSZaA4BKSuXc2A9b4I+a4j6mhdQLuaVA7TqhNZ3nxlBJRb2QVL6lDV33sFURsyXeWQTG6SoFuFACy4yiNKk1LKddlsJmpd9CGtFIpSsFrNlKkzwWAqn6X0medBIrlk74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ImtJPxh3; arc=fail smtp.client-ip=216.71.158.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712417387; x=1743953387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E4TK/1qORYj9SSnT7o46ajyCkS//EfShpj0z3O6BbQI=;
  b=ImtJPxh378KBkyWrakZ7IvcJrLPY+oZxaVwr8DEkUlJXiH6Uj37jcEQn
   TFpz7IowT+0BDg9u5rtaRkKjkzSkYGhxjIs212zRo28MVFeOAa209yLou
   ///CsiLzr3kLsCgcNQPOosr0vkfj8EHrhazdPWMAhpCCaL4y0nh+ZdxI+
   2wAQE8KUBha9HdAcIetbRobTBULo9/I/xRIvgWx6cQPY2znoBynBtRJ8f
   0fPxujgcwCzZ4itVD8iR6xhTM88duj51jVan5wtXXHzjPL3z+/dJUeEvC
   oiDKrYn+lATuI1pxG6yJFtbRF/VYBg0WYHNcG0apMgsVNhtwSBjbRuLW7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="116066778"
X-IronPort-AV: E=Sophos;i="6.07,183,1708354800"; 
   d="scan'208";a="116066778"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 00:29:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egXK+D/l5iS9n6LvlEO+2u08fVtXNu+ZMxZGkC8TmMLJEGwfY+RHrgjcg6hQj2Nx1IQl3lJKO/9oR/MLvj5GXIu+hB1f1kVbAjUg2ANzTsCXrRrxc7AAtNqHiFOs/rRE1NjAsdMfsEqeVZQDesl1CeXltfBWb5aHTqXLjFVYh+3xKBYGxmhtUEfwPAyLry6GtYGpahG+Zt73ikNWKJQTBt5T2J+BWdkTUrVig8q7bKznrdvWwlzMk3D+yPTfXkJN99D8okMdY67js3nqHbsD1n7Cl03hkFEmEpvkjj4GXD+hkYUzofZQIgZHQfED2oQjw1VmR69tmww98PwnYME/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4TK/1qORYj9SSnT7o46ajyCkS//EfShpj0z3O6BbQI=;
 b=Q1d7250C5QfABdIpc1Kjl+pnhg45wMUBz9Pw+X+T/QeDfGXSTfLj4apOO1lC5NqF5wDZVk7H43/b+69G/6a449N8+pRCyhRMaM3BtHHey7y3r5f821Ct7VHD/x7Zc9OQ2bI6w7lF9NFTr7L66a4cmIPLdtjhxjIPOkyaKPGGln4h8f5Kq6x7W1J6YkZCBStQwacxURobPJgpbQfdMU2TkljZIH5UZau3E8XH5OJkUNca3N3zhCc8a9II2d6YQXvKaUbRtKcjvUDGm9LCywRaZgmq0wSi+zTzYd9ujLLTJ9BXCb2ve1V+NkTQ5WI8MXi/9kACRJmON4a13yJspf96SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com (2603:1096:400:447::5)
 by TYYPR01MB7927.jpnprd01.prod.outlook.com (2603:1096:400:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sat, 6 Apr
 2024 15:29:32 +0000
Received: from TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485]) by TYWPR01MB12085.jpnprd01.prod.outlook.com
 ([fe80::d966:f2b7:cccb:3485%5]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 15:29:32 +0000
From: "Hanxiao Chen (Fujitsu)" <chenhx.fnst@fujitsu.com>
To: Chuck Lever <chuck.lever@oracle.com>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: trace export root filehandle event
Thread-Topic: [PATCH v2] NFSD: trace export root filehandle event
Thread-Index: AQHagSt0e+Xz1sGnj02hKF9PSxk9fLFaDNYAgAFfQmA=
Date: Sat, 6 Apr 2024 15:29:32 +0000
Message-ID:
 <TYWPR01MB12085681A09D7DA36C4114F93E6022@TYWPR01MB12085.jpnprd01.prod.outlook.com>
References: <20240328161654.1432-1-chenhx.fnst@fujitsu.com>
 <ZhBDsqxNnj+b5iRg@tissot.1015granger.net>
In-Reply-To: <ZhBDsqxNnj+b5iRg@tissot.1015granger.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=b79e8637-9ceb-40e5-b43b-14d80e9b25fa;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-06T15:16:03Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB12085:EE_|TYYPR01MB7927:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RfJ18Hcb1A/mtaygauxkOxT8AYpDrzFlV1GoGoCvQcEhWEOk8yz3dJQ1Abfd++LpotVX9jr938arc+V4dmKxpCnhMDM2DZ/AgTPkK2JqGe8Tp/qqfbRoirYzpcLpm1QFCaahB3YiWWyXJRaR+5CuX3b2ZhePmo+LU2rxmNwWuavmrYn7i8ZPBsHyblTOqXUZMAWUyka0B+2wDd74Rpfr1FbyGzjN8uHP1hUrYJnPYRc5EfFw6fe7N9ApuF8yTV5nLNX5Uj8nv+l1NBb+1kC3M4UoDJmDdJxEcI1Ri7+fwsDUrQnxB+hTUDtOki5CKP94/yi5L68nwtYbDWw6fiE9+IDkVKx44FQDgsjWlhsCrbVirE5lcRaKju9X47BYrkJiWUqddV6WRI6Rirc7L6UusFWXHWPcAzDOuQwnr9spd0N7F1eOU7t4CzRV89NUmymh7mRWCtZncrnjL3Aq4tjjoUqDVfGJydpt0xKBr40q9kqehYNF5xgfX6XT+kmZeOgXaL9zTj0Oq1hpxXNa3bj5JTyALrIsTUcT/QWKQe8fH/SBnLuAEe17DEFu++FamjIV5eChoyGG4O9stK9fYjgc+iUTkKm5YvVSFfh59pq5rXgSi0KR+zgYY+ZZ+wlaIIL7hh5jMxjMz8YrFzLB4+hn6xhO3MVVBtBz4q/BJdKx6EqceO1Rf7qy5bpuxXaH+LfRPfJtbPXpEgv9lAM5r+dKYQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB12085.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NWxZUlhaZHBZcnZlMnpPcEFzR3RrUkVzcGYwM0h5ZTdBZERTNEpUOGZIVWg4?=
 =?gb2312?B?azdVeVB3K00zbGhjL1Z4SFhKWXlWUHJhTmpyZG5FV0JTLy8vRkEwVWNjblNM?=
 =?gb2312?B?WEZGWVdHZXJNVkRNUGJsRmdOOTM1Y2ZHWWJpKzNUaS9kODVYejNUTTFobWt5?=
 =?gb2312?B?eVVoR01NTi9pLzh1bDlGK0xZVTB1M0lVQlNWZUUwMUFCWS83NWRMbFBRVVhP?=
 =?gb2312?B?R3FyTElxL1E4RVFKQnBxT2g3L1BkSUVJbG44bFRjQU94em0wZGJjck5MdFlo?=
 =?gb2312?B?Qis4ZTh3YXhXUEM5a3gvUE5EUWgwdEJGZUdPWVZJN0hGZWRoNklVZWJpVzNh?=
 =?gb2312?B?YXZZY2RHaTB4eUVsbkE1SHNGRjM0ZWFiZStvUURSN2xqeGVqVmRiREovTFQw?=
 =?gb2312?B?UkZsQU82OW9tL0RQV1dRTkJYRUZQaW42c1J1S0tTWkRmVFdGZkhRSVJxVHg4?=
 =?gb2312?B?Y2hMU1pIV25zVlNlQWJJVXhmUHpoeEJBZENaZDhhMklxMVFnNlBmRXV3MlZ0?=
 =?gb2312?B?N3R6RWR1clF6NGJ6STY0NkJhZ2FnQzJEdE9FRU91dHZIc0I0bGZhUHJKN25t?=
 =?gb2312?B?M1JEZ1VSaVNuTFRqRUJLbGIyTmhMMHdRa1FsMXRzQksrb2lWNncrRTBXL2do?=
 =?gb2312?B?WTlwVC9MQi9HeGFRVWhqdFFESk5iYzNsRE1ncUJrVjAzZU1OWE80Qnk3WXdU?=
 =?gb2312?B?QVlSeFpnUnIxVWE0elE2VVhWMVJFdzFNVzlpc0cyeHhpUDhHWkUweGU5eEtF?=
 =?gb2312?B?UytNT2MxaVFkZ1M0MmV2MS9SM2ZpV1lSeHVqcktHU2VjOFoxeXhvTVNMVXBN?=
 =?gb2312?B?QkthWm5DalIyd1AxVFhsYlRyejEvL1JCOEUyTTFuMEJsZExIWkYvcWE4d251?=
 =?gb2312?B?eE90ekQzcWcxU281N2ROZHJjNmxXSFJYWm5EbFBUdVQrTVZkUW8rR2VMNDMr?=
 =?gb2312?B?UE9sRHVZbEUyaG5oalh2NXptRWhMSEdwOGJScWV6R3cyMGxxUkZFeU1xV1NR?=
 =?gb2312?B?UWNONGRUc0pBU2doNHBZVkFnQ09OVHpLUjNmSlBQbXhTTVdjaER6TGdEUGJG?=
 =?gb2312?B?L2E1b2ZzUldadUx5OXdGTWF6azMvelo4VWxNc0Jxc2dIeUJEemNKM2RjS3JX?=
 =?gb2312?B?NHM3VEZTYUFZWG10d29YblkvTDB5WjdLdTdTWHVOSG9UUFhDbUc4V0pCU0xR?=
 =?gb2312?B?NU5vSzlvRTkzZTJ0WXJBM2dIaExzRHZoQUFwUm1UcWd5NUJEM3hFODZTOG5k?=
 =?gb2312?B?eW5IbWZGZkNDd1hQVTd5VzY3MXNwWjU1b3A2amhnZDYvamRCNVB6bkNTRWhH?=
 =?gb2312?B?bXhzMVhkWVprZ2dJMlhsc0duWU5Bek9iSkZKRTNWTDdwYllXNHFWclI0WVBI?=
 =?gb2312?B?WjZoUHVGZFQzYVlqLzNvU1RHb3lGT3l4Rll2RkZlRlRNQUVNZGZUaStnS3gr?=
 =?gb2312?B?QmZMalVncTh2WW9BSjhiVnNheDJaeEFka1RIaVZSTWV4c0tGZzVtZ0ZEWlhv?=
 =?gb2312?B?cVJnbXovaVcxTE1EWkRUVVFNWTA5WG5NNkJ5RVVUcHFVbTVSemQ2ZTNNQjNu?=
 =?gb2312?B?MDRNWTBDbzJnc2drVlh0Njg1WXNQZU9pdnUrQzVUUUN5SmF1dnNYRWVCT1cz?=
 =?gb2312?B?dUo4a1pxU1A2aHlwWkJYcjlFWnFhL1Z4VTN6SzJlZVlwTUNVOEJMbDVoV1F0?=
 =?gb2312?B?SnNhQ3BwVi9VY1J6N0lOVzlCdGdORHZmSWVWWG9VUE52cVNqSTVQSG1KMWhs?=
 =?gb2312?B?MUV3eHRnakFNMFV1N3EvTVZHSjZHcVJyZWw5cnAybGZDWDRoU3ZZcjNvRDdQ?=
 =?gb2312?B?aTVVbnV5WEp6OHpFYjVIN2Y5M2hTajlGYVdnVU5mT2cvSmdYVFpDeUdjbUQ4?=
 =?gb2312?B?N1pkUHFhdXNmNjFSaG1BTjN5eFNobU40cGRRZGt1Z3lPdTZoRlVVZ1dLaVln?=
 =?gb2312?B?T1h5SXJtRHlrMm9JcHNodTg2MjZxaDMrOTN0ZzE3VGNoNU9scDFlaTlUL3J5?=
 =?gb2312?B?UWQrUU50aWxKNTFHZ3paVXFHUVFsdGhKTmJGYjV5N1VhSUEvMFBUcU81WG9X?=
 =?gb2312?B?dVR5UUh5VlFtS2RnRERyVUp3K3lFZjJYTWJuUzA5YUhUb0RpaGcyZU8rNzUx?=
 =?gb2312?Q?IsKqhSGNEJ40KhPes4Em4aMK4?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zmiWWO1P7qVme64fRuFr6l6Ilhl5sH+VKgTaTKgRekMP6i8XHj4z3YxJBH7WReMlAo2XuwAU2IxZ20u+ybUBqhqrlfPIYAwcpHQNnkxoyzLHbHYsSTjPMi3vj4Kx7grbrniS+/iI+WUl/Y4oD6cmSIJeKGc7VPQYkHfGsoLxhSEqQ4w6oq+Hfcl3Ah+rBlMe7V13qMZkX65J7GYm0n4nj69GkKYnREbGDT0qbdTNJi7E3T/2VY4Hu3pOnKuFRli8nXgEVm9d35evGhiN7bs3RrmiWnVr2PDK8fqCHYFblfepqH61ZbQS/3KLAUL6Og1QJkkXvds9B/+dny0qXM5a+dUaeX8TVZ0DD9gJ3pz1CLgFnbLItxahoV37VI8zC5XrLRMBRT5egxGdnoFwvLhlGnO9g6EVP3Htnox17H0MKEyOqVryHF/NeHOtOCOapxXR9VogCmdTKV05JHJmr+3vVNS7RmWYCEHY+PWG8P4LLdWzDW1nG0Ak/KwnkY5mYcNbjoQHv/bgZ9tKPbwfwTTX1kP16E6yXRKuT+BjBvfgHDa9hc9+WxU/FLSqoFRS5QFkXPpe86KhSNIjfOFkPlfZ/JhUPtNoFK4j5KP98ebYPHaw7Ksui6Ix/c1oDrtOzkGm
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB12085.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fa6b84-48c2-4da9-d172-08dc564e5bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2024 15:29:32.5910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wo5pfD1mBqD9C/BexT32Hw+g6RDh8DB9UYc3b3ZPZQ2g2AkqrLcrjTqWZpvCN23BhUGhM//TAHI8bbmSOV70Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7927

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxl
dmVyQG9yYWNsZS5jb20+DQo+ILeiy83KsbzkOiAyMDI0xOo01MI2yNUgMjozMg0KPiDK1bz+yMs6
IENoZW4sIEhhbnhpYW8gPGNoZW5oeC5mbnN0QGZ1aml0c3UuY29tPg0KPiCzrcvNOiBKZWZmIExh
eXRvbiA8amxheXRvbkBrZXJuZWwub3JnPjsgTmVpbCBCcm93biA8bmVpbGJAc3VzZS5kZT47IE9s
Z2ENCj4gS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPjsgRGFpIE5nbyA8RGFpLk5nb0Bv
cmFjbGUuY29tPjsgVG9tDQo+IFRhbHBleSA8dG9tQHRhbHBleS5jb20+OyBsaW51eC1uZnNAdmdl
ci5rZXJuZWwub3JnDQo+INb3zOI6IFJlOiBbUEFUQ0ggdjJdIE5GU0Q6IHRyYWNlIGV4cG9ydCBy
b290IGZpbGVoYW5kbGUgZXZlbnQNCj4gDQo+IE9uIEZyaSwgTWFyIDI5LCAyMDI0IGF0IDEyOjE2
OjU0QU0gKzA4MDAsIENoZW4gSGFueGlhbyB3cm90ZToNCj4gPiBBZGQgYSB0cmFjZXBvaW50IGZv
ciBvYnRhaW5pbmcgcm9vdCBmaWxlaGFuZGxlIGV2ZW50DQo+IA0KPiBJJ3ZlIGhhZCBhIGNoYW5j
ZSB0byBsb29rIGF0IHRoaXMgbW9yZSBjbG9zZWx5LiBJdCB0dXJucyBvdXQgd2UndmUNCj4gYWxy
ZWFkeSBnb3QgdHJhY2VfbmZzZF9jdGxfZmlsZWhhbmRsZSgpLg0KPiANCj4gU28gbGV0J3Mgb25s
eSByZW1vdmUgdGhlIGRwcmludGsgY2FsbCBzaXRlIGluIGV4cF9yb290ZmgoKS4NCj4gDQo+IA0K
SGksDQoNCglzdHJ1Y3Qgc3ZjX2V4cG9ydCBzaG91bGQgYmUgYSB1c2VmdWwgaW5mbyB0byB0cmFj
ZSwgc3VjaCBhcyBleF91dWlkLg0KDQoJQ2FuIHdlIG1vdmUgdHJhY2VfbmZzZF9jdGxfZmlsZWhh
bmRsZSBpbnRvIGV4cF9yb290ZmggLHRoZW4gYWRkIGFuIGVudHJ5IHRvIGl0IHRvIHRyYWNlIGV4
X3V1aWQ/IA0KDQpSZWdhcmRzLA0KLSBDaGVuDQo=

