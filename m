Return-Path: <linux-nfs+bounces-5700-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B652595DF98
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 20:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 230B2B2182D
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC63433CF;
	Sat, 24 Aug 2024 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PtorMR/9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2095.outbound.protection.outlook.com [40.107.223.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B04A07;
	Sat, 24 Aug 2024 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724524415; cv=fail; b=moRbJ+zxIegQZ5yQ4vPKftb06EhL1SaEjygsYg8GIWtYfS+MijhxsJbEXXWTl9+jsvqlh7DmFLDdhtwtFjWAr/MkkC1VG/TvVy3zCe+My5MzLPffGv/RD+vPWCh2S9ntfQXcOt3LcgWC6PNq6NxtPRYch0EFdHksfNpfTZ0npe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724524415; c=relaxed/simple;
	bh=o/G78MjSVaVJID+PTShW2CkrDzRPDM7oNBfyXHPDEhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jyh6eR2O9GDeHSQNVdwSAs9/dKKcUUi+mWnNhuOBUIgFk7wYH6PjchmI04GNX5b9yypEad9lJHcPYTvRHC6rkG92zODKT9pRJcRCda+NrOxDIU2QvKV6vzLISypydPxdz6e4eGeaOQwfmwfIRswaEyzuezwLscCeItuQuAKLI4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PtorMR/9; arc=fail smtp.client-ip=40.107.223.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ay2AtWDia2vzhtj4aChVcTeActHQsCzDpH+Tfck9DU2BZziNKcCoVef3x3MJhKaDFDrLSybyfv9D8P3WefgqMzP1RcxvwN0S5RZ2liK7TRwp7MwCu7OdjPg3ZtzPio4vwriElpgtPZNBs+HN/RVQPpBOd9KSvazzXn0YvnzB2rkU8+8yaMGyfPlHyIyOtctiCdPyprZFsE6qmg/fXUQppbSKXOO6czGpMUJnyDwENhcZRxfekx9MzzlH2NlKic1yUVzOwirZOf/92aoRYf7p8H47qYbmjRh53VfN04Hwl6EPBIU/b/VnD0JTgOuJhAUGRaSDu1ahN7Q/oXc8N9o+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/G78MjSVaVJID+PTShW2CkrDzRPDM7oNBfyXHPDEhE=;
 b=xiJGf+hBaNeSqupbjJfKnX8bgGCDryY13/mgw6lzVbp4XDICjg8qt2K7getdL3fVYGcXD5l/e5dcjfA2VVUAdhpd5k4soOJaOu6ha9IX/XKNp8MjPhbmmSFs84LX+f/wyyGUI4vIL+rkEdCqNN6ganCu9tpzd0IWyAW0Zz4TmllUySjuPrinE8Nqvpg6PAzchACz3aSRSfQOw2l1b/abL5aRQbZUK0EFBgpyMMYOHEoG0vWXCOrHAPh4vYep3nDk8q0PyDTizcMfGRDQSmVPNIaflYN8qP9HxjQrcVa/wq5M0KfvFoUkn7IUWgOz2iA8ydMmCG1s4gSFYL5HOyIinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/G78MjSVaVJID+PTShW2CkrDzRPDM7oNBfyXHPDEhE=;
 b=PtorMR/9d3qgvB7Ni9YbpM1KhAzpgBVc+x/WOOslNeJkDMiFNzjJ4yNBwaEuARbHjOMFbLzkTsXqM5zqt0RIEfzGmihM5Fufvi7jbkMyaqIRgGEn3Oe+rE7J3WPHmNJOt64AVrtot1/CMiKCHng8bfU97O/P0wahcXCrpvRfMoo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3892.namprd13.prod.outlook.com (2603:10b6:a03:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Sat, 24 Aug
 2024 18:33:30 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7897.021; Sat, 24 Aug 2024
 18:33:29 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "horms@kernel.org" <horms@kernel.org>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "dsahern@kernel.org" <dsahern@kernel.org>, "wuyun.abel@bytedance.com"
	<wuyun.abel@bytedance.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuniyu@amazon.com" <kuniyu@amazon.com>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "anna@kernel.org" <anna@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ying.xue@windriver.com"
	<ying.xue@windriver.com>, "willemb@google.com" <willemb@google.com>,
	"jmaloy@redhat.com" <jmaloy@redhat.com>, "tom@talpey.com" <tom@talpey.com>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"lizetao1@huawei.com" <lizetao1@huawei.com>, "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>, "linux@treblig.org" <linux@treblig.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "okorniev@redhat.com"
	<okorniev@redhat.com>, "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"quic_abchauha@quicinc.com" <quic_abchauha@quicinc.com>,
	"edumazet@google.com" <edumazet@google.com>, "neilb@suse.de" <neilb@suse.de>,
	"jlayton@kernel.org" <jlayton@kernel.org>, "idryomov@gmail.com"
	<idryomov@gmail.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "xiubli@redhat.com" <xiubli@redhat.com>,
	"gouhao@uniontech.com" <gouhao@uniontech.com>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>
Subject: Re: [PATCH net-next 8/8] SUNRPC: use min() to simplify the code
Thread-Topic: [PATCH net-next 8/8] SUNRPC: use min() to simplify the code
Thread-Index: AQHa9lCYLhmuvJeHK0i4dLJCBHV3x7I2uFmAgAADPoA=
Date: Sat, 24 Aug 2024 18:33:29 +0000
Message-ID: <a44fbac0012c7f552867777dac41f85a554d6f73.camel@hammerspace.com>
References: <20240822133908.1042240-1-lizetao1@huawei.com>
	 <20240822133908.1042240-9-lizetao1@huawei.com>
	 <20240824180750.GQ2164@kernel.org>
	 <Zsokv8+9aDoR4uOu@tissot.1015granger.net>
In-Reply-To: <Zsokv8+9aDoR4uOu@tissot.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY5PR13MB3892:EE_
x-ms-office365-filtering-correlation-id: 6c51d9e1-9e35-48bc-90d7-08dcc46b4016
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZSt3NTJINUM5S1dOT0lFaG9TTERTaFUzbEE4K004NkRvL3U1Tmh3S3F0RDJi?=
 =?utf-8?B?czNEUzVXaFlRVHFVMkJPNzJjZVlEMjA1UDVWRHljVGhCTWZPZThRTEFvamRH?=
 =?utf-8?B?dDhweEc0V1kzd29QQnVuLzJ6MlpkOFAzTk5JQjVMVktiSStmTXRsTFBzU0pG?=
 =?utf-8?B?RU14ZWY1SS9HOHpWRTl2MkJ2L1IzYnU0VTRqWFY3a1RHZHdwcjRCbXlYTERr?=
 =?utf-8?B?aVZTeGNXcGIwRVh3NHVwZ0lrL0NZYTlLTHc3L3MrUW9RckZzNUQzR2V0MDBH?=
 =?utf-8?B?OEY0SDMyS1JkRGhnRzkwUzdLZXc2YjAwQVdwWHpGVVFzbmpUMTNYSzdzN0wy?=
 =?utf-8?B?THE4VG50UksxODRCU2pzb3pOMGtOREdGVHlSYkJSRUgzUzNTV0xNNVEyVjc2?=
 =?utf-8?B?YWN5RlhnbGYyOW0rajRrZjlsNm5zNUUzZXI2UkwvTVlUWWZ1Z3NDTGwxd3hH?=
 =?utf-8?B?cXhmdTZkUEJuanhMOFJrVFpXYWJPTUVqKzd1V3RLcW4yQ080eVFycndLaU84?=
 =?utf-8?B?UXdYK3d2MGR3ajhjdnEwTExKcnp3MmQ2aVQ3RnBzZCt1SkpaUzNZQkJpSkdp?=
 =?utf-8?B?eTlxZTVBU2hzdndjNGdEeUdaa2YxenRPemlhb29NWFZCaHJ6WXd0Tnk4MDBE?=
 =?utf-8?B?Z2dTTnBwWGRveStYcktTRm5xenpIQnNvcC9TVWRmc2dkNi93ZlVvU2FQSHJs?=
 =?utf-8?B?OUduSHM2WU5wakZKYUVlODB1ZmdFbWkvZEs2b0lrYTU5N0xyeVVOSFNUajlT?=
 =?utf-8?B?S3ExYWRtWUJDb1dSbEdRblB5QXNEamw1c0VZeGdWYVZqZ0VDZzB5b2RvNnZv?=
 =?utf-8?B?NEJ1N2tsUFJ1Wk1QNGk0dENZeC9RZDAxeGJmVkc0d3BuWTU3Z3lBM2g1alo1?=
 =?utf-8?B?aWhqY0ZnMll2Q1M3b29QNzZNc3BNVU55ajdBTmJtbE1HcVN5QXFOaVRLM0t0?=
 =?utf-8?B?c1A1YkVXNE1pL2xVd0FGdjR0WEc4dVRCL2xvbHdaYXE1Z2NqYTlGZWNOM3VZ?=
 =?utf-8?B?QVBseDJ1dUZ5ajU2a2t3NXRPYmd1amgwTkhvK3VSMkE0c1UzVmc0Tm5HRUFP?=
 =?utf-8?B?SGV1YUp2ZGVOV0dnUU9hNGczZFRudUIza3lEcWEwUzVscDE1WkM1dXoxTFdD?=
 =?utf-8?B?WW54cGk0Q3UxWmwxUHpUUGhWazFHWk9LWUR2VjYxNnpEdlg0dUNxNDAzZmt4?=
 =?utf-8?B?Qnl0Z3ZiZnFibGhBWlBqclllNkM4RStuUVpHSWU0elAycjBHa1R1RXVLbWNY?=
 =?utf-8?B?U0VHRmtlbCtVekRvY0JyUTZTbHhtcjZSR1lyU0ovaWtZWFBRd3BLcm9sNnNt?=
 =?utf-8?B?ZmxyOTFacTEzd2pPYzdKMHB6a05RaFc2aGt4cnVwYzI5RkdjbGpsN0hiclM1?=
 =?utf-8?B?alZ1eWlzVmxncWFTSXVOWC9nUGx5VkVXbS84OEFjdGNkTlVaY0hURS8wRktH?=
 =?utf-8?B?bTRnZHNYUVJ6d1VsTEJ1NDkxN1FBeHBxaTVjRUdQSHBuVEJHVGlQRDYxZTlj?=
 =?utf-8?B?aGRaWFhFNThycXlwU2pyTUFKaDZ1WVpBNlJQQ2VOR2M3MjdmRUdoWSt3Ymo3?=
 =?utf-8?B?cytxMVpFc09UdWtNRTRwL3F3NTNFdVZhMGZXZ2M0dm5DZWgvV0pYK1pmU0ps?=
 =?utf-8?B?VVBsSFE4bVdYRzJHbzRPTUlkL0tXSlU1eFp3TnA4bFRlcGxTQldSQ0dwVmZD?=
 =?utf-8?B?bTh4cGlmTFh4aXMxd3NRcGdzZGptd3A2NjRxcE5sYlNDMUVCUVU3My9adkhy?=
 =?utf-8?B?V2Foc3hIRi9RbWhhU2xlb3pHa1YvOFlELzBqa2JFcUJWWGJlSzRJR3FWaVpq?=
 =?utf-8?B?bWhNVS9MdkRqK2xHZGJSZU5XbHNqZVdjb1ExZVpBQWlHNDNKeDQwMlE3OHRy?=
 =?utf-8?B?VlBkTTUzV3B5SDhiOGNLQ3kxcUNBVlg1Q3UrL05PU1lzV3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXhTbGYzZXlXMUFZMHJSakJBUDJES09pU0QzakxNT3hFK1dTaW91d2I0UXpm?=
 =?utf-8?B?dm0wWDNIZE81ZnZ4QzQ1T1l0OGZpQVl5aWJEQXJ5eENBajFHNnNmaGpzR2F0?=
 =?utf-8?B?a2lxU0tLMGt1MGJDL0lCWWVqY1lLVjQwVlNVdFBYOVc2emhYUUNCY1YvY1Zx?=
 =?utf-8?B?Y2NtcnI5Vm1PWUVISzY4Nmc5WGJFUGk3WklydFZKbE5hNm5LcmlqMXpkcHZs?=
 =?utf-8?B?QVJqS1k1N1JQNytmdjVTckhDb3lZMWtvVFkwTTlrZElvQ0J1TmVsWGZ2bHFm?=
 =?utf-8?B?SXFMZUhhVjhndFJML2lZb3dQampycmJ5eWxZVTRxTnBCeTlvakVMU2J3dFQv?=
 =?utf-8?B?blNrd1RBR0NDaUkzcUtCcXJzUTJ3Ukt1T29mNlJDQmFPbWdKQkxTeS9hMngz?=
 =?utf-8?B?T0RvTGE1a2s2SzlGREFNK01sd3huOEV2NnNVZ29FNkNONlBqQ0NvSUZIK1lq?=
 =?utf-8?B?L1JUSjAyVldpUnpQenFaV093MmhmYVA0YndvSTIyUUVZclpHR25SNDdvbFRH?=
 =?utf-8?B?bFVyMXR2TmViZ29lUENtcmJER1N6eDNERXNJMWxFU0N0bnFyMWJtTjZncXZp?=
 =?utf-8?B?MFRsL2pxM1FkL2J6aFl5VWVrTEw4SUhiUU11QWE1VkcxT0V5MTFqT1hLOXFD?=
 =?utf-8?B?eTB6Vm9ITU1MRVVtOWVWODE5Ry9tbFZjaHg0WnZBSThmWXhJUHdabVdtNDRj?=
 =?utf-8?B?NEN4SG9BT0xManUxUWZ0LzdZOFRyK3kxZ1k3aGpMSVBVaFc0ZXp2cmZja0Rh?=
 =?utf-8?B?TThrSys2NUk1akd3Uk5sT0UydU5aajR1eURyblVCdXFYYjlKenN2ZzgvMHlG?=
 =?utf-8?B?Y0NoZzl0Z2NhRm43MEVIWjA2RE1iUUxJN3NHdnRkcjJSSTQ1eitXQ0FoUEhJ?=
 =?utf-8?B?cWpCRmFsWWFYMVROVmRkUGd3Wk45elZkMHQrTndSNkRrSHNHVWF2VGhhUThE?=
 =?utf-8?B?SnQ5bE5CeGJCaEdtZGFjSHk3dnF1RDdpSzFNaUdaT1NaRDVOZmZISlJnTk1J?=
 =?utf-8?B?OHE5WjlhV2dGcXNqSlhIbUIvUy9IVWJwcnF6RUcvVEoyYUNUdjMxempPN0lS?=
 =?utf-8?B?Qm9hTHdNYkNjSnhjaGM3SmtETHBJOTVRUkJaOVdGVUh0cWpwMkF1ZmdTbCtw?=
 =?utf-8?B?VktOMmUzYXZuWGlDZ3ZneXQ0NGhWUjViY205RGc1cnlKTlA5RmJ6aDF5UmF1?=
 =?utf-8?B?ZitrQnJHS1RaMWx2RmtOWUd4ZFowMjR5cGdBd0poaStySlhCN0hobzBJcS9R?=
 =?utf-8?B?WEJYUUcyUFM2SVdoOTUvSzFpL0Vjamh6R0FGd3I5L0dTckxLaHpqRWEybXFo?=
 =?utf-8?B?NmlDWEJBK0JyS0tYRnFTUVZRZHVBa3M2NFV4UTRJYXBtSGYyUUtRejZHdmUz?=
 =?utf-8?B?enZmeWhHZkNtZ0VrVTV2anIwaGErcVRMZFoyVFdBOFBSdDI5R3BLcHc4eG93?=
 =?utf-8?B?VGZaNDNxQ3NuU3pDeWJsSS9oYVo0ZHJCcFF4dnZRVi9OQllLNzNEYlhUZ3Rr?=
 =?utf-8?B?U0NYaWRGVUlXYUdPM0toUzNrcUhVcFFjOXZHY1VwK2YrQy8vSDkrK2VkQTZK?=
 =?utf-8?B?TEdJV09BYjAvVEpKR2dFakRqRHp1UDVZVU4rUWdoMmRYa0RyUVJqSlIvdEpE?=
 =?utf-8?B?YVkrZlo0QU5OWld4UVBod0hIeW1XU3lQRXB5dXRWWEU2eDhUWXJBVitRakdp?=
 =?utf-8?B?V3ZKY0VFSmNTWjJIaFBUdXFHcmU2d3dVWkNKWVZXcE95TUtvNStWR3hSNTFZ?=
 =?utf-8?B?eFA0bThFc2FhdUoyNU5uYUFoWUdKVlBsT1NRaFJheCtXRDhsT3dGRmd4QVpU?=
 =?utf-8?B?eFB5cEk5eU9VTis3TFk5dzJIVklleW8xb1VIVUczOFhvSmVTZEIreVpWWXJh?=
 =?utf-8?B?ZERiYUI1elNITHBQNko3cW85SnNPN01WRlNESGlyU0FDMGl3MXN5d3RyM3g2?=
 =?utf-8?B?dkIzcGVsdW5nb2xzaE1PWnRFVjVzcmduZkppNEdtdjhFWWx6WXl2YnNSMTFZ?=
 =?utf-8?B?WWNnVDhvV1FpRUxEcnM1V1dNVklQR2hpcS9XNm8raXlzZlE1R1Zmb093dGdp?=
 =?utf-8?B?dlJ6YkM3eXY5SmxHU1c0M2FWQjczdWJpUTNReVlGV1pGWjZ6S1dXd051bVFp?=
 =?utf-8?B?THpZNDFLSVQ5U3F2LzhXbkYyTGo0UnJxTmVjSWprTlEzOFZTbitKamNVSE81?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A96D541354D1C1419845E1F5A8E446B2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c51d9e1-9e35-48bc-90d7-08dcc46b4016
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2024 18:33:29.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMd3+UdVYHfPNZTE2oSozmsdriTtiaM0oO379yah9nqZ3VaB5h8dYbt8trfsGKxFXxk3iLH0kWFlF042HeDr1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3892

T24gU2F0LCAyMDI0LTA4LTI0IGF0IDE0OjIxIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gU2F0LCBBdWcgMjQsIDIwMjQgYXQgMDc6MDc6NTBQTSArMDEwMCwgU2ltb24gSG9ybWFuIHdy
b3RlOg0KPiA+IE9uIFRodSwgQXVnIDIyLCAyMDI0IGF0IDA5OjM5OjA4UE0gKzA4MDAsIExpIFpl
dGFvIHdyb3RlOg0KPiA+ID4gV2hlbiByZWFkaW5nIHBhZ2VzIGluIHhkcl9yZWFkX3BhZ2VzLCB0
aGUgbnVtYmVyIG9mIFhEUiBlbmNvZGVkDQo+ID4gPiBieXRlcw0KPiA+ID4gc2hvdWxkIGJlIGxl
c3MgdGhhbiB0aGUgbGVuIG9mIGFsaWduZWQgcGFnZXMsIHNvIHVzaW5nIG1pbigpIGhlcmUNCj4g
PiA+IGlzDQo+ID4gPiB2ZXJ5IHNlbWFudGljLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBMaSBaZXRhbyA8bGl6ZXRhbzFAaHVhd2VpLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gwqBuZXQv
c3VucnBjL3hkci5jIHwgMiArLQ0KPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMv
eGRyLmMgYi9uZXQvc3VucnBjL3hkci5jDQo+ID4gPiBpbmRleCA2MmUwN2MzMzBhNjYuLjY3NDZl
OTIwZGJiYiAxMDA2NDQNCj4gPiA+IC0tLSBhL25ldC9zdW5ycGMveGRyLmMNCj4gPiA+ICsrKyBi
L25ldC9zdW5ycGMveGRyLmMNCj4gPiA+IEBAIC0xNjAyLDcgKzE2MDIsNyBAQCB1bnNpZ25lZCBp
bnQgeGRyX3JlYWRfcGFnZXMoc3RydWN0DQo+ID4gPiB4ZHJfc3RyZWFtICp4ZHIsIHVuc2lnbmVk
IGludCBsZW4pDQo+ID4gPiDCoAllbmQgPSB4ZHJfc3RyZWFtX3JlbWFpbmluZyh4ZHIpIC0gcGds
ZW47DQo+ID4gPiDCoA0KPiA+ID4gwqAJeGRyX3NldF90YWlsX2Jhc2UoeGRyLCBiYXNlLCBlbmQp
Ow0KPiA+ID4gLQlyZXR1cm4gbGVuIDw9IHBnbGVuID8gbGVuIDogcGdsZW47DQo+ID4gPiArCXJl
dHVybiBtaW4obGVuLCBwZ2xlbik7DQo+ID4gDQo+ID4gQm90aCBsZW4gYW5kIHBnbGVuIGFyZSB1
bnNpZ25lZCBpbnQsIHNvIHRoaXMgc2VlbXMgY29ycmVjdCB0byBtZS4NCj4gPiANCj4gPiBBbmQg
dGhlIGNvZGUgYmVpbmcgcmVwbGFjZWQgZG9lcyBhcHBlYXIgdG8gYmUgYSBtaW4oKSBvcGVyYXRp
b24gaW4NCj4gPiBib3RoIGZvcm0gYW5kIGZ1bmN0aW9uLg0KPiA+IA0KPiA+IFJldmlld2VkLWJ5
OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+ID4gDQo+ID4gSG93ZXZlciwgSSBk
b24ndCBiZWxpZXZlIFNVTlJQQyBjaGFuZ2VzIHVzdWFsbHkgZG9uJ3QgZ28gdGhyb3VnaA0KPiA+
IG5leHQtbmV4dC4NCj4gPiBTbyBJIHRoaW5rIHRoaXMgZWl0aGVyIG5lZWRzIHRvIGJlIHJlcG9z
dGVkIG9yIGdldCBzb21lIGFja3MgZnJvbQ0KPiA+IENodWNrIExldmVyIChhbHJlYWR5IENDZWQp
Lg0KPiA+IA0KPiA+IENodWNrLCBwZXJoYXBzIHlvdSBjYW4gb2ZmZXIgc29tZSBndWlkYW5jZSBo
ZXJlPw0KPiA+IA0KPiA+ID4gwqB9DQo+ID4gPiDCoEVYUE9SVF9TWU1CT0xfR1BMKHhkcl9yZWFk
X3BhZ2VzKTsNCj4gPiA+IMKgDQo+ID4gPiAtLSANCj4gPiA+IDIuMzQuMQ0KPiA+ID4gDQo+ID4g
PiANCj4gDQo+IENoYW5nZXMgdG8gbmV0L3N1bnJwYy8gY2FuIGdvIHRocm91Z2ggQW5uYSBhbmQg
VHJvbmQncyBORlMgY2xpZW50DQo+IHRyZWVzLCB0aHJvdWdoIHRoZSBORlNEIHRyZWUsIG9yIHZp
YSBuZXRkZXYsIGJ1dCB0aGV5IGFyZSB0eXBpY2FsbHkNCj4gdGFrZW4gdGhyb3VnaCB0aGUgTkZT
LXJlbGF0ZWQgdHJlZXMuDQo+IA0KPiBVbmxlc3MgdGhlIHN1Ym1pdHRlciBvciB0aGUgcmVsZXZh
bnQgbWFpbnRhaW5lcnMgcHJlZmVyIG90aGVyd2lzZSwNCj4gSSBkb24ndCBzZWUgYSBwcm9ibGVt
IHdpdGggdGhpcyBvbmUgZ29pbmcgdGhyb3VnaCBuZXRkZXYuIExldCBtZQ0KPiBrbm93IG90aGVy
d2lzZS4NCj4gDQo+IEFja2VkLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNv
bT4NCj4gDQo+IA0KDQpXaGF0IGlzIHRoZSB2YWx1ZSBvZiB0aGlzIGNoYW5nZT8gVW5sZXNzIHRo
ZSBjdXJyZW50IGNvZGUgaXMgYWN0dWFsbHkNCmJyb2tlbiBvciBzb21laG93IGRpZmZpY3VsdCB0
byByZWFkLCB0aGVuIEkgbXVjaCBwcmVmZXIgdG8gbGVhdmUgaXQNCnVudG91Y2hlZCBzbyB0aGF0
IGFueSBmdXR1cmUgYmFjayBwb3J0cyBvZiBmaXhlcyB0byBjb2RlIGFyb3VuZCB0aGF0DQpsaW5l
IHJlbWFpbiB0cml2aWFsLg0KDQpTbyBOQUNLIHRvIHRoaXMgY2hhbmdlIGZvciBub3cuDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

