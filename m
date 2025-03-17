Return-Path: <linux-nfs+bounces-10649-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B61A66150
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 23:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C8B17E2F4
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Mar 2025 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7BA2045A1;
	Mon, 17 Mar 2025 22:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="GHHtmu9B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2113.outbound.protection.outlook.com [40.107.94.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650A202F60;
	Mon, 17 Mar 2025 22:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249486; cv=fail; b=YXoXws8rn62+8/tcundKAF1t92dNdjzjxZzlUBsrrHLLClgnAGEe7GNTc4E8IaDq3pVxUdfqDwGz9A41sRC8OQkOnK8qc1ZotDn1CwdKJN5UlKywjO3PX1IDUWBU0zBYQc+pVAlgkwK9HzrTrKbBqlNnl9FuDiJQn+mokzxiBpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249486; c=relaxed/simple;
	bh=vuV8RTZB6KEjdGkagqvmeEw2GNx0wnHEhrTZPRRlIiM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rEGpoyfIHMMzSdvkVpCcK9RFdBeGnBs1wwRp5Ox790Z6RKKCUZ70yLv9uGo0PCPszmwZL+XuF0Nn3FYespEBdV0FyTuKl38S51ypozoKYLCzTRe7Ms4UP3VLuvcUoKY+Ib0HyofB4o1QfpPzGB9BnjGcrbDhR6a0/JTLU2WGXLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=GHHtmu9B; arc=fail smtp.client-ip=40.107.94.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEdd8iMDylTG5DknzZPQ3HThz9nohXaia128Q251VzkebvzTXKDTE0zU+S3s4/KgqueyfxQEp01NMHXXlMKiEPkDCFOMSH1tiT2D5owb7WpLHohmLeLUSY6ipnh6Tl0WyvV93F5/Ys8pJQhD9apy1BYckWYTGYyuMx48ItuHIMEgRtZc1TNOwnKD57v3ytp5F92iMZEFMvDm61FVBoqHqc5L2ySAn5ar13B/h6sdpK1yggOLf1T6S2vZ3//rlNp9xkMKjYqIrP9S/RjssuzjjnpVbgc6Ca7Kl+xpc8EgAmR7wWp8ovibeUOctsx5U15YHalcAwE67ZCFTGE8sruwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuV8RTZB6KEjdGkagqvmeEw2GNx0wnHEhrTZPRRlIiM=;
 b=EnQoc3uwYqqmHxHgD4A7R/x1UizrQsE2+UzyixS/cWugUyAne+xxwavWlL0AYh9IQ13jTHaS9h6k/RfmexAeyEYBkNmFSPI0eTg04wOt7e0PBtupiYmAsk2k/HeHlswcAeQ+xDDCLVO5tq7Xqc5MmcGRcWUs2sE44HjaGYJ96n4Aj88bQC6EhyIDmbK56+yXfl1Q6Q938AcceLRYOUEdANspfn7S+GWocLCcFjBn/aORpBWLycwt2uTyhlpCXM+cY+am/BYHzdxuhh7ce/s2TPW1bdDy4ZZg5MYDRexXUndRX0czF1Op3rhVsLGAgXEU3RauU5Q27ghX2VBWLjUT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuV8RTZB6KEjdGkagqvmeEw2GNx0wnHEhrTZPRRlIiM=;
 b=GHHtmu9BfsXHtdsaos+phHwYS1MYwkMDpywL4MPtVlxplEbVnNgg9yrSElJwRRIxGabR+59661IKW5gzXSONQx6DB14F8I2vmt5iEaBiXFFjvIA3IRgA0Jtwz3Jg/R+Fwy63rgER9OlLbHJsk3oXmAaM9B+nrAJ23o6L10XefEg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3657.namprd13.prod.outlook.com (2603:10b6:5:248::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 17 Mar
 2025 22:11:21 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 22:11:21 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"okorniev@redhat.com" <okorniev@redhat.com>, "tom@talpey.com"
	<tom@talpey.com>, "anna@kernel.org" <anna@kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "Dai.Ngo@oracle.com"
	<Dai.Ngo@oracle.com>, "edumazet@google.com" <edumazet@google.com>,
	"neilb@suse.de" <neilb@suse.de>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "bcodding@redhat.com" <bcodding@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] nfs/sunrpc: stop holding netns references in
 client-side NFS and RPC objects
