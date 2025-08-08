Return-Path: <linux-nfs+bounces-13514-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF748B1EDC4
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 19:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847903B147D
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2B518871F;
	Fri,  8 Aug 2025 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="rQPfNJ7a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2100.outbound.protection.outlook.com [40.107.96.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F3C35948
	for <linux-nfs@vger.kernel.org>; Fri,  8 Aug 2025 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673731; cv=fail; b=TFpWbg/7Wsrj7yRE5BSU7cnGwH7QP9eIAtGTF/OuVKJ/OWw7pT9ity2I6Wp0durDEmn0BU4gkC/1bEyK/XWQsPeB/ZsW31j9mFEl/gvodYOvWSOP5x2J7RnRJWid/aVqFo0Gy8fSXr2eYtHmiCfYN27U3DAFoD1SsfgQx281Dbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673731; c=relaxed/simple;
	bh=MMP8qWR6OGe+OJI34HvzV88JBY6pVCKGZw9s00G6D0Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mees8MRo8iIg4lnwALVGVsZ1rIirBHoC1Lv95/PoxzzYyPRTdsLhrM6bqObqUUQ1voukyXj+OMFjClInYrfGqDYsI+ebPrkGmAQQbnj5145liOyeR83IsQaKbyl6JTrlQcLhUZX+EW2D8OxRSfbTWo3i4PO1/3CUpygTflFScjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=rQPfNJ7a; arc=fail smtp.client-ip=40.107.96.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlEBvbmPnY3ka0R6R733OhIBOYqn6T9k4RyqKHNUDV7/m70eZMv13WdMZpnI7xw56vjSlbmx50MLQ3R80BG5DOCRS6Yd87F9lxRElvU8nH3sGbT5G6mvcKkkxIsiT25QLel8+GdWuau3KLI2yBpqFy/ZqOTxqgSwjYv+vbBgo2BZG3fg2NOlNuwNsApdCWijhqVap3o81/UTMtX0nHvy0ZBZ3zS+1lytsN1GfzEUs6g7/bygGg63MjzexqUrBPq44rq2EC6pCpF62djCPvQrSgjajRIk19H9WCtFTcvF3NWRnMEOckmYWFQyVM1ZiMMT1Q+voKTTOQM52SvEVgPbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMP8qWR6OGe+OJI34HvzV88JBY6pVCKGZw9s00G6D0Q=;
 b=gLxaKXuNeeHgWqfHX/QEj/o9e+/foET6FkDYfYAcyS4LZSF/NpnuYmYzGFAVw2W/nBbgnPw62WU1LDLyV8hV0ADwWI3dc21EXn3ncd/4+JE9K4C9qTULi1LsnQWLK+2IorQrdiWT0QY3g1QBNmY6eycVrJ542sUDlZAjIncqcAH+67w0OMA8uQnkFDAAYFivKX49qah8wBXHWiN4PG3yOBKK+l44v/gSg8KhiDYLBRk+MCxZ9WVguywqApw61jdijKv9xjthiAGkceSLcmrd8xkyXjaw1ZUTzsUthWCLdJ4w8Cp1dRZ/SfeekZ9w8yHB/vzERYwk+2WaD2fEmyQXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMP8qWR6OGe+OJI34HvzV88JBY6pVCKGZw9s00G6D0Q=;
 b=rQPfNJ7a/3mrIBk2hN7ft0K1f9CDT5UMXaxslx7+o0veRZ+Ijbf2QCfK61L2NneuFIBW0hwm53LztClFiP6ABXerNyEOAeohXyUKFdIbD1s8xUvn1rBGgEXDD95qkq9f8WCg+YB6JV6kl3oA58tTSAYwhQwWv4MK6MzMFFc/qYEH3wUQQ2+by8AnRuTri/yQ1GjYUvXuO4x/0JKOXl840BF1irneaaxitX34hPfJ+pe8aHFw3ujS7hMbBdFlzzKkIvktDtPDXhQwMc7N5tt6zzAfF5rqTaedPjTkZl/+4Kle9jzmS3Ko3DZ01BFx1HE9RKL68Xc9yzFQWtvY7sZLbA==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by DS0PR14MB6238.namprd14.prod.outlook.com (2603:10b6:8:13c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 17:22:06 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::c4e6:a77b:bbcc:efd4%6]) with mapi id 15.20.9009.016; Fri, 8 Aug 2025
 17:22:06 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: Linux Nfs <linux-nfs@vger.kernel.org>
