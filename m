Return-Path: <linux-nfs+bounces-4495-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB4E91E2DF
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 16:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9AE1F21FEA
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 14:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C861411DF;
	Mon,  1 Jul 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="khXfpjaP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xrU5xzZk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8016C698
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845715; cv=fail; b=HCZDuxHEWj4zBjnL4INqvSBkBloLLCAS4iSEt8kEBdLoqGE/DpbMSgI9B+wXUnjm5U+fj1b3deLyo0K2cTKlOPLjILdZS50fuzF+vFcUhrYxbw2clt4gFbSE9PVzGepa7M9RPb96ocpxfqYtJDlpVQE80mhUSOPC9vUQYWKH0dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845715; c=relaxed/simple;
	bh=Oa24Q9XJKeLwYkSAf9u9PRyaHAu8Gu3rfcySCU5ZSLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k+R7xGlk7Qt+LNnztpKVytARt9qy3ONs562rZiQEBpArR//bEU91LwG5LQDvgIVB6abTk+/abbM9Z0qqYsCRH+N94OZUhMmpPkp2xgD55HRMPUwRMjdxhPsVO2eyyxnpMQL7ZaNjusJ+SYKYzzFadVuFR6LFxO6yDuoPc9vWv+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=khXfpjaP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xrU5xzZk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461EsscD019239;
	Mon, 1 Jul 2024 14:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=+ByAMGAjqNAGlUI
	gcySbjZxcxbeR4uXtJqal7rQvTP8=; b=khXfpjaPnQmbSWJDVM9DFGKk/xCh0af
	e/cNLnqyZwY1HnbM3SPFdhnYjkASJFDqN4ZI0fjdU8E1DQ/CX3NpUtCw+CLottyP
	9fznnbIds7Z/GhypdYciXANol5wYysJmFywHUZCLIos3vAOc+80+21zF3M7Ewj8h
	S4d9T0KZqZwVLdpbXKstCQvKKZaicGP/P0IzGK6PeDfpMpX+7NDWD9iMjYUY9QLi
	4fSFI3bzXqyiVXzme1cKFpYELwtSRErT/n1O3T6mUt9yBoPSYZ8Va/V/NMt3Zh80
	fVDhyvgL+q7O+ZK/zNgZR2/l4RYLrqcKQ6daN/kH1Pe6ffc2CF0PpRw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402922u23b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 14:55:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 461DsNYe033252;
	Mon, 1 Jul 2024 14:54:56 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q6rfnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 14:54:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP39S1u6cIJvuX9M1/jMK1THSbCkep0/tEt4eDeUXzLXvx5QxNuojtO1QH9R7B/SWtoaXaN0PBMxEwkN4Zxk/ELH+Jl+7UiE7V0rc9NYJJ7a/Tj50qIV/No7G3ajXVok8xbn21ivUfLtfCd1C50CwhMeHB7CLcCX8B+QLwXRpEn/KjgTFSSc3+laoVaMjHxxVBnoH4hah7OXbEwP33dOIppM48ZNrdRKxTe21gXrK2YJqycY5p9xhBXrY0ae7dBTxHeBwZZa2bwS0ImVy7YlXdzSddT9JmO/1E7V1IVTcPztI8FZ3KCafYzUU7zN/fLbdWl/szz4mdFf1D0+UK6bjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ByAMGAjqNAGlUIgcySbjZxcxbeR4uXtJqal7rQvTP8=;
 b=E+71zVEkLoJDfpj6K+fcZ1JOcnIK+Bl7AmLDzC5pb52fSaVuA2/edlLeilsHPOAGjeXjOIcPPQWpJneSOwy1XPfYpVII+URkWH4BNB1FHz3GDhb/Xh13TxucpH4DxSVDzGEz9qVskQ1UhKHeiz968DYJZaB8idpaVDvzZYSRAslatnn2zyMVgdundIRM2sxDQ6nwBQDtJeqUCSp66xDH60Nmo6+GA0Eqk3L7LKN39UH4ZUdoVDW+HuLUDXMNltrS8ueg4tH6li4WpgEbcCH72w0A+yUTim2aJTZPPw3ab8hg+Dapo7VSvnP0nMAyOmXAf8ZUgSRHb/lr1QGFYvTrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ByAMGAjqNAGlUIgcySbjZxcxbeR4uXtJqal7rQvTP8=;
 b=xrU5xzZkqx29BpQAV1Uuhkk57Kcj2up1q2vqQm3tM8kGBOJpW/uEgn4jhNkrM7IBsEmO3XkYIXdpeHlYUT2Xls/lTJvNUii3y6fSf6dKEM03Ft/bGMU7KOqIFtvifFdXzKtarhUXRMDX4PbhjB6pKrxgjEnCyhaUv1HYc+RsNzE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 1 Jul
 2024 14:54:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 14:54:52 +0000