Thread-Topic: [PATCH RFC 0/9] nfs/sunrpc: stop holding netns references in
 client-side NFS and RPC objects
Thread-Index: AQHbl3+/il4MJnYfoEWHpLj23/vAkLN32gMAgAAGQYCAAAPBgA==
Date: Mon, 17 Mar 2025 22:11:21 +0000
Message-ID: <8e781348f00184205c38e96e9e8af046d4d2f500.camel@hammerspace.com>
References: <20250317-rpc-shutdown-v1-0-85ba8e20b75d@kernel.org>
		 <b4a720542c9afcdf3d7cf8641893b448423e0a9b.camel@hammerspace.com>
	 <05463008488b1fea6fb47a2d1a525096fecda861.camel@kernel.org>
In-Reply-To: <05463008488b1fea6fb47a2d1a525096fecda861.camel@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB3657:EE_
x-ms-office365-filtering-correlation-id: fd8943cc-2469-46c0-a800-08dd65a0a650
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1Y5L1Z5T3ZKQ0ZhMjVqT0wzRVA3Q3hra3V3cWhqZHZ0cHZidEZyN0p6NXJa?=
 =?utf-8?B?WTFzcnJCcGk1cjNTWUlRUUlVMFB4UXdlSW9TMXBSeFNSSjh6aXBKdTV2Uk8z?=
 =?utf-8?B?WEdlUWpKL3k5SkIxTTZTV2MvQU5QQzRUMFFTN2FDRDJvY3FXbVBNdjMzUnFw?=
 =?utf-8?B?b0tvSUw1T05STzkzTnFGeGRic0F4UXQ4c3ZHM3A4SlZzQTd6ZGpTQ2xtRnNo?=
 =?utf-8?B?R1BSYXl0dW9aQzgvZTI3cUtrVEFYYnk1N2ZqU2dzK1lpaEtiVVAxTjJNaGdH?=
 =?utf-8?B?M2kzaGFtZ1gvUEpLZFBuL1RaKzcycmo4TG1lOE9iK0pYU3lRQmpVV0tKWGV1?=
 =?utf-8?B?K0FOWEN5TkdUUW40R20zR3paRWdMR1V4Y1ZLU25LR3d6dzFNK1NkRVF3aEhw?=
 =?utf-8?B?b0M0STl5ckszTzZ1VjlFbSswbXMvOWNkY094RGFyd1crSFRobzNLSEUzYU80?=
 =?utf-8?B?YlJNSFNJOFBnd2VuK3JadU9PMWE2ZzdQMGF2cmlCTjM5amRrMkdUaHZRL1My?=
 =?utf-8?B?aVB3cUJkR2M3Rkt2K2d1OUFMdm1FRzZLSG5oNGN3SXpkbHlDdXlDWVE5YjY1?=
 =?utf-8?B?TXhxTWJwN3NCejRvWFd3cC9yRUZxK1FoaTh6UVFKWWRoOVlWWDJid0RnTHlw?=
 =?utf-8?B?Y1JFUDJCTzB4YlQvNTZsUHdaUGk5L2txOTlaakVRa2VjSzBHUHZpRXNzendV?=
 =?utf-8?B?dEJpUWJLdlpFTFhzeXFtQjBXRFBaNTdiYXVocXp1VmZWYzZQaVd4NHFkeDlS?=
 =?utf-8?B?ckpxRDVDb3dESlpmeWFBOTE4Y1JHMDUwR1ltRE9pUkVQRVl6dXhUQ3d1N0Vy?=
 =?utf-8?B?NEZjVWMzaVRiblB5eUg0a3h2Y2pPNlpWSUJ1L1JOaTNVdnRIYTNPd0ozNDBn?=
 =?utf-8?B?SHBTSTJoSXZneEVySHB4bk5sbDVVSjBzZ2FnSkRPMG1nRG5wRW9MODMvVTBv?=
 =?utf-8?B?RlhGYmpiNVVUVzRjWnNqMzZvL0JEWjZUb3RjSTQ1MUF6WVphbGt3Z25zbUt3?=
 =?utf-8?B?UlZhN2J1N1hzNk5JSC90VXBWUHRLazlITGg1TGhuNTdBL3NGZGtPeHhzZ1F1?=
 =?utf-8?B?Y1MyYkF6dUk2TjZtcVhwM3MxdTk4T1o3STF4ZlR5Ymh1bXlGV0hveldpM0JE?=
 =?utf-8?B?eUxnWmU0dkxFZGRXNzhKNkdpM25hN244ZFowaHRKRUtkYjZ6NU5DWG1OZDQy?=
 =?utf-8?B?N2lOTjYxNVduN2t4ei82Z0hqekhGb1p3NUVCaWxUSHJjSmh0UzBUMmZ1YlA5?=
 =?utf-8?B?SC85NCtZWlAxTGM3OFBmSTcwd1dTVXNoWEJxWjlTOEw2TVFQblZVcUV0RXY5?=
 =?utf-8?B?WElpcXlWZjk2VGdTYlVia0dIZTlxU0lzRjRidndlenNSS0VFVkdNTUlNMW84?=
 =?utf-8?B?N1lUT1BiRmZEM05oZEFORGFIa3laY2RSU2RwU0tpVU92U0ZsOStnQ0JkOXB6?=
 =?utf-8?B?eFNSMXhTRzlQcnEwdFZxNUtpemMvcnMwTXRKUVJZL1NKVmtmRVlxT0xSQjRn?=
 =?utf-8?B?THdRTXN5dVZzY2k0OFdoYXlNMEcwR2N2QWk1L2VHNDVnWllYc3ZIdGZObzEv?=
 =?utf-8?B?YWVzeGpPdFlYN3dFLy8vbEk4TnUwcWN4SUFjdXdNVTZYclFtZlpiWXVKY0JH?=
 =?utf-8?B?cDNKUVBMams0Mkc4SDM4a0dndzdjRVdxekRQcVI5Z3BhNmhWZ2dzUExvUEZP?=
 =?utf-8?B?NDhhU1lXeWhEYnhhbnFqYzdqU3JPUEhIWEJJd0ZSUGFXS1g1YmMxb0lvNzV0?=
 =?utf-8?B?YnkrelZYS1hqTDFHUkR3ZkxhNGpnYTVhdXdGZVFKM0ZxcTdjUlZLM2pTalo3?=
 =?utf-8?B?dk5RdGxvWEZFY0ZVSStSeXlVek44UlVhU3V5eThHd1lYWVlxQ3RzWXA2Z3Nv?=
 =?utf-8?B?dFZqSjJldHl4YlJDaldXNmZYZGVTMnFIbWwrbVg1eWk5UHphaENZNzB5UFBI?=
 =?utf-8?B?empRWU5KWU5mTitsaDByOHZZZFQzN21PQWRoTDFpQzF0S3ZHYVpFbVM3U2pw?=
 =?utf-8?B?ZXU3enBXTWN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVRRR3hxajJjTElZNlFkcERRQVlHdWxDcnREMU92ZS84OU9YMHJBa01nWHpl?=
 =?utf-8?B?bSt2dUhCOWQ1ZW1Db0hjOHpZMlNhWEd5VzBJcnBMbjNmRE9YTllMVE8rdVI3?=
 =?utf-8?B?QXM3N2RSckJGSGV2VEdrU3IwajY3Z2NQdlYvNmRWaTNZdUQxTnNRYzhnZ3RH?=
 =?utf-8?B?YUo1ZFNNclJ6WmdJVDl0MXp3QldJOFZuWUQwbjNaZSs2SUdoa3FSN0QxUUFh?=
 =?utf-8?B?RldzUldnUnY3STlSQmozU1JFRitnTWZxY21EU2lCSGNmdDdBU1Y5VmxFOXgw?=
 =?utf-8?B?TytTY3MyUEhHa2JFa1FZZndiWnpaWmx4bTBNZlFjcWZ6Z0NtaXJCYm9sMlBL?=
 =?utf-8?B?S0tsWWdBb3ZYcC8vTGtSeG1IakNZTDIvSkJuZ1FadHJyZUFFMzQ3NDRuQnpi?=
 =?utf-8?B?ckJqWGRKRVVmeWNHczhXT0lKL3NhSXpZYktxeGhxUkh3eFR3NUxIUkRoMTht?=
 =?utf-8?B?djBxMERTQU1rSDNjZXVlVWorR0NnU0NtS2g1bmtKLzJ1V21QQzZML3JZajBu?=
 =?utf-8?B?bTVzRDFQN1h3VEh3V2UvK0IvN3czYzVQNEVjM2N2eFF6Y09JSDhoM2h6QUhJ?=
 =?utf-8?B?TnNJLzdBRVVFVTRWaVIrNDdkZXBOS1VTSHg4bkxFUFRNVWhNTld3SmQ0aCtq?=
 =?utf-8?B?ZlVqWnRTaGh1RWdlTVJTVHczM0dZeTRLTk9OUFNQRzJ6QWpDZVZ2Zkw4TlA1?=
 =?utf-8?B?UkRxMGZtWnlnUEJXVm4ydUZ4Zzc4WXFaZUJFRnhzUVB2STcvZHA1T2FSeU11?=
 =?utf-8?B?b041dG5GUTV2VThUWVhlOVgzMG1nQksvTWZzaklRaDQyRDBJdnp0SVhnYjdL?=
 =?utf-8?B?eW5WMTZyVlc0aTBqZEJFNExHTW9BNlNQNzhaUU11QWtZS1UxV0NnemV6aURs?=
 =?utf-8?B?cUtDR00rajhGR3A4SWFveC9YVWNGb0wyTkxXY3BTVjZTMUhwYWt2dG5VYnBo?=
 =?utf-8?B?SFNtbldrMWsyViswczJqVVZCeVQ3N1Fmc3VFalpxMlZ3MFZMY1Nrb1JCYmxh?=
 =?utf-8?B?UjRYTldCRWYvc2crZWlWY1R4bE9wOXhiYTE0RkZRa0tac3puVG94UGNHODVv?=
 =?utf-8?B?ZE1hOUxsL1ZNbHVodFJGLzlLb29zR3EvTEt3Z0o3ME5Ha3FTY29TQzFMYTJO?=
 =?utf-8?B?K29JeWVCQnhPb25mOVNoa1ZQVWN6NEYzdHNrUzI0blYrLzFHQm9UUjU4RWRN?=
 =?utf-8?B?YWdGenJUVTh0ckV4bmpWazBJQ0dIdm1aMU9kSklpa1BOL2d3dGl2aXlDbVN5?=
 =?utf-8?B?eVYveFdIakFDZ1B3ZGRkU0RVdzJ3bU1uQnloamN1VFphVFhiOUV6RWlQVWhJ?=
 =?utf-8?B?d2xJQUtTQSsvQlgxTEgyR0dZQ0loUC85WHY4c1NWSUhaeTdIbmsrVUl1YlBH?=
 =?utf-8?B?K3dTTDZkTlZJcVdOa1JSWDEwRDR2UmNVMXpmcENRS2t2eVF1V1VXdnlzeVRR?=
 =?utf-8?B?amY0cEtkSHBkOVhTUXo1RTJ6TCs0ZTV5a2ZnMmJyNlhLS3UwWUZLNEhreWk2?=
 =?utf-8?B?WmpxTTJmelRpVHI3WUtPNmtPQ2JFQThMZnEvdmcya3ZaNGU3dnRVTE40bWkz?=
 =?utf-8?B?QUYvaXIrUFpPVk1UQ3B0OE1NVGpPc29nM3JYRHJ5dHppQUNjMW5PYXZnSlZQ?=
 =?utf-8?B?OTNKY0piWWlmV2NCVmxGTTRla1lobXA0YTB0dWMvNGliVDZvRGJWOGQ0bklz?=
 =?utf-8?B?aGtYWTNvMUdoNGhXTDRHUlFYTEpBMW1ZS0JFaFdMSVBGdnVtT1N1czBHV2tW?=
 =?utf-8?B?eVFqK29xM0hTS2U3TGtFQjdaTDlxSUZ1Y0tSQ25vQWY2SUZTVkJXbjdobmNN?=
 =?utf-8?B?ZU1iSkhRTXJkRG9SUmhOTVFUT00vdG1Nb1A2NVJibGtMYTRPUWlKYXo3RUtV?=
 =?utf-8?B?YUFvZGk1c2hnNm4zVm0vUFloQjhZWWdBVVBGQWRSbVQ5aU5XZ3ZkOU84OFox?=
 =?utf-8?B?SzUrdUhOTjRjaFhiREFDRWMvSXFvbWNtVEtReTluWnh0WHpTOEpXUEd1bk1E?=
 =?utf-8?B?SkNwM0FPRTdZU1BHSjNoNkh0anNyTk5FZ3ByMlJMOGNzZUkyM2FDNWZTenEw?=
 =?utf-8?B?NEtGMkM2NVdLTk1XbHVkbnN2Y1FYMTgxKzZXRXhnWmFxa3FBdjBmTDR5Q3ZY?=
 =?utf-8?B?eGZGQ0dGTTc1eUx6N3U4UE5ka01lYkhpenFEZUxCNGJQR3c1cHZvZVhkQzlr?=
 =?utf-8?B?SGpvU0lNSTg3U0M1WVZuUHFBYUpCM20xUXZyQzBlWk1nSHphc2R5ZWp4MURt?=
 =?utf-8?B?OWw3R2lsZzV3TVY2eU4waHF3VTBnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E464C9F7CD3A345B120B43FEA476DFE@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8943cc-2469-46c0-a800-08dd65a0a650
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 22:11:21.5832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpxjFAHY6FyveEbHycJCp1TYN8hUg0mkJ5FHDje86X9FW6vKEJSRs7ylQlEoh4FF24gpo6azvnPr8XgJ8GjrkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3657

