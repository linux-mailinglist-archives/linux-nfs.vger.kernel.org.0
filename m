Return-Path: <linux-nfs+bounces-1280-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 673788377A8
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 00:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0481F252B6
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 23:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897AF4CB44;
	Mon, 22 Jan 2024 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S5z6sZPQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oer0nuUF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A914CB3B;
	Mon, 22 Jan 2024 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965657; cv=fail; b=pSKxx6PiLd+4NWphyvrJZPICMdT3KNfVT95rfn+SvdX4fPTj4QE3Q19nzZweARmaa4RPwyqyAAHqgrBg/ku0lsjvQrpVzOq4TWUcJVgpz8Sipk1UQElfWyx06ITyL2blNKHctIKD6e9m7/qk9PxKStsQgDQ8T95tWaBzsI9c6uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965657; c=relaxed/simple;
	bh=n6uX3HggcWyvCtBT6epKxfK4geM7SfS67OIb6Xd67bA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Kc8zpGQICOTiCEXjx7IgbmacYvQ9vhCoD7EVhT2PCqZJtzJgP6sr3gB0/HecMz1tG/0lO/Wzby2GiM1T2FrQbvet/NbP34NQ7tSav+3fHfXQXMryWwk/UchSRQjsP+nt0vdgQhP2wygtxyuDnhs1VD8tXMBW4YrpuAdaQqhtOBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S5z6sZPQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oer0nuUF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MMoxG3026751;
	Mon, 22 Jan 2024 23:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=n6uX3HggcWyvCtBT6epKxfK4geM7SfS67OIb6Xd67bA=;
 b=S5z6sZPQTttIIltH5iF8KGs1LlEJUXUeUo28GjfAgF/nHiR67RI1h8kP9doB4KFnAhff
 HoTy1Nssp6eVt9vQJQ0WclXiqGVnjsUWz+rB0voVukWdTmCafZPLPAv0n1RA3Uj+rVQv
 qkPco+K+b4xoQ92M0dJ8dTt2wnEtAMUHcwsDcrTF3AIU9VGH0by+ixhRYeiIasrk03xC
 cIRUgaXnnJgeH7XXD5BbyGsOOX+tofav2HxB2+RwT3iuQdms9tXxciTcHCkpa0+Xl/EF
 wmTjRUz06Ar6eklnnJDMQI/eIgRZPSP5JKirglN92kdDUO36JvNmbZA3wXNNU6zofOBp Uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7anmx0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 23:20:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MN3Y71013094;
	Mon, 22 Jan 2024 23:20:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs36yxran-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 23:20:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnymSUO5zRDpwd5rengELy5yoydivwJ5LBifCseVlTp6KAUfuXY5VCNAMTVNiXYVtnV6pzQYm2FNUEy+QBVUFjyfscXzgE8ooAVeTPGM0eclpZ4Qah3qiWLXepuw6TAKJiKOe1eAaDLDahzWOxJC4SnUTwnOUuu9BKrgo7ByLInaOhNe28je9GkW2qRMafEEJ9M1LfQ7Ll1tLaGQJWzd1Doajub+ZRZEGjXELWjHPOwXSjt02DGecT4UT3D7ikQatf+d3Tbdg8Pkl80z3lojAcBPZVI+f37RC8Qe0z7fPCsNRxXT/1eOWHYOJI+Cgr7UQoaw7YcRCpP7XtZl2Hk57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6uX3HggcWyvCtBT6epKxfK4geM7SfS67OIb6Xd67bA=;
 b=nSwRq9KUlXHT1xN3UYhhh3Y0gTDCY4mPlRa2PzDnx5sN7nJ0oPsd/1uwTYwbcWurwKPKflHNirdeD4qyRy8yI3mDPdEd3Sua1jSoNNh7sJYnTI4kuR8tiPxr0dj17wihNy8oHV3m4LEzpYOttHfbl3C7AMr+w5WmKOMGuKDucX1gD5hvbJLSUvHkSTXOVe4Cog3qFHkDHj1YiT8lyKKNKoYLRa+T7rXhbUOFPMmfTf2yEaqLZztefOysGYAlsiZfk+wgp793M3o5Fayb8j6LDJWbvk72yOYmi1W0p72EdBUtD9VYCBloQ2MgVlQmLPq3RSXxZvnFca/6ZQlqSDZ/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6uX3HggcWyvCtBT6epKxfK4geM7SfS67OIb6Xd67bA=;
 b=oer0nuUFha9SxC7iD9hytY+Wf6d4HIV1M4pDgmUlgEiebl4gYgj2k3z2GEcjE1ZAEThprDFprFcMI895zNiHVpbyXKnMN0RhmTZuOZwGWvU/+2fr9jmx7lPkYXUrgHor1Um0sGdpXyG21y6ObsxAzXai2ddyY3bjs7XbSVnQKPY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7270.namprd10.prod.outlook.com (2603:10b6:8:f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 23:20:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%6]) with mapi id 15.20.7202.035; Mon, 22 Jan 2024
 23:20:46 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: linux-stable <stable@vger.kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown
	<neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
