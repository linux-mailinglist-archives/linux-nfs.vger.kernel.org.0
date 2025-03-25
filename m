Return-Path: <linux-nfs+bounces-10873-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 752F3A70BB8
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 21:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF74170C11
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 20:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066D3187FFA;
	Tue, 25 Mar 2025 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="E+PgLJ/z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2091.outbound.protection.outlook.com [40.107.220.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159ED19D086
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935349; cv=fail; b=h8ax6N/G663z0z5aYQtSQWDK6BHBMNoH5q/50rhK2o0LVuSGq688Xp1wLOKp6L0m2z178a6IQ0piRYu2nrygM9CmRbQ/WQwF5FQeAc+vS9iD9eU7IcZH24jpBPElgz2F5d/bCxJ9ePz7+DFTA3qfTtfJxpiISGPjulBR8hNzH8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935349; c=relaxed/simple;
	bh=tIusGgSlVCuiFoatEoW7QDWdi1f3GRzwDGghfr1/SQk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tG4ful7ipFRIgJX0OE/KNLJsYju+QLVfXuB7WyTICyStsqHB/XIZWVJegMh7xSiWz3kAaEJUYlO+EujVLOii5XlKAwTIhIP/5XXuy5fBt3S47GeDHPncf4ChJiC6FaqHQAZXQda9/BmLm7FziABUI0JGH0s1xNVpR9WFzvQ8Ev8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=E+PgLJ/z; arc=fail smtp.client-ip=40.107.220.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDpytDLoUnICcFqFx/wyt3UhELPGt534/4rP+Ugcl4Fs4+0wXvTLzK+7FgAiF2Yxo7jTEnuqdasza5JOo4aQuvUa0xr2zGsrwCBE7PELOMqkGrS72QSTWb1ykIPy9QhCYtoQRlxSor3lBWVOWHjv45yYxsiAvg72jyytVwSSIZH3R4MY/V+MeDFNOsJnyM+AU7WhyUe7qIlg9nV6PEdgOWy0ZcdoS2yHcxB0yYljHNdJC6ca0jBfSMQFYjZWe0pswehu0KQ3HDE1bXosLNlt0KuRPD7lataSc8SJxJXDkmtA2yLoQokb0SNQceSG/ttDJFUYK9Hu7dt2XpOvPfq5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIusGgSlVCuiFoatEoW7QDWdi1f3GRzwDGghfr1/SQk=;
 b=WCDkP/1LkeYUlXc16j7AH0c7G9BcqNcnyJ0IA3ed2tp1tjauxqwYrVttahO25LTv2Ho0bgOW3jSFkQ1BGTpqHn53PRWqCPPq9E5x+0s8UoF+WDhC6JMH3I2YZ/4gFXhxugic3CIbVQTmmJE/7ZMCy5h48ulAYFWvj1eT11oyAHyLfdawSUE9wnGo5D7urdaty5AVC+JmzXXm4RgezaemkjSu01yGqVQ2PI82DB8oGCswSRcBm5De8giXvZSpgubealYKyVtSQqd3izIBY6uhToQaOoOIu3w508Tmx27XALqjf24rk5UmGkKof7izj/L/TfQpmu3/tkJ+hRivYYpqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIusGgSlVCuiFoatEoW7QDWdi1f3GRzwDGghfr1/SQk=;
 b=E+PgLJ/zn2Z9iZO7ayGqSh161QoAZ3t7EIdPOIG8TEMImKnQLq4sQmDbu10cUZlbfH3vrWZ3fi7k3yMxxcu+PZCKl1NW5MQTNpYdqxABQRHnd7F7F4u0bwIVMH0vCBueDK+ei82bTkEPY+oUEJVtrGLEoWmEg5DRMOy80MHYOss=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW5PR13MB5945.namprd13.prod.outlook.com (2603:10b6:303:1aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 20:42:23 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 20:42:23 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "lionelcons1972@gmail.com" <lionelcons1972@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Concerns about ENETUNREACH patch series Re: [PATCH v2 0/4] Ensure
 that ENETUNREACH terminates state recovery
Thread-Topic: Concerns about ENETUNREACH patch series Re: [PATCH v2 0/4]
 Ensure that ENETUNREACH terminates state recovery
Thread-Index: AQHbnaGtwCIz8j5QzEmipv3T2vjMRrOEQCAAgAARbQA=
Date: Tue, 25 Mar 2025 20:42:23 +0000
Message-ID: <72cd09e31f3f9a6d2c6087ca793cadf67e24e58c.camel@hammerspace.com>
References: <cover.1742919341.git.trond.myklebust@hammerspace.com>
	 <CAPJSo4W2y4gF1tP9LSmqXkSr+TEz9COLPePcJVDxoJB79QUeJQ@mail.gmail.com>
In-Reply-To:
 <CAPJSo4W2y4gF1tP9LSmqXkSr+TEz9COLPePcJVDxoJB79QUeJQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW5PR13MB5945:EE_
x-ms-office365-filtering-correlation-id: b268e950-6ee1-4b7a-0a3b-08dd6bdd8bad
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MktZRmhQdDZKZHlhWjEzWEhmZkRkMzhsTGZ2WU1iTGZ4eG5XMDYzS0F2NWp1?=
 =?utf-8?B?RGk0eTNoMW5WU1RJcmVsdkN3ek5RNHNqRGo0ZXBKdWFQbTlQSVhCczNtTUFR?=
 =?utf-8?B?NFJ1bVVLYmVyaENyS1BaN1FkN2lMVkNBQmx4RU4vaWpCUnQ4M2VFRndtVzRI?=
 =?utf-8?B?cTlVRTNoMUUvNUZ0Y0sxZ3JjN0hLK1VMeWZUa214dnJrKy83MUdiRnV5a3dI?=
 =?utf-8?B?R2IwUEpwUUdMWFcwR3RuczVPMHNjc3pPbnUwUU82cHFZdVpUR3dKaHQ3OFkr?=
 =?utf-8?B?eGpyUEh1YW9jYm5oUnZxWDdZWnozYWNHMmpXaG05dDZFUWZ3YlhzbHhhck8w?=
 =?utf-8?B?WTE0K1Z6b2NXeGpRbm45ZVg2RWd2TEdRWXRweXFmNW9zOEJJOG1tQnU3QnBj?=
 =?utf-8?B?dTlTb3JFQjhZRzEwRFI3N28zRUhyeCtDSmFBSGlvSFNXVGdpcXZBbEtqTVgr?=
 =?utf-8?B?T3JZOS95SER0RE1UYlltaC9UejBVeXdhTjVWYlRpUWdQZW9SbUhmM0VBY3JY?=
 =?utf-8?B?clFyaUpRaTlIVTlrUXU2aFBIZ1h2NTdWZnNlV0taL2pCM2tKVlZqTW9Qc2xI?=
 =?utf-8?B?V0g5S2ZGUEZvQVdQTTZsbzBsbmxTMy9NOU1FRVdGUHA1OUFxRHRVWGMzcmpk?=
 =?utf-8?B?cEdKQWVqcnp0aEIzRmltOUtKaHBmNzN0ZndaRDBUcTYyUjFZanpaUWIxT3hx?=
 =?utf-8?B?OEdQTzVUd1N1NERzSzVveWtxUnZZcGN2Wk9yYUE0MVN6S1dIemdVa01GTFho?=
 =?utf-8?B?dWtMeWVUSFd1REdKZUoyb0t1bmxLK205TWQ2b0M3NFF3YmltVUd1STRpa2gy?=
 =?utf-8?B?ejk1WjJlQzlzNUFWditweHR4cVJIRTRJSVBSVUExdkRnTFh0bUJacS9WVFdy?=
 =?utf-8?B?TUp5K1BJcGQxVE1LQjlyNVJaakxtU3VhbHBCa0JwWDJETGp5a293K3lGb21t?=
 =?utf-8?B?RjBJS1hMR1ZQYUk0SjRtaDZQaS9EMUUreHgwSUNQblc0cVZsN1hidGhYNXhG?=
 =?utf-8?B?VE5KS0lJL3hsbjd0QU9GNlRpNzJuZHBUc2F1SXZYOG9sVXBvSlpSditkZWxj?=
 =?utf-8?B?STl3clg3VnIvcUlMS01EemhVck90L1VUYUpjQ3RKbEJHbEFyckYxd1A2WVRD?=
 =?utf-8?B?c29qa00yd3gzVU9lUW5USm5ldzJ5TDk2UTV4VUxnVVEvZHVrOXI3SXVESG5z?=
 =?utf-8?B?RDR3SHp4T29raTZOVlVPVFlYVkNZZ1lQaktoQUtoS1p1dmhoNnFFTzNNb1cr?=
 =?utf-8?B?b1pHcnVSbWJMSGYxY1FoNVdNbHhnaGhuL0Q1dDJlelZoSnRDRHJFMmFnQ0hL?=
 =?utf-8?B?L0p5Q3BPdWM3Vm5UeDFKMzUrOHphOFFOcXVDSXR2d2h1cW4zTStMZEhuOU5J?=
 =?utf-8?B?elRQVE52MDZmQW5wT3NEOG5uR3hxR09zMEdSZ25uU3FERGtLVDByZExtN1pM?=
 =?utf-8?B?S3B1YlVjaXE4QVhaRFVNWCsyOCtCM2dIYkRESGpqbFN5S0psNmNITE5WWkkv?=
 =?utf-8?B?aGNKL3d2S2hWUHBCWCtvU2N2ZU94dEIzU2JiUVJYSWMzeW03ZUFiek1Wdm5t?=
 =?utf-8?B?MHQ2ZUJDTklPSEMxOS9XalV1Yk1pL0QyWDVBSytmQkhUNWxkVFhMYWYxRm90?=
 =?utf-8?B?NTBmbjA2dEJBcUZNNlZwWTljaWUzazB4K0pkTG9OUUFLM0RRci82TmZCZ293?=
 =?utf-8?B?VSttR1U2QmdTbGZQenl5aGJJZld5VHRpUjNpOURBZEZBb2tFR2NaMENqNWZZ?=
 =?utf-8?B?OFE4UDAwKzh0bVlQVnVVODdYcVU0SFZUYjd4Um1IUEVoT0xhNnJCUEM0T0ls?=
 =?utf-8?B?RVVmV2QyWTNubVpLNEF1eEgvcFBGOSs4WXp6NHpRbjduakNFYWdDWnpjNnBh?=
 =?utf-8?B?YTNnUFJQd0M3YzV1TmRxcUNSWm9CamowbWtzYlVBWnZpZjZhUHdZamlNVHhh?=
 =?utf-8?Q?vW6D9xvumoA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZU5nOU9RdURWK1hqTGdmb2xzVlNab2ZNSm4yVlRXQWhGdXZNQlhkVDR2Qm9B?=
 =?utf-8?B?Rkt4ZFptSjJYNGd0T0Z1M0VHVXV1NisxcDhqUDU4NFZhU3VQKzQ4N2tsOTNT?=
 =?utf-8?B?SXU2YWd2cGRTY1FzME1pZElGY25Ld3lSRXcwK05ubXpIYUJlYlVZNkI0ak5J?=
 =?utf-8?B?d29VZEdiMjUvWWljZE9kall2RzJzWlR1MkZQdmI3aDVlVXk1cFN4cmd3eGVy?=
 =?utf-8?B?dmhLR2hiUEpTdEVFR1JER2xkMG5QdEtuMDFhNkdJeHNCNHk3MXlGalVMNjBT?=
 =?utf-8?B?Z0x4NytmdDlXOGZFc0F0YUZvbWhjQWlGRGJRWmhTS2UyT2N4QkRiUWJ6aGFV?=
 =?utf-8?B?M1JjVVd5bHNjcFBBd1ltR2Q2M1ExaFJnRWFpTTVCdmNmOGhtcjc5YVA4RkdO?=
 =?utf-8?B?SGREUFFsVjRjZk5rNVpIazE1Q2l3bWlTeFJwcnBVTi9pN3NhWTBDUDRlaU9P?=
 =?utf-8?B?M1hNRG8zclBVY2d3YXRXU3F3REZGallrY0hyWWVGR1oyTTJ1ZzZQN3IxK3Vj?=
 =?utf-8?B?aytDbnIwd0h4RjFiSks0bzdxSVVDMUxTRWxoeXhSN29POUpiOHdRQy9kTXlE?=
 =?utf-8?B?VGszZ1ZreEwxSlRjTVlQRVV3K20vTXpYZ3JvNEhNRW5YU2pnczZnVU9nVDdL?=
 =?utf-8?B?elJibHVzSy9pRzI2ZzI2b0xqWW1ZNDhVU1BzNlJoUmw1Wlk2SUlCbGRuVk1B?=
 =?utf-8?B?MFR2L2k5ZVREcDMxWkVxTlBzM0VLSjFsWGN5eXNnalNYSTZmOTNHaG9KZkJS?=
 =?utf-8?B?T1pYU2RoUFNrNklNaVhZQ3VDdW1UeFVNVmNwcVZnNEZ5UEk5T2lHeGU1V29W?=
 =?utf-8?B?YThtdEFMVFdOSFBkalkxRHpNc0k3bTdYcGM5VmpJSExuZUpqa1lhLzg2dk5z?=
 =?utf-8?B?OStScWRCY2szaStmNElSUVNaU1lLdGxDbFgwTG82aDE3dUpOK1ozemYxeFZ2?=
 =?utf-8?B?U0pHazkvV1l4Q3VoYjFmdTE1cEdFLysyczZCcUgrelZHeWgxa2grUjJob0dB?=
 =?utf-8?B?NXlYcVAvVy84TWlna29VaDVldmpwNEpXc09VR3JIUHdKNXJaZ1NWR3B1WmJw?=
 =?utf-8?B?WG5wM3RMZ3JPNlp2cGtmNGxyMkVBV2wwVU1XbE1EQzdXTTdma0x3dWhva1hy?=
 =?utf-8?B?SHR6ZXdBcjZTTWExVHByc2xvVjFpaUhCcCtWbndXVjFuVXk1NUl4a3lzZXR6?=
 =?utf-8?B?QUtmaEhYK2p5QlhyQUVIeTRpOHlvbUtla0g0L0dOOGlVS3AyTm9leVV3ZXA0?=
 =?utf-8?B?eU1HVnBCMkNta3hXRWNPTFFtU2lsbkxiK1VXd0VBNjJBTU0xUFBEWXlodTJy?=
 =?utf-8?B?Z1JGbmpPWlZGdTVPczg5SURIRjZMOEhRMitiZXVYZVhuWnNlUEEvMWVCNW1k?=
 =?utf-8?B?SFJCYUd3Wnk0ZWNzL3pQVlZod25tVXBrR2tBdU1VVkJ3VmFtMDNIUlpja1NF?=
 =?utf-8?B?L3dXd2ltOVdMY2hWc09XZHlEMEUxUUpTMjVBSDVlbjA3a0VvZHVwaGlNUGRr?=
 =?utf-8?B?ZmtzbGxJcFpKQXNMTTg5UW40TmlmVDhzazNUdWM2VjhrUytlT1dhTGxYdElW?=
 =?utf-8?B?UHNNVndQek40NzJ5dTRSQUo1dU9yRnIzRklSejltVFlTbGx2RnNpZE11WHUr?=
 =?utf-8?B?b1RwYjNDQVhrVEdzcDJaakZjTVg5SWY4RnhjY1l3amFZT1l6RWZVNEtub055?=
 =?utf-8?B?NTcyY05yOTdHYnpzTi8rZkNXRkNaeHpUUnJBTXFKNzZHRFMrYUZZeTd4blZ3?=
 =?utf-8?B?b2szR1ppRzYxRnJYak9jdjVibmwxS1pzNUkvTm00Z0Y4TWdZdmkwVG5QZFhN?=
 =?utf-8?B?ZGJ0OWtlQzdNSjNkdmsrMzhKZ0VMZzFRcGxSdE9aUEd6NU1BeWUxNHJ5VUNZ?=
 =?utf-8?B?VDhxeTdqUHJoOCtwTzExNG80Y3NSUE05dms0ZmlKMU10YTg1cmpBVEF4SUlC?=
 =?utf-8?B?R0FXYXZoOExpYy9TSEhDMkRjQWd1aURScWtQV2FVV041bDAzeEgyK3lzUGFw?=
 =?utf-8?B?TDQ3cU5DdloveHlRU3c2aWFYdHhjWFRTK3FtcU1qaFE3SmR5WWZFWFI2U25w?=
 =?utf-8?B?N1J6b0NTLzRqeUZLeWJ5alRVMy9teGtOVkF6elZsMCtJcyt2emVGYkRHaVRV?=
 =?utf-8?B?QVR6K1lVR3VDUThpamFKbXFxMU4vOHZhaWk4MkhRbEZ2UGtTaWlESHBGV0RC?=
 =?utf-8?B?eGtFU3pJN2diVUtqbGVjR0FOYWhuYm5rMnV5MzdrTmZEQ1k4UytKSVpaTjBh?=
 =?utf-8?B?RU05cmllMWRKZkg2MnBvT3JOem1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48471717A983C64BAB01B8E09DA33E25@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b268e950-6ee1-4b7a-0a3b-08dd6bdd8bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 20:42:23.1225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24wxluRusvhs/P1DV/cNHYvzHD2zoVDXzaau3U9OKGNAeytG1AuUeCzRAhWB70Jg9DWvfAWBFrIeL3qvyC6dzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5945

T24gVHVlLCAyMDI1LTAzLTI1IGF0IDIwOjQwICswMTAwLCBMaW9uZWwgQ29ucyB3cm90ZToNCj4g
T24gVHVlLCAyNSBNYXIgMjAyNSBhdCAxNzoxOSwgPHRyb25kbXlAa2VybmVsLm9yZz4gd3JvdGU6
DQo+ID4gDQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tPg0KPiA+IA0KPiA+IFdpdGggdGhlIHJlY2VudCBwYXRjaCBzZXJpZXMgdGhhdCBj
YXVzZWQgY29udGFpbmVyaXNlZCBtb3VudHMgd2hpY2gNCj4gPiByZXR1cm4gRU5FVFVOUkVBQ0gg
b3IgRU5FVERPV04gZXJyb3JzIHRvIHJlcG9ydCBmYXRhbCBlcnJvcnMsIHdlDQo+ID4gYWxzbw0K
PiA+IHdhbnQgdG8gZW5zdXJlIHRoYXQgdGhlIHN0YXRlIG1hbmFnZXIgdGhyZWFkIGFsc28gdHJp
Z2dlcnMgZmF0YWwNCj4gPiBlcnJvcnMNCj4gPiBpbiB0aGUgcHJvY2Vzc2VzIG9yIHRocmVhZHMg
dGhhdCBhcmUgd2FpdGluZyBmb3IgcmVjb3ZlcnkgdG8NCj4gPiBjb21wbGV0ZS4NCj4gPiANCj4g
PiAtLS0NCj4gPiB2MjoNCj4gPiDCoC0gUmV0dXJuIEVJTyBpbnN0ZWFkIG9mIEVORVRVTlJFQUNI
IGluIG5mczRfd2FpdF9jbG50X3JlY292ZXIoKQ0KPiA+IA0KPiA+IFRyb25kIE15a2xlYnVzdCAo
NCk6DQo+ID4gwqAgU1VOUlBDOiBycGNiaW5kIHNob3VsZCBuZXZlciByZXNldCB0aGUgcG9ydCB0
byB0aGUgdmFsdWUgJzAnDQo+ID4gwqAgU1VOUlBDOiBycGNfY2xudF9zZXRfdHJhbnNwb3J0KCkg
bXVzdCBub3QgY2hhbmdlIHRoZSBhdXRvYmluZA0KPiA+IHNldHRpbmcNCj4gPiDCoCBORlN2NDog
Y2xwLT5jbF9jb25zX3N0YXRlIDwgMCBzaWduaWZpZXMgYW4gaW52YWxpZCBuZnNfY2xpZW50DQo+
ID4gwqAgTkZTdjQ6IFRyZWF0IEVORVRVTlJFQUNIIGVycm9ycyBhcyBmYXRhbCBmb3Igc3RhdGUg
cmVjb3ZlcnkNCj4gPiANCj4gPiDCoGZzL25mcy9uZnM0c3RhdGUuY8KgwqDCoMKgIHwgMTQgKysr
KysrKysrKystLS0NCj4gPiDCoG5ldC9zdW5ycGMvY2xudC5jwqDCoMKgwqDCoCB8wqAgMyAtLS0N
Cj4gPiDCoG5ldC9zdW5ycGMvcnBjYl9jbG50LmMgfMKgIDUgKysrLS0NCj4gPiDCoDMgZmlsZXMg
Y2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IDEuIENhbiB0
aGlzICJFTkVUVU5SRUFDSCBvciBFTkVURE9XTiBhcmUgZmF0YWwiIGZlYXR1cmUgYmUgdHVybmVk
DQo+IG9mZj8NCj4gDQo+IDIuIFdlIGhhdmUgY29uY2VybnMgYWJvdXQgdGhpcyBmZWF0dXJlIC0g
d2hhdCB3aWxsIGhhcHBlbiBpZiBhIHN3aXRjaA0KPiBvciByb3V0ZXIgZ2V0cyByZWJvb3RlZD8g
V2hhdCB3aWxsIGhhcHBlbiBpZiB5b3UgdW5wbHVnIHlvdXIgbGFwdG9wPw0KPiBXaGF0IHdpbGwg
aGFwcGVuIGlmIHlvdSBlbmFibGUvZGlzYWJsZSB5b3VyIFZQTiBzb2Z0d2FyZSBvbiBhIG1hY2hp
bmUNCj4gb3IgY29udGFpbmVyPyBXaGF0IHdpbGwgaGFwcGVuIGlmIHlvdSBzd2l0Y2ggV0lGSXMg
b24geW91ciBsYXB0b3A/DQo+IA0KPiBBbGwgdGhlc2Ugc2NlbmFyaW9zIHdpbGwgdHJpZ2dlciBh
IHRlbXBvcmFyeSBFTkVUVU5SRUFDSCBvciBFTkVURE9XTiwNCj4gYW5kIHNob3VsZCBOT1QgYmUg
ZmF0YWwgZm9yIG1vdW50cyBvciBjb250YWluZXJzLg0KDQpUTDtEUjogWWVzLCB5b3UgY2FuIHR1
cm4gaXQgb2ZmIHVzaW5nIGEgbW91bnQgb3B0aW9uLCBidXQgd2UgcHJlc2VydmUNCnRoZSBleGlz
dGluZyBoYXJkIG1vdW50IGJlaGF2aW91ciB1bmxlc3MgeW91IGFyZSBhY3R1YWxseSBtb3VudGlu
ZyBpbiBhDQpjb250YWluZXIuDQoNClNlZSB0aGUgZGVzY3JpcHRpb24gaW4gdGhlIGZpcnN0IHNl
cmllcyBvZiBwYXRjaGVzOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbmZzLzJhMzdi
YTVhLWYyMTItNDQ1Ni1hN2MxLTNmOTZiMTE0OGIzYkBvcmFjbGUuY29tL1QvI21mM2RmNDUxNmM1
ZmNiMGVmMjJjMWMxYzZmNTQzMzUzNWY0ZDQ4MDVhDQoNCg0KDQotLSANClRyb25kIE15a2xlYnVz
dA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVi
dXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

