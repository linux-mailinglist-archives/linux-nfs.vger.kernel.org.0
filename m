Return-Path: <linux-nfs+bounces-2279-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E683487A141
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Mar 2024 03:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DC21F21AAC
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Mar 2024 02:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26A3B652;
	Wed, 13 Mar 2024 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="YvW5ePk5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2128.outbound.protection.outlook.com [40.107.100.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E48B8C1E
	for <linux-nfs@vger.kernel.org>; Wed, 13 Mar 2024 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295373; cv=fail; b=OGWk2qyJV0rYp3wooTVvvGRjMB+3vRlFHarBmyDZYoswCJFL6gXDc8WDbekrHNVCr+dIZwvrndtSw8rz5i8U+bnmN/gbw0zcMjklRUTwBAa3hukT1yv0c0iWrNB3aSuWBq6VeFsZpE5vY2bApv0Vcnx3eFRIddES3FoVoaZbOXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295373; c=relaxed/simple;
	bh=JEdcjg/i2JVl7e9H+yYxJSQxPFN9U8MElDTd9V9+L5U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E2vrwqQAqXD1yn6C5FEUfzET8YrArrooT9kidjaZJYUh4kH18qzNi7abp6HrpwoFBAfkpKLIvpEhOqLkV2PfSN1qJFWD5q3LTMerAEGG4tCqGUizOcLH4q3NOPiWjUp4QygFQtov/988ev/v89uV/YmeuVo0fSrKWuYqrXvNRwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=YvW5ePk5; arc=fail smtp.client-ip=40.107.100.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEAxnHr6/jIoZcdGyF6dJO/uombJebGrhQZlqwfJBrf9JYqGFLDvW/9cKvlHYuNbWETDTXAqwLDgremMieJqTeqfDdvPuH4fCJHQZuB88A5HOzN0777/FtzimkRth5t0vuRMErI1P3m8akZM/lgi8ZxycgS+k9UpEZuSmqp72fa+6qWYfQz5kgXSdbCYhh+AKKAb87BsQfeZ4i5cHQR28ddWhqnlPTB/h9Nun2m/Zl4O/Q/GTjcNC/Wz7EHHVK5bS+Bexyc3AEC71YvDTsd7yueyw+Z7Y+gE260KrVbfpL5Axaw+Ey8dkAZKHdiWV4ho+29738hWDnZEXAZNUFahgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEdcjg/i2JVl7e9H+yYxJSQxPFN9U8MElDTd9V9+L5U=;
 b=VlyZfNUW5geHRWheNOtg6bq+EjTeQA/nrKpNKDk7Iwq1ezw8lWSABJdqPBZtRxGmbzfokhFTZyhA+n9Arxof0VaD6fqnGIGxrPw9P92M5hLfYrqoc3Or9wr+3k9Cqoo3nxt4HX+jqQx0WCL23PQCvwHHkdOmMw4aqvraSgX85sY+ieC98TNRJZuRHSLpzcoGxI89aZNpTm5Yn4bJjQt3Cq/oSnEJ62zsceBiaCX8ygw+ig4XkPoc3BwD4+1eoVOIJo1mvkGGox7qe7CxEmi6aSM6VV7H+Adnfiysi4t3dv0dfEmMrXKgACQtwEF+ph/wJNyD9RIeC3+vx7GuzuSSKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEdcjg/i2JVl7e9H+yYxJSQxPFN9U8MElDTd9V9+L5U=;
 b=YvW5ePk5gGKCpKMzhO19G3SWoxl+crU+rAXx5L7aNtFQL7B1jmGTUL1cBroBkwagA2Xql/6SxTlDz5IVYtHSZjH65Lhz8Ta332AbRr/wX91aR7cFop0ldE85kpMzUOVfhmodYMnVrWNATvz3UNjeGgUTNRFtlAK0T5i3PHB7CymHah8LXtzMMIrKSIbZQRPe48AhQREpbgENF1FzhXWrKm/SS6n20mvH0YRZ+xO0s47ZJbVEwRgMapyrshPdplU0m7OxrOVBGAF5hz//DkJzGSjwwVJluSd3O4ePnnukhGp2ve+lrSBzI9I5O5UJ3L+95aJBwmdBm94mfm+5CM622g==
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by BL0PR14MB3538.namprd14.prod.outlook.com (2603:10b6:208:1c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 02:02:49 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::ae8e:c5ab:50fb:ed4b]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::ae8e:c5ab:50fb:ed4b%3]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 02:02:49 +0000
From: Charles Hedrick <hedrick@rutgers.edu>
To: Dan Shelton <dan.f.shelton@gmail.com>, Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.2 ACL inheritance, examples, and who does do it?
Thread-Topic: NFSv4.2 ACL inheritance, examples, and who does do it?
Thread-Index: AQHadMrJ1EiJXi3AJUeVIUmbgWEPFLE06zQA
Date: Wed, 13 Mar 2024 02:02:49 +0000
Message-ID:
 <PH0PR14MB5493637660D2D939469DB238AA2A2@PH0PR14MB5493.namprd14.prod.outlook.com>