Subject: possible optimization in nfsd_set_fh_dentry
Thread-Topic: possible optimization in nfsd_set_fh_dentry
Thread-Index: AQHcCIfluO6WaQU80UKvzcZGuHs8tw==
Date: Fri, 8 Aug 2025 17:22:06 +0000
Message-ID:
 <PH0PR14MB5493CE0EF511E2D827A5ADCFAA2FA@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|DS0PR14MB6238:EE_
x-ms-office365-filtering-correlation-id: 16fa7cac-5285-4c20-ed5b-08ddd6a0194d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?KGma7FVNNTiF7tSTwpeeN9ZSFJGGWZyEfXFrviYkNHsmVQFV5C68aU8527?=
 =?iso-8859-1?Q?6IgwO4FTAPt5UyY0ezIfSH/VvvbHzdwp7TmRC3F6M1xPVJLhTAgAoX/+/I?=
 =?iso-8859-1?Q?xzc3ljn3QBNia9Y6zymjSZ4cRzaRYJxNLs6tHuPfZ2xoWUxCLvGDfBFpqU?=
 =?iso-8859-1?Q?g8nXuzC27CYEPFuWfmHbhuJQ2qEAkmp8FeauEaJ4Ifggnep6XHxXWsbFhi?=
 =?iso-8859-1?Q?i5EB/xOk/yRC6VAFu4jUQTcWe2rtZFJFLSHn/lpxkpP2svxJrx5aSqheRa?=
 =?iso-8859-1?Q?OmiMWg8MIblihOw9EIoxVEziG3I3gCuuPlq3/az3MIM0SfonqJRfq4+KeG?=
 =?iso-8859-1?Q?M8GOKGo2M43pXE5tgKYpi3Rv4iyqYfylvOz1h4BHClNK/vrycUwfIlSBwB?=
 =?iso-8859-1?Q?7P1rGSJ/PPhTqKL+KlLipNHlayZnAXJ1MhzbNVQGt2zHSRzVlYG30Wtj+g?=
 =?iso-8859-1?Q?cam1Ti/qSAaTmXSs/ogwhAprhvEWUXtlMA/vaEoDRgFlePFMpEOd5GgiO0?=
 =?iso-8859-1?Q?XBvnNITookj3ty2/mWI1zoMDBt1DsPVd5UEaeq8LxTlrt+OgQQ+bfnLRya?=
 =?iso-8859-1?Q?tpZYDgHgDJ2rzqFro2O5DEUpGlsPPirLP1y6YMi2+EMT1TdeqRR1WcqnPd?=
 =?iso-8859-1?Q?gljO6a3NY0IKwtkNOIBCcR5S5eZ0eMhXrTpxbHl5v8FfjE84r6cek1Muu3?=
 =?iso-8859-1?Q?F0y5W8EZE3ncFFvlqxduR+UA0f8CBJDfiuTZ1/vQoOsP8wapKEqOv0nzuF?=
 =?iso-8859-1?Q?1wOyGtsah7BnNJY6/SMjyvWJOHvEoZS6L29agX3ZmwH4MncHaMhA9xwqhv?=
 =?iso-8859-1?Q?0FUcOrSyP9wb1eZVtDoOifNz6PTKQKppFFqNceqG4vT8LaKR+YsWspITGJ?=
 =?iso-8859-1?Q?k4shgEHbZOYkX4mNyjSbJ6HaXk2UvA3Y+s7jqQ7ZPg9XZ3H5l4moBq5P+o?=
 =?iso-8859-1?Q?rnnVFwBdMrwldVgxabdQSULvzDJqkUU0EVYawlExS8i6p/dWdBcHEMztfm?=
 =?iso-8859-1?Q?vlvAswbIqR9cT8gF7FJzHW7jf+7HSKwN2QjiveJ/gXq6bEzaPis8b9Rszu?=
 =?iso-8859-1?Q?XgI2ZVHlJRqJnHzQ+7l7yDeLNAk8Rc+CAe8eEZkmPyySQjtQZYAkPU/fgw?=
 =?iso-8859-1?Q?2AkohuzZx492VvAHCaCCZj0opsjBQYUxMn+07KnOPBug3ZY5NEf3Vwn5Kd?=
 =?iso-8859-1?Q?RKlfu0Kjnvz/HEuMSKl8Dgv8quqOC9yZzHnfT/w9OSS8sfNbHPPu2qyBhS?=
 =?iso-8859-1?Q?DiLvC4NaZ4zcc1eD4axatweQm3eDr8LA2yPFQlBd4ZYAbNVp4ie5f2AkIH?=
 =?iso-8859-1?Q?KD3IAuLRgz2W36kDzacBzEGyyJ7laKZFbltZoWfDQkEO4v8MRK716Y2ugw?=
 =?iso-8859-1?Q?AaTeX4jHBYN1EK++2NUdrtvHp1hUtIoolPy3eMRvhcRnRV103dRntePg/s?=
 =?iso-8859-1?Q?9+soDJTwiUJv29okeHxR4ihc+Fz0ZekbRUYD3Rs1o7CSHiFMQw+JBUsH0Y?=
 =?iso-8859-1?Q?/VvZAnDJSLIU8YvN/AHGa+EORtNtxDxzLpW8dFv7hzsw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?M0itsSxuRjXsdTqY7mTHPR3Oh7rvD/HqUY5RUCOXySMerNHn4f9oIDVOcW?=
 =?iso-8859-1?Q?wfLK+8nh6YHs2i6x0/B5yQeAcVbfHNUkjqSyNIvXKiFa8F1OTx1Jvlbd1W?=
 =?iso-8859-1?Q?8LebQTZkMzCpYJU2F5Bm86qw6f02tcU7sATNRpwN/BXBRGkA8KIGyYnerO?=
 =?iso-8859-1?Q?s7DBAnPr/zf6YhbZiytarweSLerI8aYGNIlRpenKsa1ggzsEM4xPSS7EID?=
 =?iso-8859-1?Q?ETz5cY0AQZQ1f83vbnvjIWzbeqJdiZyIvpJaDdhoMj3ljXQ8uSLqr+NP33?=
 =?iso-8859-1?Q?S5vqVWNPKVWZOvHAf5zJz7x/35FnQzGJ3QnzIDlRnNUZqSB+MyA9usRKR6?=
 =?iso-8859-1?Q?BVtfsKOnYLOueM2g9/dPB2cNTUn4bPxmdqLkMP5hg1jtQYzeJzJznbp9Sa?=
 =?iso-8859-1?Q?8RVo224shzyGm1nZHt0rugXZ/1WkhYNxMKTD679/5JOZhVpltnziaJFBBo?=
 =?iso-8859-1?Q?CqAhanAUsfUnq2viU86/z9ufZzbhcBJrwXx8XsicZC+Z2GvObypo9dtA3N?=
 =?iso-8859-1?Q?XJU5rlFZE67GdPtU9cYfxCuQAbd8Qf38tjNcfR0f3A7Goa/bTaObBhwLdg?=
 =?iso-8859-1?Q?QuhCGJnpkMiII8JbK6j+JhWu15ddDjLjbMmx+U+1t30f3pCtqfimRZX2XP?=
 =?iso-8859-1?Q?x9RCS0bM+LL8LMiweeFDPzmGNu8Eype3A/afiRwwrcaQHsrc3h5u005hO/?=
 =?iso-8859-1?Q?oTkUU5juEU4bloT0QK1FEnLWl3ZCAZvafYZIAvVuZHyWVXBMx0ykGaJBwa?=
 =?iso-8859-1?Q?nWQWg4Oj6ovjX3MSTuJGvxi/XDbbhMQLURgQdo5U4b9zzxBtcpDF/lhcee?=
 =?iso-8859-1?Q?+Tonq+0q2sX1rmSoeNC9X+FaZI3dZSTRGcpI8tzSVKR5bv+4/KBPECzbmm?=
 =?iso-8859-1?Q?0r+/W9RI8rnm2b1sB1HvOlqqeXDn1HBK3niqFKmvPLZZTlkFiDWwDBaVy7?=
 =?iso-8859-1?Q?NUa4hNIJosYUlACN2SZB54dO/eKS0UVd45AOJ1olnLSwr5HfMvzLxlRRDh?=
 =?iso-8859-1?Q?HKxR1lLJS0+ayFugBlW+K3CrSygc0xS6jO+acboQi3djX+EapYo5tEbRls?=
 =?iso-8859-1?Q?95SrXHtTBMSIY05iJOFRQqK9cVdt7E2M3kRmnosmffXkvAjH0vXzCq0yIj?=
 =?iso-8859-1?Q?cO8XU3T4McTTYw+GbqGqZ+V/dI11+jXNFHGnZ6GsrbsOEfWrwBJrVN4ZUS?=
 =?iso-8859-1?Q?KYdgtHOmT9748K5Q+egNMUsF5FuGUQhRnq9GmayajgMQg3+P8hFz3sPIp5?=
 =?iso-8859-1?Q?hovWwWNaAJjFKdPG4V3vpIiETU7ox6fyjGKG1z0iVYtTQ3xqrc2S/1wy91?=
 =?iso-8859-1?Q?lENATwXb9UYP5OcDruq5gp3uuBsURsmsC2k/XPpgWvaGWlkabr6piFQkrX?=
 =?iso-8859-1?Q?CpRJyX9OtVM4zZAx3uVu//hCB6iXQXWQ1pFSr6qkumMngT1cfxGnKZ4m0J?=
 =?iso-8859-1?Q?Oc33fjRWxCD3hur4bmus6e41ZRStmAvmF3A9rAQJgmmc36Ew9ZYFJSyeuP?=
 =?iso-8859-1?Q?42l1eh4H9SXluBywL3iCyoMnF70IyWRoiBamN+k2UAZ6XQxNypTSC0vFkA?=
 =?iso-8859-1?Q?FVBz44VoAqOqPGUzxsYCvfPF5u7iegvPGTpeyxcaJSOQ5zLkRkIndf/xN8?=
 =?iso-8859-1?Q?bX3pcUPvo6KsvzPbQpYaN5Hnb5iUbUFclA/iZxEgVZ/feY4Hsw1Xvopw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fa7cac-5285-4c20-ed5b-08ddd6a0194d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 17:22:06.3547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oG1oJ/p5HaGoL+rC7iCYYZkWTcm5qnRIYHilFJijHv0jYLA0T3dN6ILd1Zmi7xKZVkF98Nlhhnb0Gc9vWdx0sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR14MB6238

In the past we've seen high CPU in cases where we had a very large number o=
f subdirectories in a directory. This was due to the cost of reconnecting t=
hem.=0A=
=0A=
In a patch March 9 in Centos 9, "ovl: do not try to reconnect a disconnecte=
d origin dentry", an optimization was made to avoid this, but it was only i=
mplemented for overlay. Would it make sense to do the same thing in nfsd?=
=0A=
=0A=
in nfsfs.c, it would change the call to exportfs_decode_fh_raw so that when=
 to pass=0A=
exp->ex_flags & NFSEXP_NOSUBTREECHECK ? NULL : nfsd_acceptable, since nfsd_=
acceptable will always return true if NOSUBTREECHECK is set.=0A=

