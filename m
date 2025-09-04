Return-Path: <linux-nfs+bounces-14044-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BEFB444DD
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 19:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC321A4135A
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECACB32A81A;
	Thu,  4 Sep 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="O4pl2QY9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2112.outbound.protection.outlook.com [40.107.92.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B2322A2B
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008375; cv=fail; b=Byw+aSCRJ/DRAub+bxhTVjtSanQ0wSzlsH03FC0C4MJyREX1VUEnsTieb4aAoWIJ1s3cAVOAx2Y5jMU5ozEeVUTJnrW0v6NwYafvFySdyUOJ3qntaPUu7em9G6Fs/mQoA7JZPhEMEhs++nbZo0A3D09ZAJmIS+0EVPIFLjk/U6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008375; c=relaxed/simple;
	bh=FF5R0j5L5bDxzyOTvGWBsYzylJ3Z29rDn6mPqh2bKQk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GbsdbD5dWeuxt2qygVK0u0f9F6B+s64wo5e6pEOgsi6S1ERPyNjXKkNhy+9kpNziRkHM7kbmEDoJkEAsDVhBLGh8WisaWi2glfnKg+c/gS0xxe1akEKiind2QWtIMGhWq82HZ9XTUjez9SDUmbKvvrPFH7d/esarxn8suQF5QwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=O4pl2QY9; arc=fail smtp.client-ip=40.107.92.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dv5UCZpDuI0w0t64iRo46Yu1loB4hrGLAw1NRFaIl3T6jjuNVTmWUzvGo7d1hBNpcfzBPw0D7Ans29E2a4bh2CXIpnc1StZZJsyZyJuXk0ein7tEd/t7pJ31IuG0RrmbS4iaqyygrTSS3KMsiY0yxKJim8O3u+XW6CKCGTa03tDAvV7KqFlk7jk6pw9ns2hbjYfKYKxAdamx36bj74Js3MYwNs22lmXSQijen5ZcmINFs3GdLlc/D2nFsN72cnCKcDdywuNaFmNthxKd14Jz7333Vus9sTq49BuN8C7mtPaxQl47E+iS3oq1nEHMrjverPTYSm56oNG6a2c5HmsPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FF5R0j5L5bDxzyOTvGWBsYzylJ3Z29rDn6mPqh2bKQk=;
 b=itN27NPzu8gYvgQSkAKhvKTlY76z/UiUwflUMx0eWj9OLas7PQMyoNiWPJK0oTCBpeXKzlrsWR8GKwQFzC3l7ImSjA93N811LeSvk5qCor0zJY27Ss79GAQVLvXJW7YPeqwohuVhr4bsElXq1CVKapp3j1VeJFdCeYyXL+SflDT4/P+7g4D9X0HDHNMXUC5Qq7N9hyjmsJ7EnDzkixfPKLhdKJ99J66PNDM++hBJavDRqbY16sh2j2qTvHGRtg6e4MfUdEp4UA9N8HPPtWl3ARShy9+3qUrTHtocVVOwPZnwcDRylo+vSKK7opMiwaIadJ5YTLEY06In9R0a4FpGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FF5R0j5L5bDxzyOTvGWBsYzylJ3Z29rDn6mPqh2bKQk=;
 b=O4pl2QY92I3BfJKm6WUFeed3Eu8iWBMqRv1sanovM7XqCd5mt5LSu124OOXrq7SOxnZqQXtXj256PkXmUyLrscfu+CvGViPIV4tSb7Dr9+gCn/zcmZQyzblshi0iJkaAby7kuiaqRkELMJ5KLX24sjIS4yyvOXHeUCPQxLhQTD6rq6YoPzKZtiLZZl72f4PdmwP3ZTOnSaz0OwvOHdHaVjACDxX8TtAkSYSyhYNkwwWahQiuafRphfQRH/HChAwk8exdO4UYpia0RatVq0iEZNYpQEWMCCax7GIPKwqjwfyplZkxtGE1OGExbsKyEIgkpfRCoFHscxosCPLl3mcTng==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by DS0PR14MB6925.namprd14.prod.outlook.com (2603:10b6:8:f8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Thu, 4 Sep 2025 17:52:51 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4%6]) with mapi id 15.20.9052.027; Thu, 4 Sep 2025
 17:52:51 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: "Andrew J. Romero" <romero@fnal.gov>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: GSSPROXY ( for NFS with sec=krb5, krb5i  , krb5p ) is development
 still active or is it being depreciated