References:
 <CAAvCNcDTkCfi_r7k5h7S3Vnb_FqtY+FFc8hNnEYTiUga-Sd2Uw@mail.gmail.com>
In-Reply-To:
 <CAAvCNcDTkCfi_r7k5h7S3Vnb_FqtY+FFc8hNnEYTiUga-Sd2Uw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|BL0PR14MB3538:EE_
x-ms-office365-filtering-correlation-id: 3ec7a8b8-a87f-419c-8d82-08dc4301af76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 E3gW4/gp2re/v6Yh3683kKd1FqJLCedvbCpeQ0nQH2sONFF19MyjEiVSjD5LJz54x+7X67Lxfq5Be2zNk3wHOx3UveOQ+qpvDBmF2GYb/MQ2on1rq5WBBb6y6bznIy3wkI4n5MkKPCVP7YP4rAnD6JgaCKBBZx9gXrHjlMP9HtgQ6Ww88AH0s8FXcZH+djoTAtiuAYV8lNS7sTzCQGdQI8poBFWp/stBJHc17gPofJZVJDt9FN+HbvWOn/U023XwygvM7jUjNkszSuYkZ/htiPw/PJvWzv+epwVQ2+SYnZi2Yk6Y6qsvQu5Rat0OfH3HyZufMY18IAHpPc8l1cGRxrvFgWnPdLv594P/MkJGm6NEBmsd7rth5ZJ1ZDy4/439X+B5dOwUrUYoHLDzmAKBXZWgXH440uHMCK7dUziUiZ16J/VoG1j4BgUDMboAkGxiBPC4HsV/VF4WWf779nxaVOM8WNFMdmEuv05mKE3UVJvcfMM39cSsIJYK4gUx0NEOHQ6MN+S4FAxtPm3F5bvXuhmbZEwNiywi4XHDwc8j1W/i5YaqbZxQhkvVuchyK9cdP29O4bsyCN7KyWj7rT8sUfxu2UkyW6diZgNgkB7AW8RhC2yifCLsJl7PLpC/HgWXXFt78xaETK6uMTbnjGHCfoABSEcMR79oNrUMagqngstL74d01LAFnU5JAXc1GPTsaeM0thQTo5bZyL1Bj9eCUTH2NbLKcPGRXVcXpEU+mhI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PG5CySdxshF+QRgMkMOTOV9ZSS0YaeXrsQTvLtts5VKVDT7vbLB1K661qa?=
 =?iso-8859-1?Q?QlHZbYLXwW/KSd1E8FSfQaa19DHRC9OLGj1soWxhHiGPNGIdf7DONOeQIc?=
 =?iso-8859-1?Q?OmqPAGDvwheULPG4rKZY+h/6KZmA65969/xagP7JCmGL1fCJyoEDJ2a2Qi?=
 =?iso-8859-1?Q?w/N/TFj8lblGH0saG590fOlAkgZOOat0aVGq2GR18OE5Wu+S98GndQzt8v?=
 =?iso-8859-1?Q?c2RZyDIh4GGfetvqc+zwxm+RWK5V6HZqCIWq0kVNKyBeel2HVPGve2gKJv?=
 =?iso-8859-1?Q?oKUdsoC6bOHnjoPCnZwOhYL4gBypNM/6ZmVeVmuiwV5mgreb3wV6AjY+wG?=
 =?iso-8859-1?Q?nmVE1xg7ImGzhSd7NvRxGR+v+mF/yfEKyFQmRwCga/vbiFlGM5+cqCyBMl?=
 =?iso-8859-1?Q?oImTPF8y2XQCuxXvkus4jDYKbKAqUBfNJNRJgiywpQzbbKYVobsZd16Sbi?=
 =?iso-8859-1?Q?pGBBl+gM3h6/DDkrbTfJyai84B1CisSYU2LywQ2dUKEBlcmbQWe/AAMgbI?=
 =?iso-8859-1?Q?u+7I1tx+m+Fuy59xXvbVVlgVnvmKH2GrSlUAVChdYAHxlbYoYoI+ZU3NsN?=
 =?iso-8859-1?Q?LY1RSwTtwPEnHhH0gHETDW6qGCRWJzETzsT1rBW9eypgs71Uzri9ymHADU?=
 =?iso-8859-1?Q?SJqi1dZbk/ouY2GyWVFGxtC9LhVLIRcjR+JIZhxS4dokWK828mPRygIjKI?=
 =?iso-8859-1?Q?WAAJgcjKeTrk4J/YnHAtut5cgm6pZ3QwRysRm75drsorKfIygIxTnKYyY+?=
 =?iso-8859-1?Q?+giQXctMiDrKdIRwEQqWVQM3I1hP4wh6k4BSX3t8uz4rF3g8c0/1+WWYCb?=
 =?iso-8859-1?Q?RPstURsyPpHGrv0JMbBzsynkRPXgW1T7GNHn1e4wQs5rYeWdG05R0oO3dV?=
 =?iso-8859-1?Q?H6HDsHeS85laRoxvwny30OA7fx2dlssq89d/Epz93nzWVKKcQCx+GwV4Gw?=
 =?iso-8859-1?Q?yVYDJLXhp5RCZZ8F32nery9i7KmSbf3XP1g4au+M7zKhRSYCD5PA0IfTvV?=
 =?iso-8859-1?Q?LNKM4sBfLl3AXyh3NRvUfbXFXLs6zuhERNqaSG9iK4pcSNiUyB56iYJ7zQ?=
 =?iso-8859-1?Q?LBSZEYkXqakiwg5y3XsMQhBAe/KBE/hekOwiue1Elw5nFIlfDLXORMwYyH?=
 =?iso-8859-1?Q?wTJljTdeYo1kOHMuO/+d/d0MuuudVdX5yOAH9u9FVIaBFq/wlQAOBzO4N7?=
 =?iso-8859-1?Q?RE4Y8WPSnULlOYScApf5VFClYERzPmKzkzjGgYoHQ61P3kUAaxS3fgKcvU?=
 =?iso-8859-1?Q?DuD/dw0Qspx97t1sPnS53Ewx7owU/60wa9VRA7pVJskDpU076C3Oc7rZ89?=
 =?iso-8859-1?Q?gaoDzBz1KtP4VMXj8ZktvVIRRl3K5F3Ir3/bWlpcEnDqB//+nI6Z6XUhXa?=
 =?iso-8859-1?Q?sdhcOXJiPL8inE3F8qeLc3R6XsISlE307I3hQW5SQ1AlPKbeDCd2rWM8ea?=
 =?iso-8859-1?Q?M7yQ4bY6zoN02xE4feSu5IKzfAmOIJ5A+MMkA0shhhINMKKxuQEbH0zBgV?=
 =?iso-8859-1?Q?FOhw3kpNdKZFX57Rx5w2eNvsyJcVkW5QjSUvhHL80CQQmPG0cqkbp6cDc+?=
 =?iso-8859-1?Q?SkAt2Bas5PYJ7YH2yj7NcwgGWj/crosEPICGIYHY6cp9k1VyvCmGO3gxmc?=
 =?iso-8859-1?Q?6Fk0UuSRQPZO9e0+kZwapMc2iRUV+pSiay?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec7a8b8-a87f-419c-8d82-08dc4301af76
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 02:02:49.7137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uk+LzOu1HD8hE+DYKzac5CXFzoUDVDNu4tAEWwWnn/XtAZK3VlZOX0E7z08rkPXwGjC0G/5IjY4Yh92+5//FRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR14MB3538