Date: Mon, 1 Jul 2024 10:54:49 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH 1/6] nfsd: introduce __fh_verify which takes explicit
 nfsd_net arg
Message-ID: <ZoLDOciP8/ChGcba@tissot.1015granger.net>
References: <20240701025802.22985-1-neilb@suse.de>
 <20240701025802.22985-2-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701025802.22985-2-neilb@suse.de>
X-ClientProxiedBy: CH0P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f184436-ec81-497c-69da-08dc99ddc368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?V75Rs13jR/ytrWwJWhZIx/DYdHTdn6sFujbWKfn9M+QiOCbRNMnY6VppvGIk?=
 =?us-ascii?Q?63OGhD9z58KmQ0NLQb0pe9HLeoguSScYzeidBd1Q4rW6KB0a4oJiOnZA+VwW?=
 =?us-ascii?Q?LoqXJNsfH04sfAsnUp3DCkqjXnuJJbP7X2dBQsWAELJHI6HIRNvSb3aaMH2/?=
 =?us-ascii?Q?cdRAgk/jdbwJueN62paFcixW9dQMWzD2buQwaiJGhVkb/hoVGB+pxWRpkeUK?=
 =?us-ascii?Q?6c55WolODHz33B+XypKr0sLXQWEGiBrC9w8KIKu17Xa2RxqyfVqTo+sQj26h?=
 =?us-ascii?Q?noIL2J60w2pPy2UI151GeWNzP66N267OYcHq1szQ2lL4n0qFOydAib2946tF?=
 =?us-ascii?Q?kaPWCkugPaNRgfVixkMMvZOr3wDO7Xd/BPIOmzOLKDfiycphwKIO2Hmt+HB8?=
 =?us-ascii?Q?8DRWBrZgb0z0UrPSwdHKy6oY2oQIBn/wNMAL6FYyut4nhvUBCntOMYjSgqWB?=
 =?us-ascii?Q?kUydK+oi4lnQQ40lMgbmPGwj4D9AkB0izo1mM09MIOkx/1vztzxomkMLBvTQ?=
 =?us-ascii?Q?mpUWo8GpCNwZu5mxyOx6tL1sCY+ytBLgLG9UZcvYgfZgw2z9jOLJwiYY5Tav?=
 =?us-ascii?Q?4OLtIJO+ndUcd9FDlaYLIQhMFGlXi7AMsudspqZ6RY2kFfWGTVgGe0QOFeMu?=
 =?us-ascii?Q?r1M0ogyS4oZgMkiA/5/80twruMGlGi2RHqDkrEWaOdsyQogS5lREUKkYsBXt?=
 =?us-ascii?Q?zxVHHjV4vWN8ePIqmLOhXmdDr+Usx+7DKXLU7PWAN6N6rV2o43fxmicm7u45?=
 =?us-ascii?Q?0R9DXG0g2vmZfzq0ykwoZrZBXDRuU4TPYSEMgkVCvRzBNn/BJ0A9j+3J3ryt?=
 =?us-ascii?Q?8rGCy/ZYmUoDlLEE0YS0le+iV4Wr7FoLXiC9AQ+v4XVDKVrs3+Q/GYG8dqFQ?=
 =?us-ascii?Q?Ssu9iwTw3KrwXtp90guHKmFS0Da6xBrQf94Z24m1lmMxU8ewVVrhAHOtYkEO?=
 =?us-ascii?Q?LhNJSM1hKs+NbDE3+VI7KQjbKBMeVMl815IbOCHtqC+vTHU8X2URQvWC39rT?=
 =?us-ascii?Q?MQXAK9jsMYw/hMkWBj68KWvgl7FjNYrP2VBR0OpH1RcyLBYPSMJZC1dBnjXj?=
 =?us-ascii?Q?YHOQ3O5ZBKNNS4e2cvBRiNFUgUpWOaZVwPxUqTX4acJQdwzTw3CYcwrkljVO?=
 =?us-ascii?Q?vLZVF1GiXVjyzEBAU/frBOkC664nYqNHhyKA9TB+KkVUfYYC9bdK+WcU/U7W?=
 =?us-ascii?Q?TC/dS+K7EVc2ih4lQ7GUozvwH12vpeUVMhHKZBHQYK6o6aBvH9Lg8HZQSmH2?=
 =?us-ascii?Q?hTyB65/iv0zNA4iXv0xY0y2RHqGUo0F7Hm4nmYudBqluODwekTjKzwRAzeIT?=
 =?us-ascii?Q?kwDxiLy6D7OlQoyqswsgxe7GGHKoIBL2k3wJ5aACOyMrzQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dLkM6H3RD50DF6L5wM1CFTvtPO6w7c7Pi9/KW3lyace3Rxu20VWLT8vv8Q2J?=
 =?us-ascii?Q?x2qRMCEVALFjOUsoZU4JLeYJYEuHmAGIzLZOeEU2Lkfo3YIys3NLzAsvqdxT?=
 =?us-ascii?Q?OUBf+Xrg4ASEC4hyCzbnQ+2bYkMn1qEyheTNBG5STxkGdrXuzobHQk94TiL5?=
 =?us-ascii?Q?4+LMnJNWtUSV8H2iPb/+Dmdu3jVWoU1bO3g/q4Dw/CcMgFGkOIwUxW0G/oLt?=
 =?us-ascii?Q?Mpl6XZgXmyuLgNQelP3yVeo7EoZriG/EC+HnkrNpxke80JEKyDYBdypykW4s?=
 =?us-ascii?Q?awdQNQ2MMLlbdB83fqCoc/G38KH0G6ktOs8WXCfWeT7b17DWYoiSrqTqBs51?=
 =?us-ascii?Q?nyA51H7cA7ziVILAPoQOdz0vRvnrWmAEmIvDQTOONZkiOBE2l/PRNaDAJUCT?=
 =?us-ascii?Q?iJgNnD2G6NyybuMd93CY/mGChcZY4lEGs+inoEz4QiYkVCYtO9k+/CS6/B/5?=
 =?us-ascii?Q?C6zKn8L8VQm+12QcwT0EB56kczyk3VWkUeWsQtXGEn0cz42wOTBTHQE5T3vE?=
 =?us-ascii?Q?1GL1soMz0awg/8xogbPr/8jCF3bLlqeLqK0V+RTw2Mh8QfVBfxgkAgW7RcYH?=
 =?us-ascii?Q?grqT1bxyCRK+GdluB6Xxydn/z9+ghde0zjtpJLj3674rBA6YsVKfpQVriyjE?=
 =?us-ascii?Q?x/r3hREa55Ts5yJjvJRDD4WbcPLQ4zN3DFDYYQgiBssQn9mjrxRKNdHTyIqp?=
 =?us-ascii?Q?ewFRUpO1VWoi2DltSeveY0a+kC7vIpHdXdDTBtOgpC2o4HnBpzvv3EwQQ4t/?=
 =?us-ascii?Q?DMzWR5p05arIbtU+McTGvPYJYGcErC4gsWBnyd8/KQkhhxfSfBYeMCP5ckMv?=
 =?us-ascii?Q?MNwc4VyZ3xr14UbuTTNrMswwZxHHfPnTCj4jw62Mik2pUC/20+0UiqwpU4OG?=
 =?us-ascii?Q?fpkuwXTJpqjVMYG/y41rt4DMUr71xQgh+PSvNjC6yvKDhWqlyLW2IqA3tVqo?=
 =?us-ascii?Q?ayqIe3FCvQahNGytWR6Fexf0eOLtMhBgO8aaIPLwsMdFQghLFkDQOMAdVPL9?=
 =?us-ascii?Q?sbVwrPJ+wgulpqePdhhbDDc//14X65Nqx7KQ0+9FvtufcZUf3a2xFdoQ4ye2?=
 =?us-ascii?Q?wXAbmCHMWDSPtIW81kmJL4eBUNNW8ZakVWnrQRShT0UcjHe0piPR4Jg3qO0E?=
 =?us-ascii?Q?ubxJDDuYI5VgTWiY0MIGQZaX4i3Z5+zmsZMZEwo3vBSACfSCLXWEICwrnBd0?=
 =?us-ascii?Q?JYlciTr3GQqMJGirBxrXywxV6FDkn/jw0B59oeLcvmmRK1wuNubSXxORyFrc?=
 =?us-ascii?Q?aI0PMn+uqT7cqtCFzkinuxMXd67YA7Xg5FDqTaHV+xCu/uIj2MbvrhuJHYQ/?=
 =?us-ascii?Q?mZXN5dzpxKuzjw/YyakuLu4/xuCcTS8mR3qsdq+PLU/ngYI3v0bFpFmkwxm5?=
 =?us-ascii?Q?Jc1BPyUEky+W9gH05GEZLG0MmJTXYCzCc7rU3FX1AZAx2o5j/9gBhKVD6kmC?=
 =?us-ascii?Q?iBObtkC0ymKc9m4VetUePF4fUj5Au5w+/u2sptlMNrMzqI9oKAkw1uTZRGSW?=
 =?us-ascii?Q?Dx/6RF8UNxVfyyiPH91ruU6CDzjY1okBAu/CultrJP+PhtQobk+9CRTbbxiM?=
 =?us-ascii?Q?15gjboNd2l2DAo4y0mNBLkMM39B5tBUXzAn9MxbQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OXflOIzjpQd4kETCvofHT84v6fGyxtNzAT/cn5WP0NV/ZdfhDFvs1orI7TdEUdzr8Gt1kM8Axy8znR16VCPsRAJ4BV7oIZbkY9q3OzTPy13zw2s6eSSLjeaPjQ+romAm08iX7tIO0zo5NxQquATVKkPJ6NKu1nFvoIvu1zwp+Z6b5HYW07Ixv5fTWamkaTOdXQV/z4aMrNx+VT3XqHBwiJXD8yjP/3u3bjed0GtKgTIaJexz3iJafRBZt/RtoTlmq26+b/xiVc3R30DXC6K10S/OsI/c7W940BsfD1LqMGboMZMyI9xsP/k9qPnqVPfdGNJyzxRIOSrfr9/njlXdxte5ce4uRdN8HgLx5a5o/ad+3T2lmu8y/f8VI/jMxH67RKfe7r4ZaMQ59h3M3R5GL6/ca7tWwB42shJv+tM9DhXEuWVbmwQ6+1jvEkyEiwpkeTBUW3DOnch4HebZOl0/xyxktRZPQm2IxJnAly8w7f0n2bkIMbnL4fDyiBEkq2O63UyB7kQ2b4oeDootfT+ZTHibSwO/INAgaT745U8XFUQ1Zhoz4B0JEMyf3ZXQZym+6V/VM+B9iYhEN/C230vFgLI7bwS/mdyyH7qrx1BfhuY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f184436-ec81-497c-69da-08dc99ddc368
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 14:54:52.9254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47F4A5JGJGrkA3LMr0LM6h2yW/r7Q/9NmQjYJQt/NCPyq6EydmdYX5vnSbCqiH3aRqqVRuLy4fIm2vzZIC+N7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=366
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407010115
X-Proofpoint-GUID: 43DZaHgzRfM1RxwzSIJDfGy3QLNN6FLl
X-Proofpoint-ORIG-GUID: 43DZaHgzRfM1RxwzSIJDfGy3QLNN6FLl

