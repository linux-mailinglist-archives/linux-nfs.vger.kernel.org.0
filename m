Return-Path: <linux-nfs+bounces-17347-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4E9CE6E53
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Dec 2025 14:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFD233005496
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Dec 2025 13:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701DE31281F;
	Mon, 29 Dec 2025 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="cj7G+Lre"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023098.outbound.protection.outlook.com [40.93.201.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC030CD89;
	Mon, 29 Dec 2025 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767015580; cv=fail; b=foPR8ekDWpfuU1syGopN89VWwEXEYDYWGqf7a8qEkUjBIVyoD40EOz+5VMDMJ+t3FxngReZhKSl91UcAlc0TB94yS7CglwbemXQAXvue206b4vCO8utxA2E1THWGnOiWt6M7etRhlgbV+uCfVhcVEAX4AwFcdKhXK/uyJnyKKFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767015580; c=relaxed/simple;
	bh=GU0QYWRnBMnpl7Ol+AUVDegjmP/118X3AR3ga97Uqs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O+pKYm6eMSdb12QhngpIkraOvekmSCaWqD430dLNXIoCiPC/ayeRTw+jXqPbpF3KuqJ3Km6+jCgkyIk5IHnFN/FV3pHXSiKX1E5DlqWpy/zcCaZJJ23dXkxTeUS9MuqvYHBEJGeKlHgpLMk+XfBF8kfTQadMrFsIVgnMxT9Q8Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=cj7G+Lre; arc=fail smtp.client-ip=40.93.201.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxB0vpudJsrF/gDbG7PpY130z/5Nwbd35Zi35KXaW/b3V6P9fOcxWQNVTtLsVXXWvrah0+gMkhsGYeTF3CMzxe3XV/WrM8zhtmBGlQgL0H7N4ZnxPayS5LHp458lijbLTonaY2UxKEXkE2EOEQJGGCqkzf+wR7dkEiavgeZf+zuR8kO1ImGVuVxZDhMhdygEgapJblb8tixRrB+sBDkbozJIlx20Tpwd8di8oFSeR6Cpxu3MX4Gfn/Cz1IExRq8cgqiNp0QcrEYMPPRxtB2g78v2YIN78P7GRI0rzX2iNo9u8H3RsCNlTrPSGnIWg2H8VcQVnNHHMvpUvHVNltWaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GTrbUyPoBlpW3pWEwmW4Aj9QVgPTwMsL3ile4fBelM=;
 b=koZaCSn5PqvVf7bugpla0KIHFJ7Wj9ZYFIeLtCFN258v5hNLUrVKENxGQWHbbEZUC22q3DTYLLAHuGn062htpT9oHf9csyVOEMjMzR7Cyc7RkWiTQcNqLF5rmlbI9hHU/HDapOr9gmhSF0qreh3VUf/Lfc8+8LKcewVVyLRyfXMQDSSzL2SU/IM9oqjKfTKXDO9RtQSWcAAnYzDkMIPxMDjB9D/GWpe80eTU65PYZG/psssljfYD3oNDVcG4qJ7ur2eG0fQFGoIz6Mu+OX8wezMEAeuwZ0/9svvmPH8gheyME9954tM0j9znJCI+/6qQ/au1otyul6rQx8zWvm0PVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GTrbUyPoBlpW3pWEwmW4Aj9QVgPTwMsL3ile4fBelM=;
 b=cj7G+Lrea/qGk5RYJH24jbOfLkJVVy2eeZjWUOFhEiz5WWPaRnGzdYGv2mQSS4rBk1PldW6qOiu6iplYFgEhWEe4mm9jz/RNEUKqrRuD2kZUTuqCGR48fg4OflW4lNnxY//J2huM+D8cMYlKh/bYlDy1QmcRU28xT/6X06IVeOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from SA1PR13MB6648.namprd13.prod.outlook.com (2603:10b6:806:3e7::10)
 by LV3PR13MB6527.namprd13.prod.outlook.com (2603:10b6:408:1a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 13:39:36 +0000
Received: from SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4]) by SA1PR13MB6648.namprd13.prod.outlook.com
 ([fe80::c48a:c42a:aa18:2ef4%3]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 13:39:36 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 6/7] NFSD: Add filehandle crypto functions and helpers
