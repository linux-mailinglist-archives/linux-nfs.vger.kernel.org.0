Return-Path: <linux-nfs+bounces-10580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6363FA5E865
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 00:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CF71745BD
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Mar 2025 23:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837E31EB5D5;
	Wed, 12 Mar 2025 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnal.gov header.i=@fnal.gov header.b="ol6G27aQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CH1PR09CU001.outbound.protection.outlook.com (mail-northcentralusazon11011015.outbound.protection.outlook.com [40.107.199.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095E1DE882
	for <linux-nfs@vger.kernel.org>; Wed, 12 Mar 2025 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.199.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741822180; cv=fail; b=GutkqdvyLgAWmYvG2XZdyl9hwyohhwsLXWIe+t/q0heC7ndeaoWNoVvg5JTH8iWByeMJyO5spvZOEUuMmbAaxo2Iq+sY6vWRqlCH4NRKxARLbaNW6S1whFlYITERuHmP/yc85DXFx4lDahPS+NrlAbi/+2HwQ8EKrm1txljViHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741822180; c=relaxed/simple;
	bh=eDoHPs+OIFQowa9+Iqg4WJWeIAJ64aORuzxibqObwHs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kS7vJyC8y1Dy3zpNLaqLMnTXQ9lQ9/3I/ZPLhRh7N8o80DElaZOH25EylpfPHpBGWNyTjUIYHTEYO5r94/i4b0TU1ha1k/glBNZrE895loI/Hkt2THEZlsXPwmEqJliWEuRCpMdWEA2eo88+M7leDE1XpSKW+PyszcuwJs7SNRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fnal.gov; spf=pass smtp.mailfrom=fnal.gov; dkim=pass (2048-bit key) header.d=fnal.gov header.i=@fnal.gov header.b=ol6G27aQ; arc=fail smtp.client-ip=40.107.199.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fnal.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnal.gov
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TN2DhDJVw4e9SWVOMiM41z5HuuA/6LRO+UU8RUplr/ReZ/hmcfmgEuja4bFvl8dI4/UB5eQIzefGwzjt7HtJvM0Yr6BALrY45g4CarUYxtoAddSfvOstvPTwpU4OlxgGKRyv+A/+Vtd/HkU0ZpliX6yj3vnKV9AgJ3GE4c6r5AwGBvBVfbU/cDB2CCB3kVCh/RErXOJCsm4d0JwKmE4V6pPYY5FKlO/GZrNMP9XQfCNvLHpVtKZleQkz3chMibKNykxw+rRNgMmVMHcFZaX1NoOuoT3iUBnW4k55HzQATVr/VWQTquc4yHSA68aoTwbKzkX6R6vtLTlrBp/4vg+jQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+x/Zt4LWQqlUflyH4zQSt2OWBGbKzYJz+dSwNgxERA=;
 b=m8Vv/JDpH/YhQudoiRJJhhPP8mTuQZigZ69m/xgAHZ+rR/f5X5F3R716x64OnQueQjuSAzQDOSugI3O7G3/gE3KIr0Os3QtuMM0ct9TsTTHh/TabL419u7YwBOcfZ1snEJIuRL8e6W4TBTnEOIqHE3X77P/GDUQT8FU3AAKTBDcylE4S5p5N4yCHGassNdCf6youy0ftGImzdevdKerJbWstmZXNSabT9X2D2y+leRo87x7z2EdxJ4Sme8ItTLEuZP9FJmHQ5PqdLRcQ4zMAo5Az3ezsujftYPxoQmMT54pAgbTU/pS1O/IA8xXIzFiP0+96goKdzfOe9YPGI54p0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fnal.gov; dmarc=pass action=none header.from=fnal.gov;
 dkim=pass header.d=fnal.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fnal.gov; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+x/Zt4LWQqlUflyH4zQSt2OWBGbKzYJz+dSwNgxERA=;
 b=ol6G27aQMM2t9v9AKKHUpjOh/aKNw8kXnQIYbeEm+YP12ZKrCIkVxMnb2SXVuWZWb4+O7nmkMN9lvQ7C8Kxp1F8qxFdqlicA9FRzQdVuPjuXig/pym+w5mzLF1CAgNJULyYFGZnOVY2hVb16nMt8I3KkrLeskC2okQLWGrsWCmH9uH0UrTBct0Cyn0T34GuTV5HZdBcRiDJpPkmaiMc8oH1ZekUA28Ow1d7sd6h9Ri6MOi5YVDVRTjtuTNMETplJduvvhSvYHUZMWj3mNmBuYAhoqFBhsRz72Jb/kt0k5IVUBTo8v/q+n7Fo5WKVKXmWSfKTa7dSnDb2Av0IHZs83g==