Thread-Topic: GSSPROXY ( for NFS with sec=krb5, krb5i  , krb5p ) is
 development still active or is it being depreciated
Thread-Index: AduTpkJL3Z+Uz30mSiOYGbEcxqj6hSKHVvbb
Date: Thu, 4 Sep 2025 17:52:51 +0000
Message-ID:
 <PH0PR14MB54937B2DEB65E01D5B40C97DAA00A@PH0PR14MB5493.namprd14.prod.outlook.com>
References:
 <PH0PR09MB115997CF2D7A117949CDDB375A7D02@PH0PR09MB11599.namprd09.prod.outlook.com>
In-Reply-To:
 <PH0PR09MB115997CF2D7A117949CDDB375A7D02@PH0PR09MB11599.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|DS0PR14MB6925:EE_
x-ms-office365-filtering-correlation-id: 1fdaa434-f277-4e11-8bbe-08ddebdbde33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?La8rH2LPkyhuoWy2yAjFQ4QuQ4tsVoYAsLdWmK7OoeC+FihIvQgodj6i3L?=
 =?iso-8859-1?Q?cfQl4wQ6krxp13xKPfGp+Fq5BTalw9cDJuQhuVKQnxuSgIhup414xNK5os?=
 =?iso-8859-1?Q?JkdY6+RkcEt5LKNpWxl/dKorWgyCo+AVreo4/9ddVD+87dPITZKRXwMIop?=
 =?iso-8859-1?Q?QzRb7JjyDhd6Yhb+7hjRsGG9suOwMQOfHgOOO85C1ZMn3gewFBS7D4AYBF?=
 =?iso-8859-1?Q?fRS8ESEzX9iVCj3BJ6A5BEPNaN74MTu5IkFrJ95zpZj/dlEfLogVX/MQ7V?=
 =?iso-8859-1?Q?ekyx099w3Q0xcUQLlbKbT9n1i/LOEnxwsRa784w+qRnTyN7RShy55irjoq?=
 =?iso-8859-1?Q?y961SDAXIooFaYQgIS1TN6xRV8f+Zb1TY2Y14yj2AxKOav2n/m/3OntYvf?=
 =?iso-8859-1?Q?/6fgUBeYnEqwMT3bRw/ecAda/meCoZxH2Y1Js0OcAV7lDgzTkIBFp2fiH4?=
 =?iso-8859-1?Q?fLK6L009kkUdd4A4tAquq32l/YCoRwqBPMhWi6QVkOqunv9bgbrNJ2kiR4?=
 =?iso-8859-1?Q?3qDMDl9bhtxX4elEWSG5mmHE7K5QDk8jnWZTpN1nihYb3elh+KPt0t3UrD?=
 =?iso-8859-1?Q?akTIqGvl5sPj+wtE7wkIHtSMAu9MxJ1BJJ4kDgqkLZ9O8jYD/KwIBoxon8?=
 =?iso-8859-1?Q?GeAiZoNqffKMz5db+lWQWs3/c3tp0Aec2Ief3N7sVgJ5diERWtvSpnm97m?=
 =?iso-8859-1?Q?GWdtjRoinx5DWnHGFweCdmG/MeeRPkYAlMxCtSptl81E/WsqBIHNHcTLLa?=
 =?iso-8859-1?Q?iSmYOAKxHtUxfHbJVhlvr0LOD9lSfoNxIf2dsg8RYFvKuSl3C6pBAHcWRz?=
 =?iso-8859-1?Q?jg4dmfarZV4xGT2LjsQBzlDNLXdci7EDZze/awvgfsmwzLoSl9L/LgsF9Z?=
 =?iso-8859-1?Q?9ZrHORy6DAdOGgTkQQU6y8RHT+hSozjLFJTrVch5iaZzKzHJT7Hzpf6Dij?=
 =?iso-8859-1?Q?6Upsdayhfeux1X39M+oNrQ6Z/xi26tB3N3kExgWyfs/bE7tNJ2S4Onq8l+?=
 =?iso-8859-1?Q?lJAsdtyBW7MII4/92EHQt/iVtNnKfXmDJ2Gihmpxt5CWEhjta8v66khqFQ?=
 =?iso-8859-1?Q?Jt+pP8Tttgp5q7hCbWpCitHBear3x9WoMizaTo0vkXz1jFVVsOtpJy7938?=
 =?iso-8859-1?Q?BT3I7nhb22YcOr6Zya5g/9SnpsAWWfN92hyjJJrPeFD7T5NQoS4xQh3wfE?=
 =?iso-8859-1?Q?Q5u/f7ETZ2id+mdFacMLus2GCnSdvvJKW2Bck+d8g5eiwHCoNOQE4kSUuD?=
 =?iso-8859-1?Q?r73S6PsuN8KMe8ouyZoWAtMPSNvu9sg4tf6vFbLmvgGmbEZkz5UQzUlQMA?=
 =?iso-8859-1?Q?7SLczYBEQQOIbBouJzph6J3mZ67AF8ADA29DrIlRs31Ld1oZq5CamiTtVr?=
 =?iso-8859-1?Q?Cb+cDmVKGh+N30BaXho4CevI30Mns6mPvVQFcn4s0E7CqceWU0ABpQ3s9w?=
 =?iso-8859-1?Q?/JhT50RhQAbDDvIvZwO/am3cZExa5lhpcPax+gpffsr9m3Q3c+HXqveJyR?=
 =?iso-8859-1?Q?zUVNPNOSJlQ9btd+83BiBjhqWYqU/8RY3A2AYn4//72Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ihGGqGa+K0ynkeH8YobLMRyV7YGv08E8qNddrm3TBBF5wWddJex1ZbYHUQ?=
 =?iso-8859-1?Q?LGio9mS3IpE+cZhjzFi4t99pyMqtC1/o+WVrXw3xB6POg6OVvALLbouEYn?=
 =?iso-8859-1?Q?6chqUXokQDn5tIuyWwnin9MJshGYcrEV9rdBL6jGWO9MNcCdxm14E9uhSV?=
 =?iso-8859-1?Q?gL7hxdHatQKB0M586Or+ZD3g3UleusvYcmy72MAmBbDxb05lwUTmoFkWVI?=
 =?iso-8859-1?Q?cQn0jOCT3f9d1SHekIFGzBy00tJ8v3dvPI6RRr3NIclmyGTDhKKNPyxlth?=
 =?iso-8859-1?Q?dvSvpx9f/DKWkA55vEqp/HYpqgHyYdrGgHCTY4HQkJHS/sHgK7V291jQpb?=
 =?iso-8859-1?Q?hUt6lCefG5wZlxtud5jErifHAxa+x3tOskXPt/z1PmBw4tj42jWzGGJYzV?=
 =?iso-8859-1?Q?OJV4Gwkgt00iyKH6HSjfCc2VmRU9llcfel+suKD4gSAvzFb3Gal75n5Oo6?=
 =?iso-8859-1?Q?5VrWRuUdJyUFhb100HS+sRoHplS7nOqRhCIp0oy8GwHxHo5u+OAPQluiht?=
 =?iso-8859-1?Q?pM71qnaftbuWrdICvIpHaqRN4lFt81+uA+pERcCSPt6IrIe3kVAUdmEaz+?=
 =?iso-8859-1?Q?Z2FxwI9oCL8LpOPAwjERpV7NDV0ylatcFSFdPYh+48iWauXau31Ot/+Kzh?=
 =?iso-8859-1?Q?TtWYnuJX9PFbH9Bv68xRA8pkVbIngM1bHayvALew/sg2V/QZMRb6GCYAAi?=
 =?iso-8859-1?Q?QRd3rKZk+SKTUgcmKH85/dLLEYNHasOUFipIyQwMNF5uD8gPeVkyh5yIJ9?=
 =?iso-8859-1?Q?0L9P2IvhBjrPAiNHmdgNeaAP9L65d/yYj2n1uAxz0Kpovcwbkfu5+RsAt/?=
 =?iso-8859-1?Q?uyZ0nWASeffQaTTOa3OkDSjE/5p7sHRBphhIR3KtNPzd4CcFecRmlqYjAn?=
 =?iso-8859-1?Q?A0wsq6RMchABjG+VVHGg/VKo9Ldl4ZmXXo2kINtgLzmZg0QC30fThQ65l0?=
 =?iso-8859-1?Q?FP6Vc+jhoPPuLsk9BmqAHUjjTkglIYBIlafR6vPwhiu7uapj+/TK3ujdr8?=
 =?iso-8859-1?Q?7TUY/fUmJ6Be2QhdBxMwlWGqnCI5LG5jKTlV/6Q3tPYZWs8OQWh3wvKGOV?=
 =?iso-8859-1?Q?ucKRuyv6+4n2cFN4J2IMOUEmCY3bjkjOeXeQuZsQiJv76YHBxnelB0yhV7?=
 =?iso-8859-1?Q?GKQMAa44n3BbgXEKvEF1E+7kjIjIkaSMLCmaRH9/CJ9ajTP81KHQ0RiEkV?=
 =?iso-8859-1?Q?BNK/B090AaLgN+icivzsKG+u0oDm0wqkyhVzHXU2Sx8Fy1Ugcz7Nse/ydS?=
 =?iso-8859-1?Q?OfFKxx1eVPlUsNUcVybaOED2hXRSmWJLL9L2rWXZRhaMolsnj80owr7vrU?=
 =?iso-8859-1?Q?1YjzRIJgYweZiG8AcraEsGVKTRBYnwGBsi8i1MTpxZGXu/DQI3Be53/xRF?=
 =?iso-8859-1?Q?pRySHYPLb+7vrEyz1uAh3mKJkekZWW6uWhbYOoxJQBtgfVJHu/POJfRVic?=
 =?iso-8859-1?Q?u0VLBlrJ0t0uk0gGLTA4joSLXAEYGyE91uPofsyy+oIS+HmOQx48cBMCXs?=
 =?iso-8859-1?Q?lvXOXWss+bz+leOflByKtu7kfWbLk7tHUoMc3Bc9Jn9xR/FBnGPq7zy8aE?=
 =?iso-8859-1?Q?m2NhoDIQIEnzGSS0R0Oj8M6t+pHyebfx2Av9xD/UMnaII07yBE2xMa8VKe?=
 =?iso-8859-1?Q?qp0k41fOu4LXbznqiAGO6noBISgi1TvmVvH0/zBPa927UZ0ufpd+6hhw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdaa434-f277-4e11-8bbe-08ddebdbde33
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 17:52:51.4142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfNJtCecuvp9aGpuLB/l+Vvq93VMg5GKwr+rACuqzjpdWIZHfE/2gBsnpaNdUOdn6xwoDqiDeRnj/HwyoykAsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR14MB6925

