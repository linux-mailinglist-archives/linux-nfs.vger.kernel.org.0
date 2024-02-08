Return-Path: <linux-nfs+bounces-1864-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF2284E9A7
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 21:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4C1284D26
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Feb 2024 20:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AE6383AE;
	Thu,  8 Feb 2024 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="DxMmmb0Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6D7383BB
	for <linux-nfs@vger.kernel.org>; Thu,  8 Feb 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424003; cv=fail; b=AmZkGpbEYxGPGI6O7sXoKC62NoR31pdkDQpPhlzygUPtLr6toxJLRlk02dyLmMLyy3u9h+WAskN+7wVhDwDqo/vEdG01VMjZenlbaI+h3MAY8d8qr0j1w4fDBowqu9yWG4xV8U8wl/Z88/eewkAW6cB9W+QwHSkIO1OUwihPsQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424003; c=relaxed/simple;
	bh=7fFppMltPrddQrazzTATXS9uAKQVtuM5fAET1byAH2c=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ftbBOeNEJuuN//xUp2tXsEM8k5o4RbZZ0fviMqiYJHo4Yr31T4NXBe389Hz1J4RFDvvnM54Zko3my6gAGCukDonDhvHwjV+aXTyVSeOG6RqEt8cnaWbQVWJY6yHGY+7i40gOYg1dQ92teXT9eMgKXynSuPWp+a9FjpUYttldaCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=DxMmmb0Y; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1Uc1ID2jKRJsQfKFo08CtFxXMIEXs0mY9ZG0QXsq/39JjT+djGCBB/IEy5Z/f9sSO5qB+U3iTz4hIrvDXS4AKSmzVXcVG3OxBzbTT1KKq85Myjwqjb6Q9r6jIKsumJRJ3GRlxN7pv0EKY1ERDjdQKXFfhnXlx2BxdWetSUeZgtqzohzo21v4Ki01NTIyCMBtosCShxYGBdACkbXloQt4sZD0cB+aKdpEgl8BxxooUIXcRHnGZbZzn8LQdQ/stXmgFiT4FUBddqxQZPiQlf1P6Xxo52OcDTqNGX1/enjLYesG7RN1/XnShqR+VrZl4kG1B9Ri8Ra8nzPRJ4Sgrwy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpOsRzZSDgc5Lbzg63S2++Rd7XXQYETr2t/XTnaEgYw=;
 b=MKwnwB2vBZpaNTH09bD7T4R9SnFq8NuOoCTjIPQxnykbJMElib2/UtGcSkTibN8q1CCWv1QBhmGzg0NcbcEzTB9o6+D1v2Xfa2i4/qVWMLjHX4SXuRSKRl0rrK97JeQbXzZmLfH5mBbLR6gWv+V8TRc2boYgLtTNFVM2nEyQyrkH2oKjafxYGjGv90YtMbt0/q2bZ2a25HrhmXbrGXJr1iV2yelGcRHxxrXC5L1eYXdWt+KxEKGXyN9yrgxcV/jkzaPtcOw739sK3NLDqDSVjXpMN417M7f89aGfN4WFHIwHvcgxQsWzhLdLZcmT3Vq4pUj+uIL2VC0kNlF+Ud0CGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpOsRzZSDgc5Lbzg63S2++Rd7XXQYETr2t/XTnaEgYw=;
 b=DxMmmb0YgHsNS2RD5BhLqqfQ/RlMiUgWJDQ4+x/pp1lohH9+8jJHvvjR8P/atlpc5/GLyDgvG2sG1Y7+Z/kiVW7N89eNjcoUJPNlpbHJGj88CfrCjVHCGO5/Shv4TvXS6HoWcRtBqi1okocrvgMELESKOfuOqVYeYI6egPGSKdSIlbaWFFNSPeqTCl+Dfy/VkeWFYEH2ZBhQghG88yYSkJOhPhEHoGv5wyF0NgJHqsmy0ss/HvDckbBjTDimwyQVbGBtcH7+lBuY18UmWHMdys3mlhZ3ITwwP57y7sRLUeMyIqE7FmnwuxZiUAtH4jkxBAbP2PESLs6Hh9lEgcBayg==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by BN8PR14MB3396.namprd14.prod.outlook.com (2603:10b6:408:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 20:26:34 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::9fcf:bc98:5558:c857]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::9fcf:bc98:5558:c857%5]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 20:26:34 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: apparent scaling problem with delegations
Thread-Topic: apparent scaling problem with delegations
Thread-Index: AQHaWstcr/sBhJW1c0inPGg6Tk9HQQ==
Date: Thu, 8 Feb 2024 20:26:34 +0000
Message-ID:
 <PH0PR14MB5493F59229B802B871407F9CAA442@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|BN8PR14MB3396:EE_