here's a directory set up to be read-write by a group with all files and su=
bdirectories the same=0A=
=0A=
The directory is drwxrws---=0A=
=0A=
Here's the NFSv4 ACL:=0A=
=0A=
A::OWNER@:rwaDxtTcCy=0A=
A::GROUP@:rwaDxtcy=0A=
A::EVERYONE@:tcy=0A=
A:fdi:OWNER@:rwaDxtTcCy=0A=
A:fdi:GROUP@:rwaDxtcy=0A=
A:fdi:EVERYONE@:tcy=0A=
=0A=
Of course you wouldn't set it that way. nfs4_setfacl understands RWX as a m=
acro for all those bits.=A0=0A=
=0A=
On the server it's a Posix ACL. Here it is:=0A=
=0A=
# file: big/main/projects/xxx=0A=
# owner: xxx=0A=
# group: xxx=0A=
# flags: -s-=0A=
user::rwx=0A=
group::rwx=0A=
other::---=0A=
default:user::rwx=0A=
default:group::rwx=0A=
default:mask::rwx=0A=
default:other::---=0A=
=0A=
In fact in this case I set it on the server with setfacl, but it shouldn't =
matter.=0A=
=0A=
The inheritance is done by the server for NFS v4.2. 4.0 and 4.1 don't quite=
 work, because some key information isn't sent to the server.=0A=
