Return-Path: <linux-nfs+bounces-8883-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82FEA00007
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 21:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9101162F91
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 20:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2CB1B6525;
	Thu,  2 Jan 2025 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="gC1Ajte0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2134.outbound.protection.outlook.com [40.107.237.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529F1B87DB
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849942; cv=fail; b=IfCXsBGiweXcdrh8BorG9HkPikp7AFr2AA9qh6bFvOSS09ALZ0GVxRijj88IfSvTh+uish1MA06PCwsb0GFH70LdtX7HOFTR1sOKoJf/gI425U0bSHgxOeZX6ZC4V+RCBgOfIFICwko8D7X8mrthl2Gcy8qD0AE0KBISvWrkUT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849942; c=relaxed/simple;
	bh=cCb9YWvEVU8gnkGpOcpLFb/AbtJJkuccCiE3GJ4UmAU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HK+213VixJUMjVPzIoDdbdUCR//OAwJrcpJyAtBatIWQEOovYyfVVSjwc+DuiJWPVZvnMVXeGBGtjYjedjSj57UD6Wept7fdYMzahOFv/NlsubiOQReCmTHc+8BvMlue/bPwHHL4XklU1jZIbSZmY8K6sQOOTC0psGyVMtRGwbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=gC1Ajte0; arc=fail smtp.client-ip=40.107.237.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8ump7qy0WyqcbJH5kfIU5sQqhvj05Y+c2K8b6JCDFhGg2EppiePOOjp0+qFisQYziEe+B5petmWGghg+AeEUJTR6f8MCOAHbi/mOJouhW/Mm4dmSjz2I/OkuioJpByChUoAYLKpiw4lptrDByODg+KNqLgwK15Me0lDFy73KX4FiYzFSvYLa+bjoCc9VffKPdwyOpEWwFDydiU5Hq/e+/aUx5ABlC2sb0aPIZjfwEKn2aHLQ4uKLIpTq54CIQ+HbT/kIJd1yKOkJSrQ+AureQYC+9VWifnXnITx92T67fOHKldBgcqu5a+xrXNMEBoFFnhVbqvJdOsnQ6NOinQqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B935yx5zl5dEjdhttHV2o1K1GA88FGIHJazF/83rf3s=;
 b=EeaXzLlcGklPQ9zbo6U+p1EDlzDxQqwHfShS9dTpUT3q8oqg47z1oiUgYiioQy5y+rDujBP5NR0DE2wjlZrMo+t+mb7q6ReQ5iO2dEs2iTxn1y1/GorqIfs3J+BLGBNnGiktZmaJ7vsKNfv+m3KXjJcqdX+CzrJpLsh1S25vO72K2qZbv3nSNaz9tEVyv3ij8V22x9jfOA9Tzaz9TUY5roLKWDph0lWL6e0MGbpHEzVqnc1MrIl6oT8y1DDyd/BzsuQPDWcfxj3NBJDAXFRFvlXkA5pXEoDoUAlUU9f+qsl0FSehcDe+z61bcOuyiBpqtSHHHzyqzOMng3j5qUK7ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B935yx5zl5dEjdhttHV2o1K1GA88FGIHJazF/83rf3s=;
 b=gC1Ajte0cYGHSk7+8lUbVKlPcKEybcyMvHcmmxm1zCxa36ut+721ksAx91/S7XdukZjXmRvSQvZKj+LDGfd+JBTlEyFY9iHdAicGlllmIjMWHzEY7vjI2cyBt5c+YvsDuQAgWSpEVW6ZZxRxCJKQDFt2PtwV0JRFKUE29AdertfmZgIsSahsI+qTRc8gxubMMmAzq5m3edrwdIO+ZSUchh085OhoTeL+vQtTOv4wLpy5wEXFOa0tCSAQB5DYkb85MRG4vNx48szCPXywVoRYJVyh7nIlanW4iTV6dioc3Yq5axRgthjsBtX2N+onDsTDC1u1DryQSn9hY/Z5mGcqlQ==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by DS0PR14MB5591.namprd14.prod.outlook.com (2603:10b6:8:c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 20:32:13 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 20:32:13 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: problem with nfsmount.conf
Thread-Topic: problem with nfsmount.conf
Thread-Index: AQHbXVMhJuSPvcSY+EmZgNKKwEXcQA==
Date: Thu, 2 Jan 2025 20:32:13 +0000
Message-ID:
 <PH0PR14MB5493E6F4ACD3CA4385C7E294AA142@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|DS0PR14MB5591:EE_
x-ms-office365-filtering-correlation-id: 140c52ac-446a-460a-b789-08dd2b6c8a8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VWPiR2BpFdbAEl6mQRiZkTOK/99Q+O9c25+WhY1D64QHHvbyCUckZcTrPm?=
 =?iso-8859-1?Q?p8abx4rDhOoCUkkmsRdcPq3mOO1kzm3N+MxYTC2CcVLzfjAqjWNu1vHXTS?=
 =?iso-8859-1?Q?EDLg8b0LdZLTjMja/fBSLTjAeg6G6tAgWpxrIeCDagGK7Cb0tiqePzKXU6?=
 =?iso-8859-1?Q?IImeXMztqHFs8YNmtZ345dEx2a+DIpFRW693MbEWP9O2JO7HThF5vmcfxn?=
 =?iso-8859-1?Q?ev/LN6kPYWwtOFNyDiAVfBbfXNAnet+TWF9i5ApCghtQOzRdAgXbrY7h//?=
 =?iso-8859-1?Q?zRJhlIMrPyYz1fJ2ihytfgndMmNeITpkf7GJiNiun2rQ0IXwW15STT1b6y?=
 =?iso-8859-1?Q?Q60e4dFIZdLumtIsRbBJHkFSPo8i+/aY8ahY5wNJ88xdAn63bOtkQHFmRB?=
 =?iso-8859-1?Q?aNNUZ1ucIuF8eAn5zGesKnjwtlOz/8vN1R7xiqklIZ67z3vgT9VNRoDDI1?=
 =?iso-8859-1?Q?DjDQry7B+cmI7w1nj/NSgIzvMRdLMLqE9HVhZ7IJ+SHjL3DqXzeD2IkTVC?=
 =?iso-8859-1?Q?SOmsv4peMf2FDxtS9gcib4dCOX0UoX2YFbN2lGwr987dqYeuw7YGHw6ns+?=
 =?iso-8859-1?Q?8ftgAbcq23iI998vGSduVz+A4J37OPWW7wofetni7JaWaIWtaV91PFnNZX?=
 =?iso-8859-1?Q?+ESBnAK9zEPB7sdpB63bL/9VYkQsFzxK+cY0tLb43873y74jH/lC/dG3i7?=
 =?iso-8859-1?Q?ucNhd5hOICIs1k0GXYBCrLbdMa7a03RLGJQ8ZtQpEsr74mxX2FmmuRxt3o?=
 =?iso-8859-1?Q?nEJyrpnLmx3b4MrzYwSo4XoS1SaI4zHUm5F04ILiwjA8OLnZjF8gjdLr3f?=
 =?iso-8859-1?Q?9deJ3Dl0VWql4YUOcOltR+EvRZL+GvArQaCTmbyLuA1yIVFUuh7Ga4FkkZ?=
 =?iso-8859-1?Q?ikzlAc2BUg4GkjVBBBBXvhVb3nColZEH3px80GKhjftznogmIXxpXWxNcr?=
 =?iso-8859-1?Q?oRVYXV95FGlAqC7htQnAj0Jla4HCr+Ok0j5W1Ep8qlStw9mZ96G1cm2G9d?=
 =?iso-8859-1?Q?Fk6rBPvOgKUG5UanEVDIZCn8FFTf6FI9SPApirQgHiwSPC9PWbqafiCNCe?=
 =?iso-8859-1?Q?iA5nVta8XlIbW+nXziJTGVdh5ok1j8ZFo6M0GGaqIZnCjB8irZ5xSCaeUy?=
 =?iso-8859-1?Q?BYEMXC+XjdcngeKEAP3Zz3AbSF1IaMm5oriDIkbB5i8+3YZX/7KWHFWLuh?=
 =?iso-8859-1?Q?Qdawmw8+WEL+Lfz3Ryg3oMl1i+tiJ0QJklQGwZSnrnQchnz/BOuQ8PK1M/?=
 =?iso-8859-1?Q?nis3KX8q0Zis3X+sWmvDb2HKhuyX54f4f8ANKOl7+3h6cvL5UopPlqf2OT?=
 =?iso-8859-1?Q?Qdlh49qRTsFe2RaWAnI6MTjQG/mRpTX3+DZGK4nHg85mosmtPh3/LgvcXg?=
 =?iso-8859-1?Q?QWqB0FUot/o3kP/wjA3dK0b5FDSNjp7+IlKvEu7XOyhAf/9KYmC7PeWw1j?=
 =?iso-8859-1?Q?J1Www0ciBM2VPUR0lL/sGl4A/G+nziXr1VUbGHLTl9NzKaSbaBOKm6Xdr1?=
 =?iso-8859-1?Q?cgF+jZlE8g9fh1mwEI95vT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5xYmbsnEb/p9cmQsPlussmzP7R8ZZnyrxZDdDrw3AOlA15Ky1evGqRxJRj?=
 =?iso-8859-1?Q?oSzGpnycyCHGOOk0neEjvOMWZlugq+sbpFhjYc/VrTgnx7kWkp2BVKplax?=
 =?iso-8859-1?Q?aAMKlsTSSs9O5kltEMTVD/HebTkP7EupIPqsoJr59KyEpdGNcjUj66jeD1?=
 =?iso-8859-1?Q?kxsenOHHFLvQEUs2joSmCSa6h44bJP3iA+ueKkPyyNrMJB47E/UVzgYctX?=
 =?iso-8859-1?Q?bpHgCGi9+ukILby60PRPgOWrwToUJerECl9X3W6qIwWWVSPa36qy+2Ev9T?=
 =?iso-8859-1?Q?dcg9oCIZ+uaMLw8mlWYKOyTmzlfPRQGOEaWZKNzhQVL+7Y1Zw0LHtm6ldg?=
 =?iso-8859-1?Q?KTz9RT28Veq2XH49zwxviKW4pJI4u1VK4Z51059u1bhj4v64wgBFzuQozd?=
 =?iso-8859-1?Q?cJyCbiTeKAbxZfNXEXE+f1Khf8DFpnYp5neazvhHFQb8VQ/5lu2VIzsnb1?=
 =?iso-8859-1?Q?MhDvK941ML/glz0JwDXkdA94xhdnENN6drmkPPQ66ai4z22aU1WJOMLrrw?=
 =?iso-8859-1?Q?NSup3jIK7VcwR72jSwRbV4ES4PV5AeLSrQl12XqbkUEey9dGs1frVlq0Vq?=
 =?iso-8859-1?Q?NbYbOZNshz9S2/oIBM3a5BObUID5UOeh9Ix7767WXfhD2B6eT4hk7v81c6?=
 =?iso-8859-1?Q?V9tZfNwF2xUrWE34KkrZeyd8bKb46rHOTj3AR5qpnDvlh0iSmG2DOk7eoO?=
 =?iso-8859-1?Q?SS3oUext7XA3Y6fzRhS5NAjewnUfJs3qAQQf0WQHpy6w5GQRKW4L1YCdJb?=
 =?iso-8859-1?Q?5v737DVheXdOeOwnmfzY1dnTnMHou1Y70/TgI63AiF55I9GcyLupAcRmy1?=
 =?iso-8859-1?Q?UsYaDG3b3XC36Q7N5vR5MDK2Um7Taj6Kq4Q+XQajRjYTovm+UEBISPG6Xu?=
 =?iso-8859-1?Q?FGQ8fAKVGV47pE201dJ7mYVy+HpwF48lVzobOvriBj2RpKm09IDrrfCvkM?=
 =?iso-8859-1?Q?io6bYTgn43LTJ8+g8lG1u44NBWMqm+pV/FNMt6Br7+QbllSxLzp7IEa0tv?=
 =?iso-8859-1?Q?ywUgrevAt5qBkVgqh+CEsI7uJUu4yxAZTPxlA3Rvaxc/PoE3PliQ/hIPW6?=
 =?iso-8859-1?Q?06VKcliWmruiIbKvxkIs2BlDCQRvgyAjRek9znJ1sKgc5fFk4Rr3Wy3lkq?=
 =?iso-8859-1?Q?6e8jGozryfqA0+KxLHZcBof0mdw6lAS9wDTjK5bHpfjldYwtLlWvgmFo6p?=
 =?iso-8859-1?Q?+ajWCZKjCADuc4wOheC44e6all7W9YVUT70NwKaMaYSo40B/JVOKSOYONS?=
 =?iso-8859-1?Q?4topkQR5eZhEKGR6zd4ouWTrq6Hw4T8Re8ftFkRmd2t0diG+aPTqdltZ9c?=
 =?iso-8859-1?Q?z6p2EsrQKY2NucnV1YecgcsejNXooya2k9pMqy+mQcRpcl4686wVO/W3SL?=
 =?iso-8859-1?Q?6yXCJzzeyF39u6kTWka9Uq+P1lTAR7XrdD+RWhj6u/vRRWzLQoiY3muPEN?=
 =?iso-8859-1?Q?9rx9kpGUjSQhzzFcpnSkpeucKks6ycS2vz3LbkEmrOceF7m/AvOBwcYAvf?=
 =?iso-8859-1?Q?z2dR3OqNmHI0F73BNc0fH4GvcjV3ohL7gGaELiyQYkNTLaGcqxRz/l3ACF?=
 =?iso-8859-1?Q?PAZtcruoezH86mwsg+b4MMbUAy7AlTxuVV4W4Io/YaRjkkN7sR0r+kAftc?=
 =?iso-8859-1?Q?G1fCyZySQkPqVwAt1UvQ86n1xGiGVEFand8r5m0eMRFXXT1/Jc7q85YQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 140c52ac-446a-460a-b789-08dd2b6c8a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 20:32:13.7141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMlledCmEtqoIqL+u0cGgZA+VQZP/x1uXvqeh7mKRWYfDimWNWdYy21Ff1nMoItnXSQCFIOqYI6KTnO1AX0x8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR14MB5591

Is this the right place for nfs-utils?=0A=
=0A=
/etc/nfsmount.conf if you have a global section and multiple servers, vers=
=3D only works for some servers (the last?) I'm unable to find the exact al=
gorithm.=0A=
=0A=
I've replicated this with Ubuntu 22.04, 24.04, and Redhat 9.5. It also occu=
rs with the latest source (2.8.2) built on Ubuntu 24.04.=0A=
=0A=
[ NFSMount_Global_Options ]=0A=
vers=3D3=0A=
rsize=3D65536=0A=
wsize=3D393216=0A=
[ Server "communis.lcsr.rutgers.edu" ]=0A=
vers=3D4.2=0A=
[ Server "eternal.lcsr.rutgers.edu" ]=0A=
vers=3D4.2=0A=
=0A=
mount communis.lcsr.rutgers.edu:/xxx /mnt=0A=
=0A=
will mount version 3.  Eternal will mount version 4.2=