Date: Mon, 29 Dec 2025 08:39:32 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <1C32912B-C265-4D1E-895B-88E38603E956@hammerspace.com>
In-Reply-To: <20251228204514.GC2431@quark>
References: <cover.1766848778.git.bcodding@hammerspace.com>
 <0688787cf4764d5add06c8ef1fecc9ea549573d7.1766848778.git.bcodding@hammerspace.com>
 <bc74d1a3-d128-486e-939a-f7b3dc560931@app.fastmail.com>
 <20251228204514.GC2431@quark>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH0PR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:510:f::6) To SA1PR13MB6648.namprd13.prod.outlook.com
 (2603:10b6:806:3e7::10)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR13MB6648:EE_|LV3PR13MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 428ddd2b-9b16-468a-d3de-08de46dfb4fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nm6+Syoep0wVegp2VA5vRRdxt2VtUeekaePQfrbsPLpJxvTkfbASTcZWGNay?=
 =?us-ascii?Q?+V/OFjBY7TMz5hD6tt62sbXBhmxIT6+igYvoAROs1st1ZLOM013wvBEKM09E?=
 =?us-ascii?Q?SWzpJF00WEx6rd5+HHE3B+fpXycP54YyHExTNl6nTID9j2G8zYxcZ4WEQuei?=
 =?us-ascii?Q?iyTbPHVP0BSDv100mwOJ8DSrq5ICdHfvSsDfG09IyEfdTqdFW2vBAoo4d1Ot?=
 =?us-ascii?Q?iKq1rZPGNoltRNoY4ZZKdz2Tb1qvRBk2RamxIidY+J8pdVdrUnUemeyUU2Yp?=
 =?us-ascii?Q?T7XTZUfzPIO/OvzhDhvADH5pCJ4FFCCUKkZTaQjnzJFsjeswG9/nhBzYDoC0?=
 =?us-ascii?Q?wG0qsZ3cGShojDJA9KQldLyY1szez6V6r3dayNOkaV0QNcl6SwrxNuVTXJdJ?=
 =?us-ascii?Q?PI0Xwr4sJG7TSJ5FIpwjl2gFJWSMjMgTdPQlofPoT+xYFkneCBosJ9ifJz13?=
 =?us-ascii?Q?/EVzRRsbE0H/daQs6PQStCjJWPRIXqNY0cX9We1Nw+XaZCnOxiJSU1FDIA9z?=
 =?us-ascii?Q?PJJAJzUE6QIaQZhwjHn2mUhKkSbw21qJm9hvNypsPCqhxPKmclzLnGGZXYOR?=
 =?us-ascii?Q?iYZKPyoascv3sIst9u0M6FmKXlbZv+RUVf9xgmynp+t287lPbNBdRFo4H/8F?=
 =?us-ascii?Q?20P5emuAhyiTXg4OVdhtE7MYKhpO6voIHlPABgoswaJ2vGw0py7a6iEiw3U2?=
 =?us-ascii?Q?9n6zq74qoMnbH1OArVTiThx+C0SBmBfkrImPKNZTOMVJWX7YnuKeylklcyOD?=
 =?us-ascii?Q?PGkIy8oSATKLfMmD0ikU4oCzyIfkzZStHM7allspAm104dzyfW4orAvMTlbU?=
 =?us-ascii?Q?Rxpjx8zwxgDKUlNPgbzEou7wPY8tHPJGJD4vsGpc5JNg1sAlTNdiYx41s1OL?=
 =?us-ascii?Q?37/RhdzJwAvOULXMZnteZHW6B3aGRxsp1CXpbF2WPLAEF4zUmkayqxXcbtiz?=
 =?us-ascii?Q?z1fXkPwKbQDpU3F/0QezulQa1Sfe4VAbnjlCvvWjs0xAyGYZkg8CSzggQYfV?=
 =?us-ascii?Q?bzYT/RL+UJGcUKCBxSB2/BqnXfIsruDiMeZH6IWQz4GR70kaLeRWimUpt84b?=
 =?us-ascii?Q?GAORp5FiE2HuTuhr1LIkJMddD4HSnc3RJ7V/TLNtA+vE7lbBtnBc07XjLN81?=
 =?us-ascii?Q?V5bziC7YvVXZxWvmFNkV5gquSsqLCAg36jp98QSjrVGI4wVDOq87/4JphHrE?=
 =?us-ascii?Q?O5jDZNfwWIKMu5Ha23M1lCwOxJ27KXNR0W081456t0qHLxfGP1kxAM7zwYld?=
 =?us-ascii?Q?BGeWywK/xJmibWz6n+Kk7XspibwtcP5brRzv/ce4AR7W25OE0AoSfGesd+YG?=
 =?us-ascii?Q?0JfpjI+/odReykm6QVhJ87fx9gdiM7a12GFKvWI5dyjSNaNPwHGRpKBdogPQ?=
 =?us-ascii?Q?Y6Kn0rfoYnQFe2wHdXcAh05pUlvQgzFc0AVnidzyGYqdpPvilBT9GKU3/L6L?=
 =?us-ascii?Q?itG2tvW87uPwxKBfOTNLaFuaiGOQnpGSo3EqciQFIbTdjKtFcuUPwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR13MB6648.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WkVMedoEmxM2ggjrsRky3qCsJQCg5uflcLq3l6IH/sDhNFEF8FfbBqw0KY+x?=
 =?us-ascii?Q?PDja4F4GQpvE6G+Xvcxem51B2ksD01+6jRIXLTvxnReJeq3ln0iHE6pW4Jgh?=
 =?us-ascii?Q?FuBdpp6dT8xUZELO45q5kDa8i1oSHlitYAbGJ6LqRAxRSYutteoQraWqgZ9C?=
 =?us-ascii?Q?DuPYC9e5Tr/rJzb6F1YTB4X16Yb8HHA/nRPxO5yPUSJajjY3AZTZAKGC5LBe?=
 =?us-ascii?Q?NmiTYoRr1RFITlKFCD0w36xJXG73IMt7MXPbKIeNndVGLTDnAbPR1QuctI6D?=
 =?us-ascii?Q?flSMXyCyKSI3OJ1P6WcP1yKCcqFvfw/KbZd7D7h0q/UEPQ+Lv3qWqXWGltpk?=
 =?us-ascii?Q?jnYdKXM6cFfZONTb8Cb1ZR00NUhqEWvGtn2CTI80rtQDTl8Ngbn2eYH5OEX4?=
 =?us-ascii?Q?VMCX+wN09DskeBz+nb+0icuxJ/x/CpwWJbS46wjN9eOkCEdfedm03GE/4yg+?=
 =?us-ascii?Q?hmAe0/MgdNblXvJH0YrtuVR3XYIZMs9G7kHjjW3AUNyOjXmBAnmIR1YR8Oz+?=
 =?us-ascii?Q?hdafIIik2ctZuM+h5vDUZSK9rddKx2f9juvmokRUeC3ClNdmqTjwTYfJR4rt?=
 =?us-ascii?Q?l6D+Ika3L/vd+6YQ55qDXiQ9rhl0pOI7lNhM4i4nUGKHX/xDwooofMWjI6gB?=
 =?us-ascii?Q?52ID47DGX7udZU2qleziyMAo3sqTr3darBoWhgYRSstQU7Y/0zNzJmtlIeu/?=
 =?us-ascii?Q?O7C3p24szCuAcbvq1KxAV8VyMzHI5sJejfAto2l8rS6knlTvzUtFlnuW3r4s?=
 =?us-ascii?Q?P8hHdJ8wbSrGNyK78ZJ4pM48OG9cSzVW4017Pfsv4oBXJFFvTCPK42tRVp8L?=
 =?us-ascii?Q?9QcvDkZHXzAQdF3gCV/tunUPT1OI9/xt20rZIzubH/QHGplx4ScVeJaxttlP?=
 =?us-ascii?Q?hEQeq4uewnoHUnrJKkGq6hqzHaAVmYvKaQGnx3aoiYfgC+NgTrFBgmF5+XlG?=
 =?us-ascii?Q?zfw3+uCEKDkIM4eO1PsYDUo+HkM0lA2SWT72jq5b476k2I3g1ns4dpNuLH82?=
 =?us-ascii?Q?+MT5mbljWpZbvNL6mvo8MM/oFxjT3+BXJbkzmX02TL7R+4VFm1TznyLPSrgp?=
 =?us-ascii?Q?75pwBI/OPzJh3mydeeW2KiAlZtXTdBsrHPdewcDvuxvJAuGrq9I0Bf/0gCWz?=
 =?us-ascii?Q?xW2hqn46LAFDQlgvYDkO2wUz3RNJpbsPfWBLP64+fH/eFZQAZDEG9KMCXkLQ?=
 =?us-ascii?Q?w8isDEvHSB3dpzmao5ebLRLdNI72uayci5CMEIMGwWOO2uSWMkzxBgedU087?=
 =?us-ascii?Q?/M4/zhUiOjs8igf/+WWWeLupI8FKP9AlihlJJiSG5s57j4SfH17i5Rn5YsYz?=
 =?us-ascii?Q?xcjnRBnsCoLHeEtyXM/8/QwrOh/EEitmbWRGy47tjsn4mX4hYFw8b9YOF3V1?=
 =?us-ascii?Q?cGARiknWjVUjAnagmo54LUYBYrG2j8zsOaLZR9sdomtX090FTmBkCZIXSAMa?=
 =?us-ascii?Q?jhyFrHo9HGea17+qAlHv1QQ+79u3dH4jN7EU6BcNn8Hap9U/K4P8bKRCSsMl?=
 =?us-ascii?Q?C2JXnVI2IDni7FwlglzlXyOZ4d982UJv3vSfy/WQSz5067C4lXbttLkcLCet?=
 =?us-ascii?Q?ykWqXFVkwnrdUSY3pn2RVl2TiB4KkrgnEc7eb7BzaZKc22IgDYvWJ53TpobE?=
 =?us-ascii?Q?XnFH8yrYEhLs9PzzBT8kZh/pRjXe6OgiuYmj/uWPdCr6in5pl2kUIqt4Qj6C?=
 =?us-ascii?Q?kwpjeHw2xSnGSY+naW0bcGp6jzvgDvBWdmhiiMJ74e+Nol/8T9t9JPVkBVR1?=
 =?us-ascii?Q?172Z9ZoXgnlGQxCQnHVNa1GOW1r16YY=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428ddd2b-9b16-468a-d3de-08de46dfb4fc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR13MB6648.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 13:39:36.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uea9bH2kv2poszK3SBgPlWJ4OxMwZashYDmSw6CTfFOWSnixdBmiVBb6D3WwpTyOxZoS/kvaUASJ3/BS72Ex0mmQa+HmUh9/r5w191je47M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR13MB6527

