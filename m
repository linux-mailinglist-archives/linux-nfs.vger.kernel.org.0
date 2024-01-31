Return-Path: <linux-nfs+bounces-1618-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CFE843F4F
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 13:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D906F1C24F29
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 12:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A02D78686;
	Wed, 31 Jan 2024 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="tVUuiHMJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2120.outbound.protection.outlook.com [40.107.223.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FFA78691
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703699; cv=fail; b=LxYJPbDKP57zo4qEdDUFgjSRdZG8DeUthdXV0lA7YTgfo9F6ziVnoEXllFZqu7emBTazcNa77yjQBt/pQ+uwg+3ijsjqWx7akI/7fhG6PFRtifAvG2V9U/pNOgfnUMniQ1UfYWIolt1zsSpKP/7PJepby48WL0xyGr1n2FlRygs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703699; c=relaxed/simple;
	bh=2yKvfbAXRqM3+06345RwtEv+xw4KhJ5a4DosRQ0Yx18=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rctd97T32svMqdvBw8S5tAU1crMYVt7PoiZ0hVnaBVDcKGJChg/L/tGBuc9+F/TcfqJdxlQVm/8hXDdrYwoZriYiB97NVNGY1T/f9gUaXimFWLvli92+jG7evcy0vYuJXvZKXKMUkGv3SAoztzD7KSf4UmhtoESexQLr1bi/sIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=tVUuiHMJ; arc=fail smtp.client-ip=40.107.223.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f40PCw1fOx0t9d4CoqSM9F1zO73FeBlu3OhHgfy7gAWsubnuGv5gN1DA6Nzdc9HSWBelyNtjI7+pIQhZItKhhECR+ehhnwHJQx1x3Vn58uBOMtXD6GtwRtphA7cPScjVX/apXRkTx8p4RdV7P/RuluFgCLbYPDX/ltBga60ZmkDQEmmNJyEE6/Y6uMwk80DupE7elw3G/pKEzHqcZ3qnzG/4bbK/PmQfbBSBaCjeg1HKlKsjfa3mHz2obVkFWCbASAi2Rvb7b66kQ+7CI36hx3mSccofi1Yi9tgz7OgnGl9mm+LcA1jBgbBbhP0DdE4fFS712xM5w6RG4jc77Jizag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yKvfbAXRqM3+06345RwtEv+xw4KhJ5a4DosRQ0Yx18=;
 b=D9BXDiO0RLOZo4s5GZrM6JV6jl7IcUkmBsDPuhM8PLY85wB9DlHp+7aOI5BPlNAt6yDIQcYxE8r+mImo2MG/SKw+aLoSKUNKoGh51TKukj7OKIY2D+jYs9mzLNrJ46xC2A8qYhDOKJNgPlbLNKxXYndba/S2nB9880mXrGF/XwyJMaS81/uao9hDORrvFUXxjo4HonB9SwfSJyIzhDYDNjN677gyPZ2YHSNEck1RHoES5rVvAeaAbcb+gDn7hvRh3C+piDa0nVchRArIEE2s8QuzkX5Mn2DPdEPXADYaB3DZwD9w+B2Qz1aXjlKIydIbhWlONXZ4d9Y9mXvQHbNOng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yKvfbAXRqM3+06345RwtEv+xw4KhJ5a4DosRQ0Yx18=;
 b=tVUuiHMJ1020pWz3PWOpET44UEqKTF+Wxyw1bU+XY0u+zlY7hNca43RFFEJA177D83tTWI2pJdMFVddubS+CMpL4ISRid6YKnIRPJgFp2DePLSTz7sJDQZCky1nli7qagibMQjdbNGw4yC6/wG0xWMEvCV0pBOVmbouiBahSja9hRBKciBhN6l+KhGmetVDTMmLPrK1GUL38vVEI+BjACTubn/pjpii4UQAuMauXPoG7mj2aFwj4RC0/tQwYyfI/aCZGS89vzQOYNL+XTzugjcwvHvyPK3mapkDqTVESbIWgDgt2/LlKazD0fYPZJtfoA8fE+bckytXYnxvWwPITiw==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by BY5PR14MB4052.namprd14.prod.outlook.com (2603:10b6:a03:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 12:21:34 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::9fcf:bc98:5558:c857]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::9fcf:bc98:5558:c857%5]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 12:21:34 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: effect of delegations
