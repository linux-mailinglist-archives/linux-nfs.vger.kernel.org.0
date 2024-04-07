Return-Path: <linux-nfs+bounces-2699-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8371389B249
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Apr 2024 15:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC1BB20DD1
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Apr 2024 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150CF381D1;
	Sun,  7 Apr 2024 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="FWQKdn97"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2126.outbound.protection.outlook.com [40.107.223.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BE83771E
	for <linux-nfs@vger.kernel.org>; Sun,  7 Apr 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712496337; cv=fail; b=Se6hhuDAmO/AeNwZVw8ACgZseXrZfOLys/AOEaAz+VCemH7BBTH/ELDpe+YcplFRB3cTcWTa1N7NA+L/RmxQI3SFWDeBVAn4wVdkk3k7Z6ENLiZamtabVhXFJfRlJQYVVVRWIMkuVnJMN7AgIURBdP4iTc3/yGO3pPIMNNXAu+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712496337; c=relaxed/simple;
	bh=GomWBosHBvC3VHH4ytKCuFQ2nW1TOWAVI2pULfniXEQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OrACc5QduPWsKyzXKmY5lcn3l11lx2oeTDuH/g2CtgjkEwj9OpR1o7pXa0gy267vpA5bG/WA8PHKxbLX2zCV7rDApsUufCjUCJNu0Jf6+SkRJBPZMLvGKqu/IR9FA+V+Vyu/PDsPcXmw2Qs3XVSySxPOcRnXOSPJSxUCVAIQaL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=FWQKdn97; arc=fail smtp.client-ip=40.107.223.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLcmOE5ZkzyFGmAPM1wFHUJFgMj/yTmUtcwXKYSr6bntn/ywt0uV4YlIC4T73ICPr+F+ShP/HFMaLfcdATVKV2wXRm07l7gTbUNC5w6995wzi7BIh+ukGqHlorVO4QquSEbOaeyZw2t0Yk/hlX6WvCbTW4QL+A2EdCIQOI3isgD/r2707pObOo+qE4jGtgedlRqktLsgKZn3FjMoHr3JFcSGxvCjHx9wQnae30P2dujZTqpCNywQ7vRLGENJiaYw59aEfptllsLh9ZGZ7L470kJx6eSYxQB1Uuuwz+JJR2JQyPYibNwgpI5OohuoApbm6BJYfB5IO+P9Ma45v6uICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GomWBosHBvC3VHH4ytKCuFQ2nW1TOWAVI2pULfniXEQ=;
 b=PPkTAKgRomV/Ck14prNrGrjiC1tUAHaLbOs6Sa9YRxulUdu2sM+/iAvnVkLbmwiw6fnmpGPjeAGnnzSwRIhvZsZKsbPn1QWuNNmbXZj6jK2w0GkCQ1hn3TTTMybD+kzKHf4qjcoEJ3sorDFjw29XR+RMn8qHcK4FkS/PpIb5Uo+Okewf6xutV1r6viFq0d7hl+1DzdQdsRqlaWh5gDWvswIi4fc5n/cKDtQcoSpiAT3wZNYy5buq/7gilmEUNsjB/A5fWuFMwgabaLl/aocUpWUP4jrRqxLtro7pkV2YOE/vv1IS0sOmnQznERVXVgxOz9upOb3cYJXQ0yiAG2/fzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GomWBosHBvC3VHH4ytKCuFQ2nW1TOWAVI2pULfniXEQ=;
 b=FWQKdn97jKEuCuq9b+o7ImutUtg4XpzmjRO6d0M46rCiHruJUaquhgIye4IbU0Vx4rhBuESjBf6sHXsg0e5K6FM41Q+aA0dHzRUMP9HRZ/QVE3/cgWJaXqq3aOgyE5xDmf5WDfypprjvlVEIfZRIb5+/honvcOWxa2s8g3BOLD0FVwYq8lH1pR1dTnfAmFrJho7i5hCphSqDEL0tZJPBEsKGQKh1SE27wgw3RWVnnrF7kYyFyKPlzO8nrKzhWhXeNtu5ii49lglGEl4daTF/v1rcmFPEAwW1IO42FT33y9J2hX5m8GZGXc5irZ5ykVJgLbVsoEFxSTfzAz4kzRWnmQ==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by SA1PR14MB5476.namprd14.prod.outlook.com (2603:10b6:806:23d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 13:25:33 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::ae8e:c5ab:50fb:ed4b]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::ae8e:c5ab:50fb:ed4b%3]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 13:25:33 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: optimization for nfsd_set_fh_dentry