On 28 Dec 2025, at 15:45, Eric Biggers wrote:

> On Sat, Dec 27, 2025 at 08:34:18PM -0500, Chuck Lever wrote:
>> I'd feel more comfortable if the crypto community had a look
>> to ensure that we're utilizing the APIs in the most efficient
>> way possible. Adding linux-crypto ...
>
> Many crypto algorithms (especially hash algorithms and MACs) have
> library APIs now.  They're much easier to use than the traditional APIs=
=2E
>
> But it's too soon to be discussing which API to use.  Looking at the
> whole series in lore, there doesn't seem to be any explanation of what
> problem this series is trying to solve and how cryptography is being
> used to solve that problem.

Hi Eric, thanks for the look.  Agree I could have done a better job
explaining the problem.

I've done a bit more explaining here:
https://lore.kernel.org/linux-nfs/706F9EDB-D98E-41D9-92DD-5172A34A278F@ha=
mmerspace.com/

=2E. summarized:

    I am targeting a very specific problem, but I've been a little too ge=
neral
    in my cover letter explaining how this work benefits everyone.  That'=
s my
    mistake - you guys are too sharp to let it go by.  :)

    In a flexfiles setup with a knfsd v3 DS, the MDS can give filehandles=
 to a
    client in its ff_data_server4 that the client can't normally discover=
 on its
    own because it cannot walk the tree to those files.  The tree will ha=