Thread-Topic: effect of delegations
Thread-Index: AQHaVD6xA15rWFAZCkmQx3gvW7BaYg==
Date: Wed, 31 Jan 2024 12:21:34 +0000
Message-ID:
 <PH0PR14MB549361281AB9CB34E27923ADAA7C2@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|BY5PR14MB4052:EE_
x-ms-office365-filtering-correlation-id: 7e33a88c-dc15-4481-2130-08dc22572a3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lsLXSXL8uzVqMoGhFVmVIE/YuMJyJ2aW6zubAfp4zwEdIUSL52NHM2kXapWXtlDcVgfrdBJq13GlfBbkxOJjNDcEjxohYbjJ5DI94e7XgwXamfno3pn3dz7vvjsBFyouUZokNjzbf++SWi/UrmBtrCiNkavu72XP695FkiZxQsFvr2Dm5Gyzm7qSpCSH1RdI9u6JNMNJRzpmk/CQQ7QUpkP8yITZkVFng4fh5RGxUBMZhX6EnzV0/AJ0PkdwT+ZDBMsFL9Elr2YbIWKAw4FDPpkuQzvbAWDhsSjegkPr74FGlJqyVhTiQ5xQGOVsp2zdwG0O27viVigrdcAQ3MOc1FFhdEW5G1iTTMPvSwCAyf711vZeTMRwl2UDA/kok++3rMqSFofp0zEXhKVQY2eh2xQ1Q7k8qgvYN3XPgXSwH5rIQrQe/qQVSYzC3wnseVBYzd+PuGODc80BrJKyo1AlYzN2uslqUdFwYbrb3hGGmzxPsNAv048oe98Vf5Tu9tyITnzlF2idNlNuY6oOgIJ/yWySaVle12x5DWE5REpOWjRxpgGD5hJ9F+tqHUu3DmRvwtlkVtJt/rTOhKgenwynk5672AWaa/CnB+52E1BQSE/cFbGnLcFBOy/cSFsIGzo1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(75432002)(83380400001)(478600001)(41300700001)(6506007)(71200400001)(7696005)(9686003)(8936002)(7116003)(8676002)(52536014)(122000001)(316002)(64756008)(66946007)(66556008)(66446008)(6916009)(55016003)(66476007)(786003)(2906002)(33656002)(5660300002)(38100700002)(91956017)(38070700009)(76116006)(3480700007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/L7PnUndcq79Z/SzFHfpIoeABPgXSlzjWDOpapBjAD6FkKVwzBE+ISx0Fp?=
 =?iso-8859-1?Q?NXBoKQBYGty3a7Nub7EWVVyfUDOe0tyalsVgo2JaGOuhST+xrORet4vT+E?=
 =?iso-8859-1?Q?XYX3nAeqQC2gBWJa1qexIZBbxt8GS4jwCeJ0Fc/G0yqwKtUp+kgnTwRdBs?=
 =?iso-8859-1?Q?wo87O7VN9pN3BRxDy67I8fn5/PhPNCHR+/MhwXXZFOdzAgFuziELjxQxBt?=
 =?iso-8859-1?Q?2lVHvtQUiGtCLGPStySidR8/6QVaytXqu5ly29dOJO3fg/xaW5+SwAGQFt?=
 =?iso-8859-1?Q?WPUsEjXyUUcpBwveIDIrDzuq33/C++gac70GP6E90x/O1MHsEltZskeF+k?=
 =?iso-8859-1?Q?YukcAIyRDAyWQ7kWQFuokVBIWR6elICjwzBKgH03n6iq5tpFBve61b3nwu?=
 =?iso-8859-1?Q?rRlHd1Djw/erESS4oaJhXvPFb+rJoWaE2EPr0ycoOlfQgr+XwQo8RVhDYX?=
 =?iso-8859-1?Q?W5g1BfgopCJwqXs7hBNlBptM1sXHVe7FxrVqe5yTFeGbYdb5UIgY51rgXF?=
 =?iso-8859-1?Q?APtPT8493EhdEt/fvBZgOnWkWt63QQ792Fij8CxXH3n+EjK5vK/+K8V4jl?=
 =?iso-8859-1?Q?IDsesbKzCM2oK0bKnD/p15Qny6NXsZyZlXEmWPx2LuQOKmvctgPmTJe00G?=
 =?iso-8859-1?Q?tS2Tt4seCdfywnO4kPCD35RykL7zv1r1SuDPdJ1vGeiyI2eT3h1nAGdY0O?=
 =?iso-8859-1?Q?IFwoAyjrMXTWMs5PjB7GAuULjGRCl0XlMFEG6o97qzQf5BjluxT9S/e4FR?=
 =?iso-8859-1?Q?J36BVz1z3ffz9gENwpaLCCmEjA2MAo4i9EBEDKZ+w5qZwCKYuIgOLv42Ba?=
 =?iso-8859-1?Q?IMTiIywoIN1B0zdngTsdXh7QgwRanrlmoOvFO/ZeAnOxU/2iyDt7otxVAd?=
 =?iso-8859-1?Q?jBKYFX7tr6EC3KNcdSp+RJSuoLKtcRtvYB1RAIUCUyoVfF/ffQ5h2wBcvL?=
 =?iso-8859-1?Q?ITrTEsgLz+fiX0zs+k9pNiiRya7Z+FkL0M2wmL/nfZykMc9OpFb4hKHve3?=
 =?iso-8859-1?Q?a7XSJybzFxuYw9rStFGCHT6sUVZblROgjz4rXUknd1D+kwfVHn46IBy4nV?=
 =?iso-8859-1?Q?jsj9dFQgq1IhvgEY3FJrEOY0Pot5jX8M1YguyItj3aGALNqU4HHZQV3uHQ?=
 =?iso-8859-1?Q?IeslfLdPoM8zpCP2PKW5x2NPgqU84ooZB3Lhml/jB6NSfhBFEJJqkOAX5y?=
 =?iso-8859-1?Q?kl1aH8Y4cy/5P1cxz5P/ja3Oq85zBzZIsygolVoAVg5BQWGykHjbTZUPbt?=
 =?iso-8859-1?Q?Q77V0764k98/DSRdGbWly0D8yHmmmQe51omnIQXF/iPVPYyMEMquO9ONVd?=
 =?iso-8859-1?Q?7z2tQaItVe2oPIcvlPXVHQxGauc9nBzWJYs8P/8c2kErYmylOp6vgxX21a?=
 =?iso-8859-1?Q?STjcays9eXjw2iU5+jnAx3k7QDOnI6JQxuzPMJsoo0e7W69acZLFsKQEGq?=
 =?iso-8859-1?Q?53HjEl4DWZjPpmRyL/dxAQcEui4Sj4sbA1c8NgHjXIazuiN7wXTDHI5aHi?=
 =?iso-8859-1?Q?ZhO3POPvJQMGWQLHY4l4+sPdZLIEPEZruYDKz+RzyzvjwIGFBJoRduEEQu?=
 =?iso-8859-1?Q?g+6CTK3/Sq3mQBXni14puKZrVPaZTuQi7PNlwqTCNytmzfG+79IYF5lTLa?=
 =?iso-8859-1?Q?paYIUSqijX0/Tl51+AY5GgXH8eET1LSV/Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e33a88c-dc15-4481-2130-08dc22572a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 12:21:34.5621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uA/psI2hsBohjkSmzdGthtjxdTB3O9lflKjBVk4hwVolk5/RBBxK8czS9tIhU6rjFdd4QyGTborgzGHrdTD/VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR14MB4052

We have two production NFS servers, both running Ubuntu 22.04 with 5.15. We=
 had been using NFS 4 where possible, with delegations disabled because of =
bugs that were around a couple of years ago. This year we decided to enable=
 delegation, since there haven't been as many bugs recently.=0A=
=0A=
CPU time in system state had been very low. Suddenly it went to 30%, more c=
ontinuous on one server than the other. Performance degraded by an order of=
 magnitude on that server. Turning off delegation went back to good perform=
ance.=0A=
=0A=
We'll report this through Ubuntu, though I'm not sure whether diagnosis is =
going to be practical, since we can't really mess with these two servers. I=
'm hoping the report might be useful in any case as one data point.=0A=
=0A=
(We've had to back off to NFS v3 on one of the servers, because of the typi=
cal NFSv4 permanent client hangs, i.e.hangs that survive rebooting the clie=
nts. These are almost certainly due to the very high level of lock activity=
 on that server. Again, we'll see if the Ubuntu folks can help diagnose it.=
)=