x-ms-office365-filtering-correlation-id: e9b0597e-8e0d-4d08-9b03-08dc28e43e79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 w1DQw5daB4dM4/M9Rgm0Q3dLSlYIsR097ru5iNTwJFMqDiacBzf1E7mq86VXRn6luFXY2TUYFFJGDigvvJ7pzrZpXbCy89SLfBYTJpG0cxFH+Xt2HEXUwCOzFTs7kNWe2XLy08Xafl44IUNQ3pnQ93SFdHz2UwSRUmmztIVH7mOL6okzCiu9Az4WNtQpl00JDa2Aoe6/8LPaNCdZfNnfmMmVA3O+NhN1ZbTbnKhutB+m+xNVj0jMRnnHPJggCUFDMP7IjjmLji0sAc8rKeWYA9nCS92wISFjBisvqywnTPkk7mD76m4ZMTMZoVQ2yN/OZuV2RqY5pRSOuuqBqJ23zLRsXKrF2UzKv/KesFcB78tmiwofSzabKPdFtNO/yF+9BC6OR+H1rMaKcSaI6PHkzfqTtQ2Rza35XhG09q8h7JbiiZMxj0zvCIrYJxkskg9vXWDPB1n/GMawZPwt3UnHVuR2bMEZ0FS+UO6UmsA+E9gN+h3olEGMHwnRAkrZydDgvJFttQ4+PQzus1lt4JYofYF00QOru9IFo2Y7sTzwMObssyBQklE9aUljjBQCTouQQdXGCsFuJ3ZXS9WGnyOhZCq1kmJKtE1CTY2cxZVhO9iLcQk1gXyd2Hl54fTwl2FR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(33656002)(66946007)(91956017)(66476007)(66446008)(66556008)(316002)(64756008)(786003)(52536014)(6916009)(76116006)(8936002)(86362001)(478600001)(5660300002)(2906002)(7696005)(38100700002)(122000001)(9686003)(71200400001)(83380400001)(6506007)(8676002)(38070700009)(55016003)(75432002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uN4S7Bi4A1NnAvwAq3QbjbJhUTef8TUBNQGcVNF1xK3PoTzTan8Nrv/Gbo?=
 =?iso-8859-1?Q?CBfoJLk9rNf2gNglEJVHzG9WMi/W0sMxcu189/vtP33RAHa843LckJpesI?=
 =?iso-8859-1?Q?mEy9HpazFAbdt15xWBMHwHBMjPmF6IXLHq7V238bGLF7vlrpD3iXaUwsdZ?=
 =?iso-8859-1?Q?uR3sq2BsabNtsNwtQHtfg6ScNZWAf8P09Fx8g7fHIHr6GiUxhK0l57wsWD?=
 =?iso-8859-1?Q?5eeGJKmNr1cKgqZ25fEOQaZI7MG103+glgMM30lTwHKpJWHuaaX0NDIEV3?=
 =?iso-8859-1?Q?SnVJiSYZzNh7sm2okyUP2BEIFmUn3zYOJq2C+5MF6uiskiy9NHtMjV1dKi?=
 =?iso-8859-1?Q?DZdW916WmBsbQ84YEmqeDps8rNF1pU4vvoJLPIazj4oL4Hahz6Sk2X2TfB?=
 =?iso-8859-1?Q?hLFrMcHMUP83Tf6jW9ZoLlYgNEO+uZtPrsrHPeGJc3W9Zran7X18WQSxEe?=
 =?iso-8859-1?Q?Q4tJ23sdDJFoOYx0eoQz7XWwkPpoMyoHpnDhHTrTo5NCZa6LVmZMEug5Cn?=
 =?iso-8859-1?Q?aUrKk3M/Oi9MXY1QSuNi6UijyV6hjl5PYWsOJa6w+U3XHqpqDqBz+YcTRP?=
 =?iso-8859-1?Q?4/UCrb1SZADmYx/AuuBsehiYO9Sp8yOg5vwplWaTPLtfGkERNVl4ZdKBBk?=
 =?iso-8859-1?Q?TxLd1cwWVrqU8x42APAbXHQn6E+Mumrt7QVDMXZhD9wcEal7Yqe4S3An0o?=
 =?iso-8859-1?Q?plo8ikQfPSSdgRUAgLAFi90JPij4EBxu3zCaTKMOnVAVLCtYPI4ECrzWS+?=
 =?iso-8859-1?Q?QDG2tpj+hOcn2r6kFikhrTvoh6aBHC6/9JtNw64d6WyS+cXgU97xE30Iaz?=
 =?iso-8859-1?Q?tcov81b4lUMy3TC6BFIRIl0kSGXxYsLNytZfXZCPq2s9H6ds5gF+kR9/f1?=
 =?iso-8859-1?Q?na2XlB2gYOVogynsNdWtrxsNBvE9kvavZop8IYtKXksy/n29jf9HKPS7J4?=
 =?iso-8859-1?Q?Wqs9+FcySrn7Oeuk/fuhQLfLmi9hGu6qNKhBLClWI5mIvGGgIR5D3PL1n6?=
 =?iso-8859-1?Q?DzYfoXATfndBMSIHDAhIPQv4u7NaY1wiw15lHgTW7m4frSNax5ux0C6cQq?=
 =?iso-8859-1?Q?3iw9xD0PQvrTy3DJsJnLqq0VxWfJR3iWqQNe+lEDUSIks/7epEZFNXBd4F?=
 =?iso-8859-1?Q?tzMw1dky6JnPoFO68SPKeXQB0VEsVOuqZAcf9Xne8/QtyKz11jvSdJyakD?=
 =?iso-8859-1?Q?2u6NYyh8rensOiL5WpwwbRG3MY1qCxyKzlttYvArVpu8tCqrlj+CAMxIY3?=
 =?iso-8859-1?Q?UYc9pdtldT6MIrNANKBDVuNV1bSFDyeIArYpMVk77FEa37xGp8jhAda0a+?=
 =?iso-8859-1?Q?t/CXUMJVmFyap02wPWpnLva8M2nQ+CllcG/kuGjB9Hk5sJIT5xxcmk+ocu?=
 =?iso-8859-1?Q?XoxqLn0JxwIGGDJILFB5LIPdzRD5N4vBMefUyAc0cY+AhnRfCFyZAaMrwl?=
 =?iso-8859-1?Q?5K9HvQgDTGC+XtJnUThZ+EWokcW4DzhidSBnaikYvhfsLLFel1pZItQFbj?=
 =?iso-8859-1?Q?8PpqO9buQIaDGqmxhDyQj9Ng5ziUAvwEI4vX7J7KyK7LQr3mhOPlX4f0x8?=
 =?iso-8859-1?Q?Ufz7I0yr3w9oMdt3SvB2NbFIDdxAYNihSEioMiorLm4FqoIBToDHtMaXgc?=
 =?iso-8859-1?Q?9NsLZL3P0utqM0N1A3iOxFIOUWmIoaTJ436Pc10Y5TaLo2GvuAPCVhEQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b0597e-8e0d-4d08-9b03-08dc28e43e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 20:26:34.5312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8ZgQXF+zb9Tu4vpKIcrG6wC86wCQvkGCRS1PRuLL5k++v1ElnAUnvbaROqPMMBg4Jq0PVHy/RatHhimj8L1hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR14MB3396

We just turned delegations on for two big NFS servers. One characteristic o=
f our site is that we have lots of small files and lots of files open.=0A=
=0A=
On one server, CPU in system state went to 30%, and NFS performance ground =
to a halt. When I disabled delegations it came back. The other server was s=
howing high CPU on nfsd, but not enough to disable the server, so I looked =
around. The server where=A0delegations are still on is spending most of its=
 time in nfsd_file_lru_cb. That's not the case with the server where we've =
disabled=A0delegations. Here's a typical perf top=0A=
=0A=
Overhead =A0Shared Object =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 Symbol=0A=
=A0 44.87% =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0[k] __list_lru_walk_one=A0=0A=
=A0 13.18% =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0[k] native_queued_spin_lock_slowpath.part.0 =A0=0A=
=A0 =A07.24% =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0[k] nfsd_file_lru_cb=0A=
=A0 =A02.61% =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0[k] sha1_transform=0A=
=A0 =A00.99% =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0[k] __crypto_alg_lookup=0A=
=A0 =A00.95% =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0[k] _raw_spin_lock=0A=
=A0 =A00.89% =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0[k] memcpy_erms=0A=
=A0 =A00.77% =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0[k] mutex_lock =A0=0A=
=A0 =A00.65% =A0[kernel] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0[k] svc_tcp_recvfrom =A0 =A0=0A=
=0A=
I looked at the code. I'm not clear whether there's a problem with GC'ing t=
he entries, or it's just being called too often (maybe a table is too small=
?)=0A=
=0A=
When I disabled delegations, it immediately stopped spending all that time =
in nfsd_file_lru_cb. The number of delegations starting going down slowly. =
I suspect our system needs a lot more delegations than the maximum table si=
ze, and it's thrashing. The sizes were about 40,000 and =0A=
60,000 on the two machines.  Systems are 384 G and 768 G, respectively. The=
 maximum number of delegations is smaller than I would have expected based =
on comments in the code.=0A=