ve a
    directory with search-only perms: rwx--x--x and root ownership, and r=
oot is
    squashed for that client.  Files that are linked below this directory=
 can't
    be looked up by the client while the MDS (by not having root squashed=
) can
    look them up and selectively give out filehandles for them.

    In this setup, the MDS can have control over which clients access whi=
ch
    files on the DS.

    Exposing information about the fsid and fileid within the filehandles=

    themselves and then allowing clients to construct their own acceptabl=
e
    filehandles circumvents this arrangement.


> The choice of AES-CBC encryption is unusual.  It's unlikely to be an
> appropriate choice for the problem.

Good to know - I'll do my best to help you make a better recommendation. =
 In
a different thread responding to Chuck Lever:
https://lore.kernel.org/linux-nfs/2DB9B1FF-B740-48E4-9528-630D10E21613@ha=
mmerspace.com/
=2E. I wrote:

    > Can you elaborate on why you selected AES-CBC? An enumeration of th=
e
    > cryptography requirements would be great to see, either in the cove=
r
    > letter or as a new file under Documentation/fs/nfs/ .

    I chose AES because many CPUs have native instructions for them and I=
 wanted
    to minimize the performance impact.  I chose CBC because I know that =
most
    filehandles will fit into just a couple 16-byte blocks, and I can use=
 the
    standard way that filehandles are composed to arrange to have the mos=