On Mon, Jul 01, 2024 at 12:53:16PM +1000, NeilBrown wrote:
> This is a step towards having an interface like fh_verify() which
> doesn't require a struct svc_rqst *, but instead takes the specific
> parts of that which are actually needed.
> 
> This first step allows the 'struct nfsd_net *' to be passed in
> separately.  __fh_verify() does not use SVC_NET(), nor does its
> callers.

It might be a little cleaner to first update rqst_exp_find() as a
zeroeth step, but no big deal.


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/export.c   | 12 ++++++++----
>  fs/nfsd/export.h   |  4 +++-
>  fs/nfsd/nfs4proc.c |  2 +-
>  fs/nfsd/nfsfh.c    | 20 ++++++++++++++------
>  4 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 50b3135d07ac..a35f06b610d0 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1165,11 +1165,15 @@ rqst_exp_get_by_name(struct svc_rqst *rqstp, struct path *path)
>  }
>  
>  struct svc_export *
> -rqst_exp_find(struct svc_rqst *rqstp, int fsid_type, u32 *fsidv)
> +rqst_exp_find(struct svc_rqst *rqstp,  struct nfsd_net *nn,

Extra blank after "*rqstp,"

I agree with Jeff, the new modern rqst_exp_find() deserves a kdoc
comment.


> +	      int fsid_type, u32 *fsidv)
>  {
>  	struct svc_export *gssexp, *exp = ERR_PTR(-ENOENT);
> -	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> -	struct cache_detail *cd = nn->svc_export_cache;
> +	struct cache_detail *cd;
> +
> +	if (!nn)
> +		nn = net_generic(SVC_NET(rqstp), nfsd_net_id);

If it's this easy to fabricate a network namespace, IMO the API
would be more straightforward if all callers passed a valid @nn.

In fact, by the end of the series, the combinations of which
parameters are allowed to be NULL and what each NULL means is a bit
brittle... Perhaps you can make that simpler in the next version of
this series?


> +	cd = nn->svc_export_cache;
>  
>  	if (rqstp->rq_client == NULL)
>  		goto gss;
> @@ -1220,7 +1224,7 @@ struct svc_export *rqst_find_fsidzero_export(struct svc_rqst *rqstp)
>  
>  	mk_fsid(FSID_NUM, fsidv, 0, 0, 0, NULL);
>  
> -	return rqst_exp_find(rqstp, FSID_NUM, fsidv);
> +	return rqst_exp_find(rqstp, NULL, FSID_NUM, fsidv);

Right, so here, I don't think there's a problem manufacturing a
proper nn to pass to rqstp_exp_find().


>  }
>  
>  /*
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index ca9dc230ae3d..1a54d388d58d 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -127,6 +127,8 @@ static inline struct svc_export *exp_get(struct svc_export *exp)
>  	cache_get(&exp->h);
>  	return exp;
>  }
> -struct svc_export * rqst_exp_find(struct svc_rqst *, int, u32 *);
> +struct nfsd_net;
> +struct svc_export * rqst_exp_find(struct svc_rqst *, struct nfsd_net *,
> +				  int, u32 *);
>  
>  #endif /* NFSD_EXPORT_H */
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2e39cf2e502a..30335cdf9e6c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2231,7 +2231,7 @@ nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
>  		return nfserr_noent;
>  	}
>  
> -	exp = rqst_exp_find(rqstp, map->fsid_type, map->fsid);
> +	exp = rqst_exp_find(rqstp, NULL, map->fsid_type, map->fsid);