=0A=
> From:=A0Andrew J. Romero <romero@fnal.gov>=0A=
=0A=
> I noticed that in newer versions of Linux=0A=
> ( for example: Red Hat Enterprise v9 ), the=0A=
> parameter=A0 use-gss-proxy=0A=
> (in [gssd] section of /etc/nfs.conf file )=0A=
>no longer exists.=A0 Why not ?=0A=
=0A=
> I have also read that some security specialists=0A=
> ( noted in stigviewer.com ) theorize that gssproxy=0A=
> increases security risk.=0A=
=0A=
> gssproxy facilitates the reliable use of Kerberos secured=0A=
> NFS storage by non-interactive processes.=0A=
=0A=
Note that there are two different uses for gssproxy, on client and server s=
ide of NFS. On the server side there's no current alternative. The older rp=
c.svcgssd has a limit to the ticket size that makes it not work reliably wi=
th the newest versions of Kerberos (versions using PACs).=0A=
=0A=
We are currently using one of the kludges you refer to. I was planning to m=
oving to gssproxy with constrained delegation, since that is a standard fea=
ture and thus likely to be easier for other staff to support. If there's se=
rious plans to decommission gssproxy, I'd like to know, so I can arrange to=
 make my kludge more supportable. Supporting cron jobs is essential.=0A=

