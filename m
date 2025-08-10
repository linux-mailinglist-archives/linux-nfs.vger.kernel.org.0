Return-Path: <linux-nfs+bounces-13545-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D28B1FAD8
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 17:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F9C3A4C06
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BBAEAE7;
	Sun, 10 Aug 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="SX42c2Lc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2119.outbound.protection.outlook.com [40.107.243.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF6A10F2
	for <linux-nfs@vger.kernel.org>; Sun, 10 Aug 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754840752; cv=fail; b=ND1xZAIIsIuggtT0LjWVCjIPMVhfpqcwtmDmOrnTQjDVvJvde7ZSVOwvZ+JqL4HfBVa6fM/zgO66ojMXg7gfX9TmpFtBXrEI7TJHEnlQ1qD5yiB5DG7VopZUz/Mxy5PZqdXR71rG3GzhAlipyZWBezTqKtqv6SGgmo+/WSl3Zt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754840752; c=relaxed/simple;
	bh=6SX13xCh4M+l/XyX5GkH1y4WOjX1oUqFFuk0gOQQT/w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=feBFb+hknZSkj4otE1RPm9moFHvtceaeBnFfpKjbnfzgxnMcB9pwIUbKb+NlnXlhl5Yb9I/JSSwqjH84a2r/GlPuSb9niSuO34sx3ixQrojSdXWNXWM+K/r39umkvSVnap8Tz+Drki5tEA7izCWkDkg8p8PCzGcrcP2bIK0c4CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=SX42c2Lc; arc=fail smtp.client-ip=40.107.243.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8/Ym+b4E84qdyaAqik2RwMw5JRUzBNGWIi7wUpuKQMe7puLiiiOKUcqHVBLlJpv2Uo5uWSO4ZzwAZqmQh7piO3b2FLTxjkyDSmddWaHONM9XRfdKf5QNRSP7JpIcZqQTcdP3779bmgNm7TeEyrgb5ymj76TXEzPTJtrc489hys926tGS7m5MaTaQ2PyQsuK5WTohgmWngSHEZEp1VNtUOPten7JUTORiqFCGqE/FCcPH8NyRksLkKRM3+KdkRQq+D9FPH7b3dn45UEX6155Yzh1OEGFSDFGY22FNyvHVs4jBVD9w2opHdDdqnppqLZZKPh2qhpH6bHIVyYFxKy/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SX13xCh4M+l/XyX5GkH1y4WOjX1oUqFFuk0gOQQT/w=;
 b=ZHycNXjSZXVuol0ufQpMqmZ6ps4hckF/vqL86arY6RUkDko6uWeeLDuTmjlxmK7xZOX6ZswsZquwL+8Itrhsk5AgMQZ8AkLedw5s7o3yO2erWwtypP/veNlK9WPxl89MSfLPiXZCPeMyRms1WLk9umoceKuhk5z7+D32Ng9ckAohmGSW4TKDgw+QhdlBRxItWfdXrOr+VTsqVKiwBzqdGnPuRRm2piv8/9o+eQlDuOIsveJIZ0mxrzgn7s22r9gYa+CH2M8lu1n7bvkRhvfvnVamNnEaUiQtUu+NHXan/4DSkrenGHYexs14cfvUTUkqBLVBXREnxtO9V6wn3oLGqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SX13xCh4M+l/XyX5GkH1y4WOjX1oUqFFuk0gOQQT/w=;
 b=SX42c2LcGtm1hSLWnETePaYj6ODsugIWtLiM3JNUTf/qVUt72mFncRws3JW4A6Rele/m5zWljZclMtex33w7D4Zqv6gg3XYpQymMBlIuUbQcX2yTAQdz7LmHKyu94iPTeTeKgyG4sdqh9y/rj6CE+sUb0CM1AF1ivbxzkXuuEHDgfN2N83tVA3EclqeNjEjpdhhuyp5cWLJqJ5fepr0x8HwvIU/NBc2o3MmSLvXYI2pSWgn58pvnSemocIpxTfLlRLli2PAShbvAhL8bNzYyuerzEds/ZY8NYHKodhP36/tuU6ajKGIcJdVQ/MYV9+Ipt6UoP0ckBEgSTq2FXRFbQw==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by DM6PR14MB3516.namprd14.prod.outlook.com (2603:10b6:5:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Sun, 10 Aug
 2025 15:45:48 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4%6]) with mapi id 15.20.9009.018; Sun, 10 Aug 2025
 15:45:48 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: Jeff Layton <jlayton@kernel.org>, Linux Nfs <linux-nfs@vger.kernel.org>