Received: from PH0PR09MB11599.namprd09.prod.outlook.com (2603:10b6:510:2aa::9)
 by MN2PR09MB5001.namprd09.prod.outlook.com (2603:10b6:208:211::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 23:29:35 +0000
Received: from PH0PR09MB11599.namprd09.prod.outlook.com
 ([fe80::7c3d:ada9:5944:a121]) by PH0PR09MB11599.namprd09.prod.outlook.com
 ([fe80::7c3d:ada9:5944:a121%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 23:29:35 +0000
From: "Andrew J. Romero" <romero@fnal.gov>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: GSSPROXY ( for NFS with sec=krb5, krb5i  , krb5p ) is development
 still active or is it being depreciated
Thread-Topic: GSSPROXY ( for NFS with sec=krb5, krb5i  , krb5p ) is
 development still active or is it being depreciated
Thread-Index: AduTpkJL3Z+Uz30mSiOYGbEcxqj6hQ==
Date: Wed, 12 Mar 2025 23:29:35 +0000
Message-ID:
 <PH0PR09MB115997CF2D7A117949CDDB375A7D02@PH0PR09MB11599.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fnal.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR09MB11599:EE_|MN2PR09MB5001:EE_
x-ms-office365-filtering-correlation-id: 8e5507f7-1d7a-49ed-c696-08dd61bdc027
x-fermilab-ob: 1
x-fermilab-sender-location: inside
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?T+VHpA+CRetLspJiJEJwp1mhu1cjDe31mVbIxAVxJzK7TOhC2SyMGWQxd8Fm?=
 =?us-ascii?Q?x3twFy2/6QoT4hvH/Z3rHEIqlYPIue/KjcnHAxw+eCvTv6+u+AF0crKtbo2R?=
 =?us-ascii?Q?vq/SYDwN+8jwRJKTb3VlUQ3nvo3ch5ZRCQa7EXEJsCAbZeLxrB9aOld7b0X0?=
 =?us-ascii?Q?u6CvfD3hRO9my9h1/nba2KtRd2Tzc9asiAVtPIfWUT1xWbvBlnqLaD5CSsDa?=
 =?us-ascii?Q?FFh51pQcyZ5jPezht07YBCcA6sFHSvVOt6iFtytXqEk9mQvU+WIhzNRhskx4?=
 =?us-ascii?Q?R21L5v8FYCXWZ7J5VVf5Amt8wAkTYk/HOPMxo9fgHo9w1fbG3SWW1/jcs9nl?=
 =?us-ascii?Q?zkiTWMiBJgd4md0VHvXX6toSzS++KukXWNxROMerBF7EuVnCMj+yh5LZToQa?=
 =?us-ascii?Q?5jZrmNCvo0HZJkFXxSA1cnL7mNWU/o//nvDoCPY/s86sanWOYLtm+XX5ckdP?=
 =?us-ascii?Q?fB+QAK1hQRBhte/F4VF/uiEvh475CER93DOCBLLJftK/FDf0KCQmcQwDuqza?=
 =?us-ascii?Q?3HZQYeJXimrrlb1t6e43f1Zy3GMFpxAAGYsUAOWGdzagU2EGfr/LescjQ3t0?=
 =?us-ascii?Q?lyR7o5rtzs2+GyObaIamYR3NCufMfzFPPeuzx/M9EaoHhX3HbATkt+b16OWl?=
 =?us-ascii?Q?6ReGQRVJ/k6RNYSvnovhqDkwRy5eeImZvulMPHQVuHZJv7LJ/Uxga20zNWrt?=
 =?us-ascii?Q?YR1IjYSvGo3fQfja3sgl4DOIDPh4f1LcbQY11fYpl6jnrmkhVo5cPvevZWBe?=
 =?us-ascii?Q?x//yjAWI7/A6N9283xPPd9jOvOkT3/2Qf4O+h0GBUUQQddbYhof6d0R8JYsW?=
 =?us-ascii?Q?pdaR7CmvhLX4SVyUAfJdpXOYmIoWnM1oGkfutyZLPJ1/cYtxVPsIvZIAXmfm?=
 =?us-ascii?Q?fbnNt9Tyv+q+iWtVCq7T5gUnT5pRSLwa1aFa/QqdPXMqarjZMjIHx+s0uBU7?=
 =?us-ascii?Q?FI8DrGfDVIOH1raCJRew8BWDm8z1jK68Fef7VVcr7bmRYV5siI2kUvUwT1gY?=
 =?us-ascii?Q?HBTsviGK3wE640cqUXUVj6Mmh4vyA8nh+TClPc+7rf8mN3eAsOtTXUvCllem?=
 =?us-ascii?Q?pGjV6ERjS5lqupeTjr6vYoy2InMIqH1gyxUjYneEYR5jDZbzdjuPFBPqzZRM?=
 =?us-ascii?Q?I8tL2346pHuHJbgqc9bJySYSf2Tu+lNRWQci1iqFVW00zBObpev+cB4XSDYP?=
 =?us-ascii?Q?Mnfyg7kl/9+AIGucGf+Z4AgQo5tM7QdmiYqnyS2TDgOIaYGyItCInuAifxhy?=
 =?us-ascii?Q?wYUo3zJDxAQ0JBabLf1D5kvPxNtZqIx9jrqiwVRQzmW2iOJPKzVol0EkwAlt?=
 =?us-ascii?Q?4otf7IE62oq9rjw01uOngWErbHHSd+A3twIv1lrZzb479WrZxcB9l9REUqNz?=
 =?us-ascii?Q?sZc162zBF44TEfdaTBU2S8me8OtKiJrCpbVFFvTyEix8YRQkjtjh0IK/NEpR?=
 =?us-ascii?Q?vcb6T25LXnG5rNSI5yfyIs535qGc2zXO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR09MB11599.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YYlug0IO0L6JyQyJ1y78D4wqkQoeMlZ/70Q+3Bidm3OTOvt+omaCLR9SOhSY?=
 =?us-ascii?Q?8+C0X32IRQg+aYRFAV8LJyVUnHxs53hMm5/7t+Y4G2Cp3VceTR79gHzHRSeS?=
 =?us-ascii?Q?PzRsgoBPKojzlVtE4ZFVUYHcPkQAVRNKOaR2SYsKoymEXmPEugDoZwahr1Wg?=
 =?us-ascii?Q?KcwQM4VjEu233yQ88Wi9HaciNJgidWYwA3WvqnV1ZHU6S8nd3MS5OrzmZvOK?=
 =?us-ascii?Q?6PCpiulLmRZ3FFOkXhtxjrTJsHEzftLOP3PVdacEa/ByuEM6Mtt4E7Arn9Uy?=
 =?us-ascii?Q?wNNrXqswAXGXdwcJGBYnw8CQ+TbWBb8y/RxY3yyiHlaEW9YUbYmxt28EMTj+?=
 =?us-ascii?Q?wfZeA7ttLpYPu9NWMFLoZaBrMkjRMlhB8gfYSjn/afl23b9FQWl+X49PJvCo?=
 =?us-ascii?Q?+5veM8IZmNpPpUILvL12IG14Y98ia3gDreyqfC3o1g6McValPMNxJOIQioNC?=
 =?us-ascii?Q?W3ryLOb29Rki48C6j2hApKyJQCXo/SgzNQnov1zf31UV2j8llJ/6fEmL//Y/?=
 =?us-ascii?Q?+Z0h9GgX7TlHSFlSvNeMbGGhsZr5OFn89Sr0uPSGcCqn7uxKO5JxNPgm7zbF?=
 =?us-ascii?Q?jifXqkJ5R8anbH1X1XHzV0Bp/XOO/Eibbc4HnVdJfiOSYZaYZPDGcBNjBksC?=
 =?us-ascii?Q?uYHFo5bbdDwcdaFDugnvEX4+gz1qlP2Sk6XnCeAY7Q02rAADlqmEqWkR2DWy?=
 =?us-ascii?Q?299/xV6osT4Gjfg6hhO6YEEeccBKG4C5sJMK0DRjlALTXUIk7wRz5/8gMvne?=
 =?us-ascii?Q?ws7nIYRBNypjDu2BUkZMYU02gHarz5/YY8L1tYzAt+ShbKOHXVvNp9HG+gF6?=
 =?us-ascii?Q?KC3lcw+7ZSsSPCWkN74L6g8tSDFCp5I7OwIfso0ogzhjWUJg0xKi0IYOxflt?=
 =?us-ascii?Q?ykCpn+IhJfpz3tb7dIbe1zkxgzcJpiqAy4TwpoEV5NQicXKpvKerWZ+IgaK4?=
 =?us-ascii?Q?sef6LmXttlam/9Pu+Y+n0jEYBlM7dHO6V19zBKwGTZ/b3zTu8IYNvmmlicjf?=
 =?us-ascii?Q?OHyVK8AY6eGS3xeeokqRGajXynHBQkzrGTV7rKH8MR59bqVu+sCxjKWgn+JV?=
 =?us-ascii?Q?l9UKnefTxaUXPA5J0huhjIQxEY4Gnu1Uj+oorPj/GU2EEZqqq/Y3T6dnQT0k?=
 =?us-ascii?Q?aET1npnOUmubg9UvlxTOkoN5P3BAl0Pb3OlctC0/w/nTXLq55/EnjUG/gO2T?=
 =?us-ascii?Q?OA3m4UQ/EISoULLfmtha+A7n5Lu9gKxIUPPYHvmpD/k5hF9TC95vUPUej0jd?=
 =?us-ascii?Q?qlm4vZV750oARmWjUFCgZV2PZh6wL9iclbt9F2uaMxVfWjfN0Mfu3ARgXcX5?=
 =?us-ascii?Q?TuPDiQXozmDphT+cTxmxQw5cu/dGl6i/tT8BPfClRYnX968I+NHRzRw96A+M?=
 =?us-ascii?Q?9hu2DzivX4W7/L+fqEL3ZxOl71nTikgWTTcrRzrYjGxK8HkGGiastrUwXyVG?=
 =?us-ascii?Q?jczouE+SAUhpRfW7IXAkzEC8KLmG35w4unXZpdyzs+Uh5tL5786nkG05okMS?=
 =?us-ascii?Q?Tnh2URe91Q/OY7mt5jonz3/yam8tTcKGUhTWt1NXXbm/WTRFzoN3UtsX0qSf?=
 =?us-ascii?Q?uz9/v47vpYvpr+bjpP3FRIiM2oUvpOT2Z6zYmF/81quINB+iewh+JuALak9p?=
 =?us-ascii?Q?H2MDXhl40e341x87h0hwpx4lgo7gPfLEYjFcFkgrHDFv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fnal.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR09MB11599.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5507f7-1d7a-49ed-c696-08dd61bdc027
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 23:29:35.7011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d5f83d3-d338-4fd3-b1c9-b7d94d70255a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR09MB5001

Hi

I noticed that in newer versions of Linux=20
( for example: Red Hat Enterprise v9 ), the=20
parameter  use-gss-proxy=20
(in [gssd] section of /etc/nfs.conf file )
no longer exists.  Why not ?


I have also read that some security specialists
( noted in stigviewer.com ) theorize that gssproxy
increases security risk.


gssproxy facilitates the reliable use of Kerberos secured
NFS storage by non-interactive processes.

What are the plans for gssproxy:

a) continue to actively maintain gssproxy
   ( and resolve any security concerns )

b) quickly replace gssproxy with another
   facility to allow non-interactive processes
   to access Kerberos secured
   NFS storage

c) Declare that non-interactive process access to
   Kerberos secured NFS storage is being depreciated
   and people should either revert back to kludgy kinit cron scripts
   and the flakey gss kernel context behavior of the past
   or seek non-NFS solutions. =20

Thanks

Andy Romero
Fermilab / ITD