Thread-Topic: optimization for nfsd_set_fh_dentry
Thread-Index: AQHaiOz0yLe16yGdgkeM/Wdo4AR5CA==
Date: Sun, 7 Apr 2024 13:25:33 +0000
Message-ID:
 <PH0PR14MB549329F998F7DB972744F45FAA012@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|SA1PR14MB5476:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JBURbRCLUZAyumqrTiMl+yLmLYegwm5Oh2Q9xOtD9H3oatNazEmU/5MlElEtXXrZbK2fCGCLD/kq4kbem+GVFW73ytnOxGhD5CIGJUZ8byRbHSip8GxuiI4x5Rrfy4E6NvaDOpHhnDscln5tea0xWKXwATo/QhRKu7MScUJnYEjbsQWVs/cP2knXmSgEmKqLi+XrqKr8b70EiqwwIELACw9Oi+ij5cAnovu1lIpQ8eMPURPJEP9uJYui4qRgBDZfL4HWKr2RB5lGk9PqhzCk5tvgAAv/0zNExAYUu6YsyG3Z0wW5c6RcvpkiAALABi9ps09DjKxCZBwzQrpp+YyHdX0EewTzB8s+nMAIRHew5Dp/DSTjKRPhv9tcSn5SINTPiC7xsI6odKPGuwf18yb7RyeEOBgaw+kcVOfzg6cxKxTP1VO0doaUjxGXd0uzueFW8bgdC6//VVV7nPiU8i46aZNju/IX1AjPWfXZkj8oSaJu+gDpZ4Cf9p+RD1KZU17kLB2cmbqmE0t11XAjBFv0J84NJ2haxk3RxExVEttaiQPXI4gcoqgJkX6eyPPcJ5oychmwc7U6Hdy2UyFx0Xy5+76fzwt1ushrdytml09ZpHjEHUYnHNU8DhTe+ERdC5cTMXBK7zXVtO5Ur+khZ00FtQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gC067X/5cTwzNEDwvITtfjVca870Sl++xxU6qbQaeOoYaruAbm/6FO8k98?=
 =?iso-8859-1?Q?IYVYHrhSBSgwXx5YnVOfoj9JZ4ahNPPdHR0MjboeJAvIv2iXlChHXWDkF/?=
 =?iso-8859-1?Q?SmKoJt148Y4YzST56SlPRBdfx/MhczpLVaRbylj839kQFTC1Eci6B0Er0v?=
 =?iso-8859-1?Q?hKGAMh/6H5f9i7aVYxX6mHcV/s8CHeYw90SiL42JXfNHz5RClvf+t1Ugvf?=
 =?iso-8859-1?Q?7yY3rKfYmrasaPqsXYfIebvDS7VABGAvE2HhcKkYHMRCXzqvoasOCF4m0L?=
 =?iso-8859-1?Q?mGEu/FaOjwGT0JSS7Rt9ECCc+wB63piPzBwasMP3Sff+TpPv01q6tWFqsN?=
 =?iso-8859-1?Q?zFiP3NIB2ETrMbNr4aQtANXHa/2frO39dUCITaJIaR0pdGFkfrE6F6iSo+?=
 =?iso-8859-1?Q?VpGM/zK6yq5+ZY3/l4Ai2TENzSMWVKbAiKJASLeQaLdvKz0KKF/0mreMDu?=
 =?iso-8859-1?Q?IhXpBrAjm2jII3n0vYZKNBEcVEiFY4wZWRVqNU+7uF9cQ7y1E/lxF66tFr?=
 =?iso-8859-1?Q?y2UTrbjtwDHyTDCTyPk140kGQnA4TBtAgR/DSydlFp5QCVRxMEsOuCPRpp?=
 =?iso-8859-1?Q?RhY8AoWIKK3g2ThgaZ0kf+VA2nINJMvVEvOAtCF4EcPrNuvCpVT64xvrS1?=
 =?iso-8859-1?Q?bjb31jgfTc+oLBS+UKYZzhFASU/iZkQ6Esjl1PsqMqAXYryUuYKqKSi1ON?=
 =?iso-8859-1?Q?9emZmljA/Ks4mV7Rb7E1Jvuw5/qYx/4L3Q1ZsadxYQXT7kdcvBrEd6rDin?=
 =?iso-8859-1?Q?LC9kLnEhkN8ugP3x+4Xi3WWuyIKO3fCeUwOoMO0Vvp5djJl32FHCI9E5Rf?=
 =?iso-8859-1?Q?ZsXqpyhAOdFMT+8SaIaOYlio8mjMTw2qYQNwamiC+fKxBMFeCh8xdnpdMN?=
 =?iso-8859-1?Q?Yy+q4UqmhlJZevv8jQ/74w4heMD5PRmEFWov85nb66JIjUE87JVhu+snVd?=
 =?iso-8859-1?Q?ylpZJMjwA9/Be1OrFToiZ1MsRjjbL0hQ0Bgc/7kSPVkhThjCzObAkWKu5y?=
 =?iso-8859-1?Q?JbTdT/iQPvrytCYw3UjdIOd3DFfiDvkpvXnz1rYVO5ZH/cJodsxoX5Zl1p?=
 =?iso-8859-1?Q?C1gVa9WMLlQWvdAMcMT6ohsqe9e3CTSFEVqdk5zV2bfDOais6R0DssSCv/?=
 =?iso-8859-1?Q?RWHDkhUsuWmbwIdIjqhmw1EvSp85lsVcpXarFQ9H5B3rpDsjN3W+KYykgM?=
 =?iso-8859-1?Q?E7C9mPQgWURPCBkrIbsEB1LVSZ9BXvLgb5nwMrilaWE3ZHUOdYuUmE3Btl?=
 =?iso-8859-1?Q?CtWDmxEQpPMyHWJWFJSZh8hVT0HJEbxQpvPTL9IYZJg7NZyPdMreriF0RI?=
 =?iso-8859-1?Q?2MYorNFWjinD5SDx/h0l1gOX3jxFCD1yz/y0lG9oMlkKa7hLPAVep5Nb+I?=
 =?iso-8859-1?Q?QWm3tREJfNIXCcAm1NWcUBskSqWtkJIV6Y16TcIDqiIXk/czYf5BCagl6d?=
 =?iso-8859-1?Q?gqZIwCiTvZLZcD03S52HefcXfqlpFvJJiLWIcC9Uhn51jAkQTFOta3etEU?=
 =?iso-8859-1?Q?PUjdhrJi8sHgPMgCs5Bi6Mw/uM0So+sRZaDRk3hMi36JFgbLc/9QXiTKVR?=
 =?iso-8859-1?Q?c/cuklQ7HhYGP5TxnFwfXfkIE+MP3B2pYCU8UveuYpQatmOoocVHO90zin?=
 =?iso-8859-1?Q?pCEAgJafNHJmVlNZETIi8H5/CqDvPcmwBc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 539b5b27-4bbb-4ba3-05e3-08dc570633e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 13:25:33.1873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R85maRgKigBeWdHlivpU5pEqRSSWz+fgElAV3mzx7Mj80kVilV9OaHkFwEaPUTr1YgpkV7vtlhQdJzlS1YfP+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR14MB5476

nfsd_set_fh_dentry is used in setfh and a number of other places. It calls =
exportfs_decode_fh_raw with an argument nfsd_acceptable.=0A=
=0A=
That is a test that always returns 1 if NFSEXP_NOSUBTREECHECK is set.=0A=
=0A=
However there is an optimization in exportfs_decode_fh_raw that skips a lot=
 of file system stuff if NULL is passed as the test. A test that always ret=
urns 1 still triggers all the file system stuff, even though it's not neede=
d. =0A=
=0A=
nfsd_set_fh_dentry should pass NULL to exportfs_decode_fh_raw if NFSEXP_NOS=
UBTREECHECK is set.=0A=
=0A=
I discovered this while looking into a performance problem caused by a path=
ological client that was sending 40,000 RPCs/sec, almost all get =0A=
GETATTR or ACCESS. It was causing the nfsd's to be stuck at 100% CPU by loc=
ks in file system code invoked by this unnecessary code.=0A=
=0A=
(We fixed the client by mounting with NFS3 rather than NFS4. This suggests =
an issue with the NFS 4 client side. Unfortunately I don't have enough info=
rmation to make a useful report.)=0A=
=0A=
=0A=
=0A=