T24gTW9uLCAyMDI1LTAzLTE3IGF0IDE3OjU3IC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gTW9uLCAyMDI1LTAzLTE3IGF0IDIxOjM1ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+ID4gT24gTW9uLCAyMDI1LTAzLTE3IGF0IDE2OjU5IC0wNDAwLCBKZWZmIExheXRvbiB3cm90
ZToNCj4gPiA+IFdlIGhhdmUgYSBsb25nLXN0YW5kaW5nIHByb2JsZW0gd2l0aCBjb250YWluZXJz
IHRoYXQgaGF2ZSBORlMNCj4gPiA+IG1vdW50cw0KPiA+ID4gaW4NCj4gPiA+IHRoZW0uIEJlc3Qg
cHJhY3RpY2UgaXMgdG8gdW5tb3VudCBncmFjZWZ1bGx5LCBvZiBjb3Vyc2UsIGJ1dA0KPiA+ID4g
c29tZXRpbWVzDQo+ID4gPiBjb250YWluZXJzIGp1c3Qgc3BvbnRhbmVvdXNseSBkaWUgKGUuZy4g
U0lHU0VHViBpbiB0aGUgaW5pdCB0YXNrDQo+ID4gPiBpbg0KPiA+ID4gdGhlDQo+ID4gPiBjb250
YWluZXIpLiBXaGVuIHRoYXQgaGFwcGVucyB0aGUgb3JjaGVzdHJhdG9yIHdpbGwgc2VlIHRoYXQg
YWxsDQo+ID4gPiBvZg0KPiA+ID4gdGhlDQo+ID4gPiB0YXNrcyBhcmUgZGVhZCwgYW5kIHdpbGwg
ZGV0YWNoIHRoZSBtb3VudCBuYW1lc3BhY2UgYW5kIGtpbGwgb2ZmDQo+ID4gPiB0aGUNCj4gPiA+
IG5ldHdvcmsgY29ubmVjdGlvbi4NCj4gPiA+IA0KPiA+ID4gSWYgdGhlcmUgYXJlIFJQQ3MgaW4g
ZmxpZ2h0IGF0IHRoZSB0aW1lLCB0aGUgcnBjX2NsbnQgd2lsbCB0cnkgdG8NCj4gPiA+IHJldHJh
bnNtaXQgdGhlbSBpbmRlZmluaXRlbHksIGJ1dCB0aGVyZSBpcyBubyBob3BlIG9mIHRoZW0gZXZl
cg0KPiA+ID4gY29udGFjdGluZyB0aGUgc2VydmVyIHNpbmNlIG5vdGhpbmcgaW4gdXNlcmxhbmQg
Y2FuIHJlYWNoIHRoZQ0KPiA+ID4gbmV0bnMNCj4gPiA+IGF0IHRoYXQgcG9pbnQgdG8gZml4IGFu
eXRoaW5nLg0KPiA+ID4gDQo+ID4gPiBUaGlzIHBhdGNoc2V0IHRha2VzIHRoZSBhcHByb2FjaCBv
ZiBjaGFuZ2luZyB2YXJpb3VzIG5mcyBjbGllbnQNCj4gPiA+IGFuZA0KPiA+ID4gc3VucnBjIG9i
amVjdHMgdG8gbm90IGhvbGQgYSBuZXRucyByZWZlcmVuY2UuIEluc3RlYWQsIHdoZW4gYQ0KPiA+
ID4gbmZzX25ldA0KPiA+ID4gb3INCj4gPiA+IHN1bnJwY19uZXQgaXMgZXhpdGluZywgYWxsIG5m
c19zZXJ2ZXIsIG5mc19jbGllbnQgYW5kIHJwY19jbG50DQo+ID4gPiBvYmplY3RzDQo+ID4gPiBh
c3NvY2lhdGVkIHdpdGggaXQgYXJlIHNodXQgZG93biwgYW5kIHRoZSBwcmVfZXhpdCBmdW5jdGlv
bnMNCj4gPiA+IGJsb2NrDQo+ID4gPiB1bnRpbCB0aGV5IGFyZSBnb25lLg0KPiA+ID4gDQo+ID4g
PiBXaXRoIHRoaXMgYXBwcm9hY2gsIHdoZW4gdGhlIGxhc3QgdXNlcmxhbmQgdGFzayBpbiB0aGUg
Y29udGFpbmVyDQo+ID4gPiBleGl0cywNCj4gPiA+IHRoZSBORlMgYW5kIFJQQyBjbGllbnRzIGdl
dCBjbGVhbmVkIHVwIGF1dG9tYXRpY2FsbHkuIEFzIGEgYm9udXMsDQo+ID4gPiB0aGlzDQo+ID4g
PiBmaXhlcyBhbm90aGVyIGJ1ZyB3aXRoIHRoZSBnc3Nwcm94eSBSUEMgY2xpZW50IHRoYXQgY2F1
c2VzIG5ldA0KPiA+ID4gbmFtZXNwYWNlDQo+ID4gPiBsZWFrcyBpbiBhbnkgY29udGFpbmVyIHdo
ZXJlIGl0IHJ1bnMgKGRldGFpbHMgaW4gdGhlIHBhdGNoDQo+ID4gPiBkZXNjcmlwdGlvbnMpLg0K
PiA+ID4gDQo+ID4gDQo+ID4gU28gd2l0aCB0aGlzIGFwcHJvYWNoLCB3aGF0IGhhcHBlbnMgaWYg
dGhlIE5GUyBtb3VudCB3YXMgY3JlYXRlZCBpbg0KPiA+IGENCj4gPiBjb250YWluZXIsIGJ1dCBn
b3QgYmluZCBtb3VudGVkIHNvbWV3aGVyZSBlbHNlPw0KPiA+IA0KPiANCj4gVGhlIGxpZmV0aW1l
IG9mIHRoZXNlIG9iamVjdHMgYXJlIHRpZWQgdG8gdGhlIG5ldCBuYW1lc3BhY2UuIElmIGl0DQo+
IGdldHMNCj4gYmluZC1tb3VudGVkIGludG8gYSBkaWZmZXJlbnQgbW91bnQgbmFtZXNwYWNlLCB3
aGlsZSB0aGUgdGFza3MgYXJlDQo+IHNldG5zKCknZWQgaW50byB0aGUgY29ycmVjdCBuZXQgbmFt
ZXNwYWNlLCB0aGVuIEkgZXhwZWN0IHRoZSBtb3VudA0KPiB3b3VsZCBlbmQgdXAgc2h1dCBkb3du
IGF0IHRoYXQgcG9pbnQgYW5kIGJlIHVudXNhYmxlLCBqdXN0IGxpa2UgaWYNCj4geW91DQo+IGVj
aG8gMSBpbnRvIHRoZSBzaHV0ZG93biBmaWxlIGluIHN5c2ZzLg0KPiANCj4gSG9wZWZ1bGx5IG5v
IG9uZSBpcyBkb2luZyBhbnl0aGluZyB0aGF0IHNpbGx5LiBZb3Ugd291bGRuJ3QgYmUgYWJsZQ0K
PiB0bw0KPiB1cGNhbGwsIGZvciBvbmUgdGhpbmcsIHNpbmNlIHRoZXJlIHdvdWxkbid0IGJlIGFu
eSBtb3JlIHVzZXJsYW5kDQo+IHByb2Nlc3NlcyBhdHRhY2hlZCB0byB0aGUgbmV0bnMuDQo+IA0K
PiBJJ2xsIHRlc3QgdGhhdCBzY2VuYXJpbyBhbmQgZ2V0IGJhY2sgdG8geW91IHRob3VnaC4gSSBk
byB3YW50IHRvIG1ha2UNCj4gc3VyZSB0aGF0IHRoYXQncyBub3QgZ29pbmcgdG8gbGVhZCB0byBh
IGNyYXNoIG9yIGFueXRoaW5nLg0KDQpJIGFncmVlIHdpdGggeW91IHRoYXQgaXQncyBub3QgYSBz
YW5lIHNjZW5hcmlvLCBhbmQgdGhhdCB0aGVyZSBpcyBubw0KbmVlZCB0byB0cnkgdG8gbWFrZSBp
dCB3b3JrLiBIb3dldmVyIHRoZSB1c2VyIHNwYWNlIHRvb2xzIGFyZSB0aGVyZSB0bw0KYWxsb3cg
aXQgdG8gaGFwcGVuLCBzbyB3ZSBuZWVkIHRvIGVuc3VyZSB0aGF0IHRoZSBrZXJuZWwgd29uJ3Qg
cGFuaWMgb3INCmNhdXNlIGFueSBuZXcgZXhvdGljIGhhbmdzLg0KDQotLSANClRyb25kIE15a2xl
YnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlr
bGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