t
    entropy for a given complete filehandle.  By having each block depend=
 on the
    hash output of the previous block, a complete filehandle can be have =
a
    unique hashed result by starting with the fileid.  The actual impleme=
ntation
    is a little more nuanced, but that was my original thinking when I ch=
ose the
    CBC method.

> I suspect you're really looking to protect the authenticity of the file=

> handles, not their confidentiality; i.e., you'd like to prevent clients=

> from constructing their own file handles.  In that case you'd probably
> need a MAC, such as SipHash or HMAC-SHA256.  This would be similar to
> the kernel's existing implementations of TCP SYN and SCTP cookies: the
> system sends out cookies that encode some information, and it uses a MA=
C
> to verify that any received cookie is a previously sent one.
>
> But that's just what I suspect.  I can't know for sure since this serie=
s
> doesn't provide any context about what it's trying to achieve.

In another excerpt from that first thread linked above, I responded to
Neil's inquiry about why not MAC:

    >> Normally encryption is for privacy and a MAC (message authenticati=
on
    >> code) is used for integrity.  Why are you not simply adding a MAC?=


    Good question - I'll have to think more about why a MAC wouldn't do t=
he job.
    So far, I've been thinking about this as I want to give clients an ab=
solute
    minimum amount of information about the filesystem on the DS.  Less i=
s more
    here - but I can see how a MAC could do the same job and possibly be =
less
    work for the server.

So (trying not to be too wordy), I wonder if that's still too vague.

Thanks for your response here, and sorry for the chopped up reply.  If th=
is
doesn't make sense, I'll try again without the reference noise.

Ben