Ditto.


>  	if (IS_ERR(exp)) {
>  		dprintk("%s: could not find device id\n", __func__);
>  		return nfserr_noent;
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 0b75305fb5f5..e27ed27054ab 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -151,7 +151,8 @@ static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
>   * dentry.  On success, the results are used to set fh_export and
>   * fh_dentry.
>   */
> -static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
> +static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfsd_net *nn,
> +				 struct svc_fh *fhp)
>  {
>  	struct knfsd_fh	*fh = &fhp->fh_handle;
>  	struct fid *fid = NULL;
> @@ -195,7 +196,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  	data_left -= len;
>  	if (data_left < 0)
>  		return error;
> -	exp = rqst_exp_find(rqstp, fh->fh_fsid_type, fh->fh_fsid);
> +	exp = rqst_exp_find(rqstp, nn, fh->fh_fsid_type, fh->fh_fsid);
>  	fid = (struct fid *)(fh->fh_fsid + len);
>  
>  	error = nfserr_stale;
> @@ -324,16 +325,16 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>   * @access is formed from the NFSD_MAY_* constants defined in
>   * fs/nfsd/vfs.h.
>   */
> -__be32
> -fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> +static __be32
> +__fh_verify(struct svc_rqst *rqstp, struct nfsd_net *nn,
> +	    struct svc_fh *fhp, umode_t type, int access)
>  {
> -	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>  	struct svc_export *exp = NULL;
>  	struct dentry	*dentry;
>  	__be32		error;
>  
>  	if (!fhp->fh_dentry) {
> -		error = nfsd_set_fh_dentry(rqstp, fhp);
> +		error = nfsd_set_fh_dentry(rqstp, nn, fhp);
>  		if (error)
>  			goto out;
>  	}
> @@ -400,6 +401,13 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
>  	return error;
>  }

Can this patch copy the kdoc comment from above? And of course the
kdoc comment for __fh_verify() will need to be updated
appropriately.


> +__be32
> +fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> +{
> +	return __fh_verify(rqstp, net_generic(SVC_NET(rqstp), nfsd_net_id),
> +			   fhp, type, access);
> +}
> +

Extra blank line added.


>  /*
>   * Compose a file handle for an NFS reply.
> -- 
> 2.44.0
> 

-- 
Chuck Lever