=0A=
On Linux, NFS v3 actually works. You can use setfacl on the client. The inh=
erited properties are set by the client with an extra NFS set attribute cal=
l, because the NFS v3 protocol doesn't send enough information for the serv=
er to do it.=0A=
=0A=
There's a problem. If users create new files and subdirectories they get th=
e right permissions. But if they copy files from somewhere else, the cp com=
mand preserves the permissions pf the source file, ignoring the defaults. G=
iven how people actually use Linux this makes default permissions less usef=
ul than you'd expect.=0A=
=0A=
------------------=0A=
From:=A0Dan Shelton <dan.f.shelton@gmail.com>=0A=
Sent:=A0Tuesday, March 12, 2024 6:14 PM=0A=
To:=A0Linux NFS Mailing List <linux-nfs@vger.kernel.org>=0A=
Subject:=A0NFSv4.2 ACL inheritance, examples, and who does do it?=0A=
=A0=0A=
Hello!=0A=
=0A=
1. Can someone give an example how NFSv4.2 ACL inheritance should=0A=
work, e.g. multiple usage examples, for inheriting user access bits=0A=
and multiple groups access bits set for a dir, and inherited by new=0A=
files and dirs.=0A=
=0A=
2. Who does the inheriting for new files and new dirs - the NFSv4.2=0A=
server, or the NFSv4.2 client?=0A=
=0A=
Dan=0A=
--=0A=
Dan Shelton - Cluster Specialist Win/Lin/Bsd=0A=
=0A=