Subject: Revert ef481b262bba
Thread-Topic: Revert ef481b262bba
Thread-Index: AQHaTYmg/9jZCkb0z0uO+aYMtdHU+g==
Date: Mon, 22 Jan 2024 23:20:46 +0000
Message-ID: <6EE7E263-F099-4E6E-99B6-C531D33C26CF@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7270:EE_
x-ms-office365-filtering-correlation-id: c7d861b7-5743-4c9b-ef23-08dc1ba0c323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FlcrhyzmUXmE9swA9XrAisRvpUolb/G+4JobDcxJBILt6HpSPkzdsI7nqIcLosXbSsL4QX+v8XffbVBrNc+bzDw7oV4VyT+cdnODnwf5K6eyFhVuG32TQNAF4VGPozBf2LKGtbYeYfyr1ayy28vaVU/8MJfGUclo8jYb3MMzijuvy6hhE3vRwxYZVM/4dzqSBux+FeaCsSEF56uZ/O2rifvDUE762foVAQbokBZxsFOuiwYASDphWvQjHDXXet67xjUItGl6zfVUkDRfCh7Ce0cS1c30bHQZeY6EE5jjAFxS9Qf5dvuzQpA8sR5REb++Fk8e59t7pJ4e1CXBJNCUfTc8onKWoO/B1lf4oedgLi6R19AvUBCPxGND654SJMmspb8ctyF5oj+z5rXmj++pUoZz3I+9CsMyHSNNDFfsohkW5BhZdlhQe1b9qVIxrg3XVsYCROc07HDFD6Q0vXcBTh1+PJff/RNBY8n3qUlqEOAgXnkV2fHuY0LpXDKOlhyonc2zT4WKful4k3lusBw4N8GS4be+X4xyd7+D8nX0zFdQynnVRI9lfM344t6rjnmZZJU3pmO9xUpzMKsEfezM05UqRv6ELLloqCmzhF2Tl02loIpvPohc+qxJVesBZQWfS+vl5qyS0LH6k1oGHazkGA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(122000001)(38100700002)(33656002)(38070700009)(36756003)(86362001)(83380400001)(26005)(2616005)(316002)(66946007)(66556008)(76116006)(8936002)(8676002)(66476007)(6512007)(6506007)(966005)(478600001)(6916009)(54906003)(66446008)(64756008)(91956017)(71200400001)(6486002)(558084003)(2906002)(41300700001)(4326008)(5660300002)(7116003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?f8eMbHtMNoGRFoi+kNqMWjCGCjnz7GFf2PVvdH0AWdneBt50ZIPFqKiSyQpc?=
 =?us-ascii?Q?KZ7twpMpv1PfzHHZEN4vXci5DOxEqT/EeKRjwgLVarJJUmEm7/ZdLbkRLir+?=
 =?us-ascii?Q?gf7TZU7yYZlC4USwuoXovhgQ58wSMVU67XXQCgeO+ATqmmm4IEYlD1rBwjND?=
 =?us-ascii?Q?O2nxWh2ByLcxlrJ7So77OlmgDUH4cCnwyayeGq0BI5hz0ylpsgIdam4OT5fY?=
 =?us-ascii?Q?HmPKwt710Y83TkFguYnj0zl8JSee7wn8+bQdyzailfbHi2tUBzlCBeMWUhEH?=
 =?us-ascii?Q?7xyeqSYIMpST2I1jYUgFyC7KCGAepT5qLcdpg29++sOTbYZCC0OoGobxnoEG?=
 =?us-ascii?Q?8WMjCWn36uUkrRV2z0YvYNDPQ9TDP2VcC5IMUMOeXfj17BlM0IzY1TeaA+uW?=
 =?us-ascii?Q?+qFAKKP4ZHJpyeSESkZ3qePav7DWrm7s5Ypuyr5RjH2MUzT0yIBmlqxw7lFF?=
 =?us-ascii?Q?dh9uJDfc5PldI8GSbgSKqcLCAu9cBTBXfxEfKXA6uaVfhppGfnNVz7DfcdtE?=
 =?us-ascii?Q?7utfgvmOo4LcOqsQwPhou+RW4dlCzci1DUuCBwaT71xie8bZB+nNoXubrYJ5?=
 =?us-ascii?Q?KA+qFRWZFud3IjqhYKDzq39yN7ym36cE94ahh2TFSfEm4JelxS3+60VtAppF?=
 =?us-ascii?Q?fZf1Oamv9OrorNMqG38mbVPvz4mWCsu/ek8nMaOlpXRYqa9FJ83Ao3NwaW3N?=
 =?us-ascii?Q?vDm/mGmtcpsPgG5T9WrfSLEOagSQTWuJev0f9K5V9GMY4742cU2Np4fmU0L8?=
 =?us-ascii?Q?kHi1/lBiL2hqK3hn+p7rgtaMBNSn0cQQdtlhMnuuv4ZX5S3iIMspZ8HTnh7r?=
 =?us-ascii?Q?tIsdQsIODr4JM8WqBgvoOYxFVFr1870gDfq4mCZDm1J5Ttqr3TVSpbU6V1YW?=
 =?us-ascii?Q?HSw98BGt6ztzfF1MNDA+G5uDOvoHfLx7BNIPifjbngbdTbzmtDh9LOXmzr9F?=
 =?us-ascii?Q?YjvcCZrR54tsSsCkhsfmy82R3OVRHnMRhCNbnRNj/n8Gyn+a3GEcYm2M3QFn?=
 =?us-ascii?Q?eXhGpuNxQC5dlkB1GP7is9sW0C3xY5bxgxq8mUdRLZhA3dwDO1IIhmFjAMev?=
 =?us-ascii?Q?8e6fcoS9HO4+ozUUCHvV/IZehq1W185LEnakRPgcFLquony4WuEqo2uIt0Y+?=
 =?us-ascii?Q?dr2Fawe/YkJ4TNhxUwSga9CcGgTnNUKMXVaJ5r/UfTaCmKEcpLiE7/47f9DK?=
 =?us-ascii?Q?/TQ1t+oH3boQHN6IanAsi6y5QVWmZASZGHdmdAniIYnQXVHbGBM3b2Lq/3ka?=
 =?us-ascii?Q?30L6lJ/Ee/7FDN6NFDgpAgICijOvoZyn3badcjtw/e4nic8QBGm298Fygt17?=
 =?us-ascii?Q?8YFPPOAZCLv09SYJ7n4+7FH2wHTt659j98j4LMtE+BoAGQNsGCKDGtjt0ju+?=
 =?us-ascii?Q?XsTVV/G5o+A4KrxUYVaU3OzgtvWpnVGzu7eJCKdy15fYZRqxv0kTSNJVs1Ge?=
 =?us-ascii?Q?X/lU/SVo2hC3H9xDMn9WdlNnElcahvB9lyQq+6AdWvvHkHsDCvIz5zpC8GNY?=
 =?us-ascii?Q?H9G2aLyoIqWpfMm3mS0057vfd/nCnJzWNfumcqkwUKaOxQFRPcKItlARLDh7?=
 =?us-ascii?Q?yK95B5Q8oO9fZ9WfSLCZCvVJBSvgwBe+a8lLkCveqHjv+Ot2QmwgQSoIT5Pi?=
 =?us-ascii?Q?aQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BAF494219AFA14BA780B583CAC0B67F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aquBFJ7lWQlgJM/KlFrkfusQ1x+/AQgGkq2kloVjdZ1q0ILhcIriX9oBvi43JcZc6CFe7OYXVS24U2Z9z9oJsPjQRqAW0k1NCjr501wph3mTC9AUUh8wKh/mB1jib5sZZ1qIxNr67TzO0QQ4zdqjVIszk+BaO5FLQ0hK8rJIsx/QECT4/DnXUnloz56ZJcuqUhKtiWCJiyiCZ/Bs9qemQ9gf1ICPQZJU741t/LPIw/efswRmuELqxiwQZoNAdBy+0HrWCYLPxAuPDG4xhgjBwxsVUbdPagb0HP1qE6Eta64Xtm91EmIqMWLiH0+Frd8OzpYy4tXeCM0RuP2ZhgE+5Kj8nai+XZALYcwMBF8d2YhubKY5XmU0YrQQx4QCaCEMw7g18T1mMk4Sxay25eF7cR/JU5mQ01PSaLwFJbl8fflk3XNyZyZh3E7h2SUFiM2Jvc2uS8drOedQvMrOtjCoNFIJTfYyfrZqmXZGwY1CfFFTh9sNibR7aVt4f9GD3k5IR6dj2jr3srYYwikTbdDXSLM3Suvi9L/AS0uxQDdyW/9a6uo2Nn89WXKi0QLwm9BszvbyNKuJgF4ukFoy+xq8YtPvB7GkFD3idOYub5NtZrs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d861b7-5743-4c9b-ef23-08dc1ba0c323
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 23:20:46.2352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2jPJKvnsKmyHDrzON3+ro1nop2XK4eq5H4FZvLf+dkOt1x29AqHT3ffTQhYiRqp+Zcg93lYbEUYLuJf1JsrjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=896 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220167
X-Proofpoint-GUID: hAIQDst_wJZrJFiK3-Dw5J2DB9daC-5n
X-Proofpoint-ORIG-GUID: hAIQDst_wJZrJFiK3-Dw5J2DB9daC-5n

Hello -

Neil Brown has asked that

ef481b262bba ("NFSD: Fix possible sleep during nfsd4_release_lockowner()")

be reverted from origin/linux-4.19.y

See: https://lore.kernel.org/linux-nfs/3162C5BC-8E7C-4A9A-815C-09297B56FA17=
@oracle.com/T/#t


--
Chuck Lever