Subject: Re: possible optimization in nfsd_set_fh_dentry
Thread-Topic: possible optimization in nfsd_set_fh_dentry
Thread-Index: AQHcCIfluO6WaQU80UKvzcZGuHs8t7Rb+B0AgAAGmaI=
Date: Sun, 10 Aug 2025 15:45:47 +0000
Message-ID:
 <PH0PR14MB54937859305FF7B079680A4FAA29A@PH0PR14MB5493.namprd14.prod.outlook.com>
References:
 <PH0PR14MB5493CE0EF511E2D827A5ADCFAA2FA@PH0PR14MB5493.namprd14.prod.outlook.com>
 <e0990bba947a2dd259458a8b7c39050237ef3418.camel@kernel.org>
In-Reply-To: <e0990bba947a2dd259458a8b7c39050237ef3418.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|DM6PR14MB3516:EE_
x-ms-office365-filtering-correlation-id: a6f1eb1b-6706-4dc9-4ad8-08ddd824f9d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?IKRzBAXJhnnW4XRyoeW5mqHKAtzKk/jvLWhiznT8hNCh6CEtB+cTgIuRZR?=
 =?iso-8859-1?Q?JPPD6zhkzbjwhTMoMaqKQ7WGKPv7g78BzBsdWFtrZYNumDg9jRWsK4IBca?=
 =?iso-8859-1?Q?9HQgqS9s/khwpsBGuOGltImLBwUyEm7SWak3ZnLt56CV5Jrz0TxHrcgRjh?=
 =?iso-8859-1?Q?4A7wkIbdNWd9yjy8FyS47BxsYlaB1kMBSzD1UTcpstJ7uoBqSXBF0D8HFc?=
 =?iso-8859-1?Q?HKz3cMIpHtVANY7KLg+ftptljp9zsgu5tfdYFsX8zrH4U7Qi4Z+kOQc5fF?=
 =?iso-8859-1?Q?QDm2+UQ33577hfe2QHo9L6rfq3tCY2Z06F2uKGj5eoy8GT0Kx7g+TsLzjv?=
 =?iso-8859-1?Q?VuQFpSUmayxtOu7x8eUEBRHXMJ7nzhLVbtgPpJv2nxjT9tOw3xS+33TWpg?=
 =?iso-8859-1?Q?+14shGPxzYx++jTqv3a0R7fqPszwB3avtKiJs5p+i0s3mNxDamkzUQCyy+?=
 =?iso-8859-1?Q?qYiqDCP4qxo4tKIRDMxQ1hy2Svucbj9SY/9qlFTraV+fvRWC8gHt5BN6uU?=
 =?iso-8859-1?Q?MQHhXquAwUPVfsqvNZF5QK6RGfT5U9EZpAaCPg5nWH3ziJoyOsJnzMrIti?=
 =?iso-8859-1?Q?PaMMw6jlSprXNXqKpwkFwH7duoMwN37XlAqyP/NtsGR94wLL1qG72LeSFZ?=
 =?iso-8859-1?Q?qfeJByh+DUl2lBENQUMJqYzMA84u98SOkfMs1J4M0/Q8VnOL/ldNCnwVcd?=
 =?iso-8859-1?Q?chNnyBhmjKJL3SS7XESKHW4b1WQ1bse2XKT9blsFvmt0EBfwFc34gKpoc0?=
 =?iso-8859-1?Q?JgdEVeOOrxBdGxOuPUU8EEXjtPYT2j+XHo6jS5Wphh4qo0UYKL2aN+GKp0?=
 =?iso-8859-1?Q?hXVUWUQjsTyoCd14QCEyJmnM8MNw/3xzjPnzMUD16Ph4KbKSo7Isv601Y9?=
 =?iso-8859-1?Q?whULGYBS9A0kwR7NPlOHnhH+5S8T4oiMlPuvhsu3P/4g8poMcypy0YHBDR?=
 =?iso-8859-1?Q?F4HIULZFuhmTMxM5G4jEVRKhZfz2/DfK7Igqq6bVtWHPvbDe46pXkpbod1?=
 =?iso-8859-1?Q?1h76WphrO5/j6ggeXrrUta/XK/nsiOvCPbaNmKm8JCMaaw7HlXYrIqTGW9?=
 =?iso-8859-1?Q?Q2OnEQkWugYeykoRharjqbdBwoxxJE1bkNvZU5Qg8MCWj7oEQ5ioK0poKr?=
 =?iso-8859-1?Q?E3nMipPwVaSC3X4O907BoMx5JRxPvU5/HwpTmw5N1HrvAyge5TmzRKl2zz?=
 =?iso-8859-1?Q?Z7aIWA4ARAqhnDovdl0aYM9IY1anhjnux3auOe7J3l/OxCbX4uTfsnxWe7?=
 =?iso-8859-1?Q?rkLFWuQVW/JMgAck4uhnQlTnxdR051zMPUKTaXw70w/A1yz839kDFANt9Y?=
 =?iso-8859-1?Q?oCYklAMlTzTrgdCaSgp6gIPB7+clJII0at/5imbY5qgYag86UdLw2PA3kd?=
 =?iso-8859-1?Q?ec2UpuLER1biU5H1Gw01GAJsH3p9Z/yhiKMv2SfG10n8DknnFrLCPY58m+?=
 =?iso-8859-1?Q?VGqWE5BWKzv7INcUu4Z5K8m6VIppfg06p1gfnO/aN0smXE0xJacBLn0hp+?=
 =?iso-8859-1?Q?pCVjImGMgOctNJhlrr1V2EI+DTk6iD67klgMQlMqVNTQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gC8ov8v4/i4951AN9AVIcCTuHApWSD3ztNihAh3gLibnxUp+TRIjZKMMuA?=
 =?iso-8859-1?Q?VsxQK/EySMMtgNe7/24/A41uBT2LsfvpWu+G8rPDDRvsbVl5l/YEzHkpbh?=
 =?iso-8859-1?Q?8TVaZyzdbA30uYl+KNU+v3tldx9dRqeKrpgmm3zzlxPlrQaqEeDzEuetQl?=
 =?iso-8859-1?Q?MLIDl4SLcYjPq8q/YP5mkl5O96txcaT2Azv+40APYt0tpz1STTT7mTLCWQ?=
 =?iso-8859-1?Q?DPfHCERywNZ+XdnpKxHB72/2DMWnoXNHs03bDOFNuKWKtGFSHlDd8ME1Yx?=
 =?iso-8859-1?Q?QzPMCJQnrNZbU/ovD5nY1sLWhW9KCY23A/99K8am0p9zwAWfqwW9dX5uP8?=
 =?iso-8859-1?Q?u3nNFMUWI4Zf3EIbjgOdvCmdGtOHxecPyUvpmGBSvfOw+4EP2q/QvrDw9W?=
 =?iso-8859-1?Q?K0caJ2OEp9qo44irSf9QsbQU13xs79GdvmNyMCbTfuNsxKNJzn43Vidvke?=
 =?iso-8859-1?Q?aM5uiw3Hu6pWZy/oDk2NwsVHGl+AgFuOOOTdRiTTChC67CuXvesBZIj+lV?=
 =?iso-8859-1?Q?6jYiK9jsR94oSnSoradEz2oQcHw0dzu2bgeuGPvlxFYMsULRFAUwQyQ0Ew?=
 =?iso-8859-1?Q?kDEGyH1DcebIWshdMGq1uQMuQoU3xznulsqiWi69fWOjLwnvNR5rKTGgTo?=
 =?iso-8859-1?Q?01apLx0XN86dipWefNgmfm46/9iJHsvHpm4UDcxtagGNcA6fHOK+ZnNHzA?=
 =?iso-8859-1?Q?3KQ/lYjAQ4eFTfDVb7aF9lw8MbzLJIs5CUIBuTOTb8u5eZ4FjoFjV8DNFL?=
 =?iso-8859-1?Q?eTF3gqhZw1lgZn9Lkzxb2ZdHhAJrc3zl2Xzc4/Lr/5J9N8g4RbUBj6IKHZ?=
 =?iso-8859-1?Q?Jgx9sf4Nkv6TZg8+Q+p2M75BFGX41cZ/0PcyukAtbKkh58yL7AKhB0Rfez?=
 =?iso-8859-1?Q?gUrf7cHGxOW7N8EN3A5ZESOjfgnJMDya2Zo2d7OjB4//mKPVmudk57Vp/2?=
 =?iso-8859-1?Q?bdWjHQJYiV+8tWLkrubPsZ37h69SUwaaBUEXraT5q600gShv5/u7Wn2Zjx?=
 =?iso-8859-1?Q?cjrbhzS15MRFwtCBIrk/+9ZFuXGofb/KlE6ThMjdz+TjFzdYrTfRkrg0vo?=
 =?iso-8859-1?Q?GGQtadYeKNPeWeGx3hQlKCuzsWZZh9dDNt4IHIksb0qxI6HrEUbJnRGyUH?=
 =?iso-8859-1?Q?ky1ehfLAeKMbrvASL6CzTcExldAslEmeYhiOvL/1eAnZs/51VEFh8Yy1S3?=
 =?iso-8859-1?Q?i+A1UqKnJxIirNfT3lm02boaJOPLXa1mVsD0H3+xtzClaG7bEiI5Bkuui6?=
 =?iso-8859-1?Q?7p6CQAe3moAz2l2DDKoQva40+qrL2LQfVc7HxrfMfVUjQr+x6Y4IhBgME9?=
 =?iso-8859-1?Q?hxhsjzxKvq7wzc5se7dgoWBKtLlaz4+KGglThJsZAP7xHXCREVH5BssmKY?=
 =?iso-8859-1?Q?36vx+kUA7nuDw0CpsMBTP0fVDbEVmbyvOllBGEXjxXpWKVZ7BjMTUIgqYN?=
 =?iso-8859-1?Q?c0VduuQ3b7sI7IgWzMuL/Si53ofRCB6sVfHCkbk/ourtCd36s3plMhNuyU?=
 =?iso-8859-1?Q?TIm8x/OH2cfCguA3WX7KkgN1tJH9cxqywNL+jBMzvK2O914fyFj3kmRg8i?=
 =?iso-8859-1?Q?oblfmGw0Gb0WlwaAiuJ8dUE2xjtGzJ1t7bL0cJ5kmCFARkApZwtUvvAM2Q?=
 =?iso-8859-1?Q?8J3KtBxy82BA46yf+KvSE7oibHq00sp/Xy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f1eb1b-6706-4dc9-4ad8-08ddd824f9d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2025 15:45:47.8074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lhL00mTr8bxJsHwL3RZPQrYRfNZ1jtwsZOpVcCaLXKJUKNoFYylCzOaynU6UBjoRI9dGFCm7uT+5MVyR7gYOiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR14MB3516

From:=A0Jeff Layton <jlayton@kernel.org>>=A0=0A=
>On Fri, 2025-08-08 at 17:22 +0000, Charles Hedrick wrote:=0A=
>> In the past we've seen high CPU in cases where we had a very large numbe=
r of subdirectories in a directory. This was due to the cost of reconnectin=
g them.=0A=
>>=0A=
>> In a patch March 9 in Centos 9, "ovl: do not try to reconnect a disconne=
cted origin dentry", an optimization was made to avoid this, but it was onl=
y implemented for overlay. Would it make sense to do the same thing in nfsd=
?=0A=
>>=0A=
>> in nfsfs.c, it would change the call to exportfs_decode_fh_raw so that w=
hen to pass=0A=
>> exp->ex_flags & NFSEXP_NOSUBTREECHECK ? NULL : nfsd_acceptable, since nf=
sd_acceptable will always return true if NOSUBTREECHECK is set.=0A=
>=0A=
>Can that function cope with a disconnected dir dentry? Note this a=0A=
>little while later in the function:=0A=
>=0A=
>=A0 =A0 =A0 =A0 if (d_is_dir(dentry) &&=0A=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dentry->d_flags & DCACHE_=
DISCONNECTED)) {=0A=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("nfsd: find_fh_dentry returned a DI=
SCONNECTED directory: %pd2\n",=0A=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dentry);=
=0A=
>=A0 =A0 =A0 =A0 }=0A=
>=0A=
>...so I imagine such a change will make that printk pop a lot more.=0A=
=0A=
Probably not. Sorry for not checking further. There are too many uses of de=
ntry=0A=
in the nfsd code for me to check all of them. Although I can't find the cod=
e that =0A=
does it, my concern is that permission=A0checking would probably not be pos=
sible =0A=
without the full tree.=0A=
=0A=
The real performance problem is exportfs_get_name in reconnect_one. If you =
have=0A=
a directory with a very large number of subdirectories, they are in the cac=
he on=0A=
a client, but not in the dnode cache on the server, then processing all the=
 subdirectories=0A=
becomes an N**2 problem, because each subdirectory has to be looked up by a=
 linear=0A=
search in the parent. I don't know the code, so it's a bit unclear to me wh=
y the get_name=0A=
followed by lookup is done. Is it to make sure that the file is still in th=
e parent directory?=0A=
Could you do the same thing in the special case where the file is a subdire=
ctory by =0A=
checking that .. is still the parent? Unfortunately some of our users have =
exactly this pattern.=0A=
Many AI training sets have a subdirectory per item, with two things in it, =
the item and=0A=
a file of metadata.=0A=

