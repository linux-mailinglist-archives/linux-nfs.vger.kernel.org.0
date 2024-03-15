Return-Path: <linux-nfs+bounces-2334-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE8A87D517
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 21:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35AEB1F219E3
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Mar 2024 20:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1A817BA8;
	Fri, 15 Mar 2024 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="yA8zBwHm";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="aNluoXUk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0e-00379502.gpphosted.com (mx0e-00379502.gpphosted.com [67.231.147.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41017BAE
	for <linux-nfs@vger.kernel.org>; Fri, 15 Mar 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.147.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535201; cv=fail; b=qMazHNz2y/wIZ8gMCMgP5020Avcuw6nX+onyrfYKB4MJEjCPeK8obesr8W47p8ypCdaKeaGAy8u5qYyduhrGLPnBsUKlmH+GWmBiLouH+916ILCBheA4iuaq+g9dDsjTwe4n+j9pnq9bLOCRBYSUoZ2pnpRCxkPjZFgZYSGAoF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535201; c=relaxed/simple;
	bh=IUF+4M1AUqUaHV4E6RclRP4tjI7XFveDbmZ+Ku46rfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pMU6G1Jt9FEpsaQ2DNM1oa/O8I5v0as+CfW/xnGLWRBcWjW1T//FSq6yZnV5AHg5GAeSBY3g7wSwe6QMI1ojfUjnx9NdLZ9xos4GHRAmogR6a/3oNNwz+b+1okOk6QK1d1ase37UtKqf+HTxdh9N6IfohM2CjMWaHzB3C7NPdIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=yA8zBwHm; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=aNluoXUk; arc=fail smtp.client-ip=67.231.147.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Received: from pps.filterd (m0218361.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FH5E0A012827;
	Fri, 15 Mar 2024 13:21:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=02022021-podllnl;
 bh=IUF+4M1AUqUaHV4E6RclRP4tjI7XFveDbmZ+Ku46rfM=;
 b=yA8zBwHm1NpAmS4vBHXSnsQPnrYdH+22sez1GYshiS3yyPc0QfIM3VsBoOb5kpyaVu7L
 TzHXQLEssMYkfjmsVFiBGpjepS48xe3aFv9d668KXNhPnRjiDDrO5AtcQEvNjlVSDVki
 Xf8sM0mwPOPQJgv6cKwosrz2m5GFkVo1TVgXmlj0D/Scd0/HYgnbAxujP4eWWKgynvIK
 g0fX084L0WZZvBUKT9VryhuE5c6ciAm1mtJVlGtWEZ0qLxxXbGiiSpC8QHSBgpl6JNx7
 iawrmuQfR/FskOASxdM/MvW/WWo6+zsmCdbFZ7fP78t236PelvfCCD+5ZX8UufYopxzD uA== 
Received: from gcc02-dm3-obe.outbound.protection.outlook.com (mail-dm3gcc02lp2101.outbound.protection.outlook.com [104.47.65.101])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 3wvte0gmx0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 13:21:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apbI1BjEi/lDwds2G83M93OP0AcPkhsRVhc/r/vSiMDnnzqoeMcJIthpFsSXCtzOzGHbwxy5CrDnnDRnARsWlH1wXJs3yzH/k0V/ZAtcUu6ZFQJ6Uj6r8gpXWu+Q9/sXreNXqefeqiYak+kz6hgbpiPmeVAKxYlghk/wN04BmgiIgoUcrttoze6eleTDyXgRtxLv0JHK6YnMwD3nBn5zu6Vw1WjxzIgPm7KcpQwtH5YZVH8wm7wK72eWvEpo7FfdmpuZIJVFi5zvMT0EiF9ADoCnrQ8H5JWwGmt8ZLhimiMbUS4GmfSLotIFeOFMImonq/J5zC4I0eCW263WfBGyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUF+4M1AUqUaHV4E6RclRP4tjI7XFveDbmZ+Ku46rfM=;
 b=eqVmGb6ZMY9+JF33W4bLpjTDeBQ2oguXMUD/YNWT/+EI6k81l2KoXeMRoetAwbUZOrcl3M6V6B+l8C0v4DEXHknVShD/L5jIpuvl2Ju6m+A1Ovuquyl0PpVzMhNt3vIL5SPBaXnpRSmxZ7g+KLydZEKhOcvlEnqX9/q9WwuutAoZWBRv5qM0qjakixre01DS6h5IlHONzo5g2jA59dORqz50L9UYaAk4a9WCxX43QlPjR1eL4YWiA7mMglp1rMi8yT4aJihKoFYo2/NCHE4h+dfRva7ZvMt4uq331pWNLOhjs31uh7Nqi8bZAGGe0U2UAAV2Ca3AL7V+C7lMYzryKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUF+4M1AUqUaHV4E6RclRP4tjI7XFveDbmZ+Ku46rfM=;
 b=aNluoXUkRaoabiTzMPTAFdD+WBVlhG0uUtNoK55AYCETnsHaZlOq86k6096i5RXbHYcOm2Gv6nqHgfyMpNJhH/3AXelzF6SnJqidRywa24p/AXh1VxSw8z6SBrRjoi2kTUATXKnW8Ate1ocfnx/OCkPLemo0ZCmOXu8dlrkNWE4=
Received: from BY5PR09MB5009.namprd09.prod.outlook.com (2603:10b6:a03:249::22)
 by DM8PR09MB6567.namprd09.prod.outlook.com (2603:10b6:5:2e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.37; Fri, 15 Mar
 2024 20:21:08 +0000
Received: from BY5PR09MB5009.namprd09.prod.outlook.com
 ([fe80::7614:57da:9e29:eef]) by BY5PR09MB5009.namprd09.prod.outlook.com
 ([fe80::7614:57da:9e29:eef%4]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 20:21:07 +0000
From: "Wartens, Herb" <wartens2@llnl.gov>
To: Yongcheng Yang <yoyang@redhat.com>, Steve Dickson <steved@redhat.com>,
        "Woodard, Ben [LLNL Collaborator]" <woodard@redhat.com>
CC: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] rpcb_clnt.c: fix memory leak in destroy_addr
Thread-Topic: [PATCH 2/2] rpcb_clnt.c: fix memory leak in destroy_addr
Thread-Index: AQHZxFtaVcmTGEbO8UyOk+iJ/SSEz7E6Lo+A
Date: Fri, 15 Mar 2024 20:21:07 +0000
Message-ID: <20FDD5C7-F6BA-48B3-839A-FCEB232B7C98@llnl.gov>
References: <20230801093310.594942-1-yoyang@redhat.com>
 <20230801093310.594942-3-yoyang@redhat.com>
In-Reply-To: <20230801093310.594942-3-yoyang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.82.24021813
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR09MB5009:EE_|DM8PR09MB6567:EE_
x-ms-office365-filtering-correlation-id: bc731864-f56d-4d2e-9160-08dc452d7285
x-ld-processed: a722dec9-ae4e-4ae3-9d75-fd66e2680a63,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Y1qy44Crh5VajQV54geFhYKJR35+Qi5D/654S7mkLU2aatzAakguCwe84pRqHoSiWKe+t+eJBSEhmRxqBUHJveypziwPom0wrfQg7x919OWp25urKmbmsGehNuaQC740kBMxdwmo71y2L+N9qCkIlBmF6RX7JbVn2nCcqqCk7fzw5VOABvrUnDrk7CFC7rJb9NY7z6OrVZJtwRI/W769qZkobK/7UdNDPfu1JNK8tDmsQE3dXvQFAKnUkHZIXlah+dCZz3S6qtUZ3/heHlz5yfNj/2aq8naDcG7UoWUbE9I5vK9JEhyehOs+9NnuvJjktl67uzM4US8KnJPX2tPrR2F1zU2S9D+wreKBJGzmpM8fN3hi5od985IQLgEXLh9XNZj4KE0R1eVsFyvP04UhLyEd6Gjn62BHzqin1ypcGD2SMkv8aBJYiCPtbLj+tjC9n/b+PN8WyUJ24ZwfBQx3+Q0Uat/GsBCATO4aorkLqlhwde5ZlSqXuQ4CgSzX22rKDwWjCJH18NmDMx3wtpefmKDk54S10bzORuA/i1FGHBkcRxSiCfBDs4mPJvgL6s4jYmK2K3S8U+rTYjFpCWfx6fNZnXD0IwvMa3ILYoQ2WyPsSE+DyElCod/lhDpsYlvBOa1Pg6oxgGm5tnltBcr4+GQlvgepZayAubRPWEA17rPqAAlvUsnddCAW72/++f8di6/MvU58ls/4Svnh+TUd4A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR09MB5009.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NFdwODJzOWRrY3JCMlN6bnJuUU9EOHRTaHp0b3h4bGw0Z01yY1paRU5ndWxL?=
 =?utf-8?B?a0lTdEFVUFNEVE1NWWI3di9jZDBJQm1RRW9aTWY3NTVvWHFrS201RFA4aXBZ?=
 =?utf-8?B?UnJWVFlHamF3MDd0NUpwcVc0MGF3dVBCU0NHMHZCK3FQT210UjYrZndJSDcv?=
 =?utf-8?B?dklSTW1EOE1IOFdCalhBMnBDRjlROG90K01EdTVBQitRd0sxTE54dGxWU0dV?=
 =?utf-8?B?c2lyME1NTVRDQkswM1FDWlc3TXJvYzRPWFJ3aitHcWRoejNwWFNYdWZFYnA3?=
 =?utf-8?B?K3lpZzR5enBsdU4zR3N2RWcvUk9BWWRvNXpiU3BpR1FNQWlvUW12a3NYblZ4?=
 =?utf-8?B?UlJ2YTIrMkpzMzNuZHRtNGJQemQwY1ozZGRFVzRwRFlCVXM4V29EalBnZnhY?=
 =?utf-8?B?bXAyTnBxN1FDOGJYOFIyVExxTHdOcXRyNHNXWVFGckVXNWJOZ2NOTzNGT29Y?=
 =?utf-8?B?cEY2WWVsck96aHNaYUhvWmZNREk5UFhURjY0eTQ5Q043enV2aXU4MWVNTVYv?=
 =?utf-8?B?dnBKT1g5UEE0NnJWNHdFMTAzM3ZySTFkRmdFZWd1TWpPem0rbTM3dGVTSUNa?=
 =?utf-8?B?YTJWREVXc3NaUmdybi8yR2JXMlI2Y2xPTjl3UC9VRzVxOERIWEtEK0s4Qnhn?=
 =?utf-8?B?SHd5OGNhL2dTdHVRY0c3eTBETjhhdmFoMUt5V2VpSUpnbFV4ZEp0cDV4VU5q?=
 =?utf-8?B?akM0eUR2Y1AzMVdaUVpkK3JYV21WcW1uUS9mS2N2SE5uV0dHM0p4SkxyVzhU?=
 =?utf-8?B?YlVCWHBtL3BZQ200d1k0WnZ4MzlRQ1l2ZGNuUHZhZ0pYSS9pMFNHUzZ0RmR6?=
 =?utf-8?B?OS80K0xWSUMyTEc3Ulc4N3QzVGVKMEd0U1MwNVNudExscC81UjIwNXlwaVBk?=
 =?utf-8?B?eXlUUUR0NkQvV3ZtS0lGSkFKWlV6NTBjSXd0bjFldHpzM3pTRHd2YkJ3aGhI?=
 =?utf-8?B?TWhZZTFpK21SOEkza1MrZXExbjVDSC9ob3ppRGhvdm5VdjM1YUdNZnV6dU1a?=
 =?utf-8?B?dzRwNk5ZYTNSdllKQkhScTdPQ2dSRG9nVDNseHBROWpQVmozK3BRR0Exdmhz?=
 =?utf-8?B?anh1enRjWWdSVVZGd1BYOTJKWEZzM1JJcG8wemV6MFRHNlFydW9wcmpwSi9C?=
 =?utf-8?B?d3hpWmpWYjdENDNiYS8rU3g5LytlYk1RejhhRG5SZG1zbzVseU1WU25MTEk4?=
 =?utf-8?B?Zy8yNlhFTGUyOHZqcm5WRXpwL1VsQTJuRDdvdGozSXJUS1RJeUVJVjIrRzJp?=
 =?utf-8?B?dER5bllhLy9wZUh1VEVVN0kzc1FzeHhGdEc0cTJiNXErc2FrOHdTLzY1K2dl?=
 =?utf-8?B?c2ZSZEJzYXFCdmhBOEFYWXJVRlpvd1Q4MkdrclBmUm9xdTJ3Z215Ukk0VFJp?=
 =?utf-8?B?S1hYQndsNnptdFRUVTAzcWtvYzZkajJyWEgrVUIvQkZQWFZSMFJPU25neTc4?=
 =?utf-8?B?MFJJQi9DZWxBeVR1eEdLVGRlQ2F2Qnl1YmNFMzEvZnJvZktTNDRySHU5THVq?=
 =?utf-8?B?cDJXWE1WSjA4Ykg2THNLU0VnQnVTc1dZaVpUQzlMNVN0YnJVNi9BNGlYM2d0?=
 =?utf-8?B?Q0RkaldHZkk2NXdiU1Y1bk1zM0tmeWdTVTFsYThzTzhuRFRJYVhJcW5yZGpv?=
 =?utf-8?B?b0tJeEsrY1U1aGRzMzI5MUFwdDlQOGdVUDBodVZTUmsrSUVEVzdmcXN6TUFt?=
 =?utf-8?B?V0dyeXl4T21tbWdnOVFQRWk5eEtKREZDamdwZEpqcFgrT3o5N1lyR3o1cHcy?=
 =?utf-8?B?SFpUWEJlL3JrbTk3QTU5SVJyTms5SUZBT0UzcUZTQW44REVNWGFiZHlSbk9Z?=
 =?utf-8?B?L3Rra3ZxWk1UZW5KRkdZZDhrVHErWWVUMjl0WFlxMTV0VlpRazlKZ2lVRjNN?=
 =?utf-8?B?VHNPWUJDRURzZzNoci9jUWN5RjlycndDWFliYWR4OE91UW5vT0JHeStzN3Bt?=
 =?utf-8?B?RDViNlNFQW1SMC9PamdDbjZ4TkRYdmV0UEVRUzJmSkRsTVQyOHo3N1lsQldE?=
 =?utf-8?B?VjQ5cUFxc3ZIdDNaeXh6ZGJhYlZ6OXZkY0JwYyt5VjZFSEpKYTFzWVk3LzNK?=
 =?utf-8?B?UFRFcEd6ZWU3NDFJK1lwLzhIZXRVaFJwVnluKzRGSC83eWE4ajBYR2g4Zndy?=
 =?utf-8?Q?HqbdEB47sBKKS95Hzjhu8x5Jb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <500746DB061A074788A3CCC26296E39A@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sMc/DeYQ9tsI87oN+76qPmS/+aIXMfXHHDUkN0XXe5peg6aVzTX5l/MugrcchizAbRU54lilXruGZdepZB8nA1sreJrybQxKBrdkgsbz2HYWRy3y0c2AjnA2P/6vitGm/jXPdAf3JKd6rNYsNiXkYC8akICyIJa6eq+2DID+qNqI0D+stB20Q2pKrSTacr0DiThTU5R4M1dr1UUDuXeUnJqIugfP6o65jR2KxrIzvNboV/BEX12rl2capOppijVYHCZL4dVcVntLGYC45n7ToZcY0Q17XZM3mEtfHu8gCPk1+rLasJDwtaZqPbE5RCV1a5E971NNTETs4xOW4WgM2MhQA3ceBH3WayzdAkOU0tXuUG6Jw4ek5g7/ohREE+iZqybdQhJJvzcPKpT4hWtOAM2gVOk6lG9vHVt7cLZgTTMlYIyia4/SeDEQrdDbf0y69YDbA8NhhA2hE04iS5Bi0fVoPpySXVyeecGVyNwh2IU3kqnmFOXtVU9sDqISJO/g2C9Bv81HcZ6awHtYrkj6B8QEAWyBdAaAMVo1RXCsIjXnjlSJBnlMFn0/hAw5/wYndsHVA4mAQ/r44RNE8s0M9B04W8mRYFO19ixKgyHTlrUlAVHywkBYBViTRv0qP/JFK9uT+7DTOrvCu/1aJ5A85w==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR09MB5009.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc731864-f56d-4d2e-9160-08dc452d7285
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 20:21:07.6809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB6567
X-Proofpoint-ORIG-GUID: ZijB077yPnmjIjzPlhwyNpdS9hi7PDLh
X-Proofpoint-GUID: ZijB077yPnmjIjzPlhwyNpdS9hi7PDLh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_07,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403150162

SGkgQWxsLA0KSSB3aXNoIEkgaGFkIGNhdWdodCB0aGlzIHNvb25lciwgYnV0IGl0IGFwcGVhcnMg
dGhhdCBwcmlvciB0byBjb21taXR0aW5nIHRoZSBwYXRjaCBJIHN1Ym1pdHRlZCBmb3IgdGhpcyBt
ZW1vcnkgbGVhaywgaXQgd2FzIG1vZGlmaWVkIGFuZCBpcyBtaXNzaW5nIGFuIGltcG9ydGFudCBw
YXJ0IG9mIHRoZSBmaXguIExvb2tpbmcgYXQgdGhlIHVwc3RyZWFtIHNvdXJjZSBjb2RlIGluIGRl
c3Ryb3lfYWRkcigpIHdlIGNhbiBzZWU6DQoNCjEwMSBzdGF0aWMgdm9pZA0KIDEwMiBkZXN0cm95
X2FkZHIoYWRkcikNCiAxMDMgICAgICAgICBzdHJ1Y3QgYWRkcmVzc19jYWNoZSAqYWRkcjsNCiAx
MDQgew0KIDEwNSAgICAgICAgIGlmIChhZGRyID09IE5VTEwpDQogMTA2ICAgICAgICAgICAgICAg
ICByZXR1cm47DQogMTA3ICAgICAgICAgaWYgKGFkZHItPmFjX2hvc3QgIT0gTlVMTCkgew0KIDEw
OCAgICAgICAgICAgICAgICAgZnJlZShhZGRyLT5hY19ob3N0KTsNCiAxMDkgICAgICAgICAgICAg
ICAgIGFkZHItPmFjX2hvc3QgPSBOVUxMOw0KIDExMCAgICAgICAgIH0NCiAxMTEgICAgICAgICBp
ZiAoYWRkci0+YWNfbmV0aWQgIT0gTlVMTCkgew0KIDExMiAgICAgICAgICAgICAgICAgZnJlZShh
ZGRyLT5hY19uZXRpZCk7DQogMTEzICAgICAgICAgICAgICAgICBhZGRyLT5hY19uZXRpZCA9IE5V
TEw7DQogMTE0ICAgICAgICAgfQ0KIDExNSAgICAgICAgIGlmIChhZGRyLT5hY191YWRkciAhPSBO
VUxMKSB7DQogMTE2ICAgICAgICAgICAgICAgICBmcmVlKGFkZHItPmFjX3VhZGRyKTsNCiAxMTcg
ICAgICAgICAgICAgICAgIGFkZHItPmFjX3VhZGRyID0gTlVMTDsNCiAxMTggICAgICAgICB9DQog
MTE5ICAgICAgICAgaWYgKGFkZHItPmFjX3RhZGRyICE9IE5VTEwpIHsNCiAxMjAgICAgICAgICAg
ICAgICAgIGlmKGFkZHItPmFjX3RhZGRyLT5idWYgIT0gTlVMTCkgew0KIDEyMSAgICAgICAgICAg
ICAgICAgICAgICAgICBmcmVlKGFkZHItPmFjX3RhZGRyLT5idWYpOw0KIDEyMiAgICAgICAgICAg
ICAgICAgICAgICAgICBhZGRyLT5hY190YWRkci0+YnVmID0gTlVMTDsNCiAxMjMgICAgICAgICAg
ICAgICAgIH0NCiAxMjQgICAgICAgICAgICAgICAgIGFkZHItPmFjX3RhZGRyID0gTlVMTDsNCiAx
MjUgICAgICAgICB9DQogMTI2ICAgICAgICAgZnJlZShhZGRyKTsNCiAxMjcgICAgICAgICBhZGRy
ID0gTlVMTDsNCiAxMjggfQ0KDQpJdCBzZWVtcyBjbGVhciB0aGF0IHRoaXMgY29kZSBpcyBzdGls
bCBub3QgZnJlZWluZyBhZGRyLT5hY190YWRkci4NCg0KSW4gdGhlIHBhdGNoIEkgb3JpZ2luYWxs
eSBzdWJtaXR0ZWQgdG8gdGhpcyBtYWlsaW5nIGxpc3QsIEkgbWFkZSBzdXJlIHRvIGZyZWUgdGhh
dCBwb2ludGVyIChzZWUgYmVsb3cpOg0KZGlmZiAtLWdpdCBhL3NyYy9ycGNiX2NsbnQuYyBiL3Ny
Yy9ycGNiX2NsbnQuYw0KaW5kZXggNjMwZjlhZC4uNTM5YjUyMSAxMDA2NDQNCi0tLSBhL3NyYy9y
cGNiX2NsbnQuYw0KKysrIGIvc3JjL3JwY2JfY2xudC5jDQpAQCAtMTAyLDE5ICsxMDIsMzEgQEAg
c3RhdGljIHZvaWQNCmRlc3Ryb3lfYWRkcihhZGRyKQ0Kc3RydWN0IGFkZHJlc3NfY2FjaGUgKmFk
ZHI7DQp7DQotIGlmIChhZGRyID09IE5VTEwpDQorIGlmIChhZGRyID09IE5VTEwpIHsNCnJldHVy
bjsNCi0gaWYoYWRkci0+YWNfaG9zdCAhPSBOVUxMKQ0KKyB9DQorIGlmKGFkZHItPmFjX2hvc3Qg
IT0gTlVMTCkgew0KZnJlZShhZGRyLT5hY19ob3N0KTsNCi0gaWYoYWRkci0+YWNfbmV0aWQgIT0g
TlVMTCkNCisgYWRkci0+YWNfaG9zdCA9IE5VTEw7DQorIH0NCisgaWYoYWRkci0+YWNfbmV0aWQg
IT0gTlVMTCkgew0KZnJlZShhZGRyLT5hY19uZXRpZCk7DQotIGlmKGFkZHItPmFjX3VhZGRyICE9
IE5VTEwpDQorIGFkZHItPmFjX25ldGlkID0gTlVMTDsNCisgfQ0KKyBpZihhZGRyLT5hY191YWRk
ciAhPSBOVUxMKSB7DQpmcmVlKGFkZHItPmFjX3VhZGRyKTsNCisgYWRkci0+YWNfdWFkZHIgPSBO
VUxMOw0KKyB9DQppZihhZGRyLT5hY190YWRkciAhPSBOVUxMKSB7DQotIGlmKGFkZHItPmFjX3Rh
ZGRyLT5idWYgIT0gTlVMTCkNCisgaWYoYWRkci0+YWNfdGFkZHItPmJ1ZiAhPSBOVUxMKSB7DQpm
cmVlKGFkZHItPmFjX3RhZGRyLT5idWYpOw0KKyBhZGRyLT5hY190YWRkci0+YnVmID0gTlVMTDsN
CisgfQ0KKyBmcmVlKGFkZHItPmFjX3RhZGRyKTsNCisgYWRkci0+YWNfdGFkZHIgPSBOVUxMOw0K
fQ0KZnJlZShhZGRyKTsNCisgYWRkciA9IE5VTEw7DQp9DQoNCkkgZGlkIG5vdCBub3RpY2UgdGhh
dCB0aGUgcGF0Y2ggaGFkIGJlZW4gbW9kaWZpZWQgd2hlbiBpdCB3YXMgY29tbWl0dGVkIHVwc3Ry
ZWFtLiBJIHdpc2ggSSBoYWQgbW9yZSBjYXJlZnVsbHkgdmVyaWZpZWQgd2hhdCBoYWQgYmVlbiBj
b21taXR0ZWQgYmFjayB0aGVuLiBTb3JyeSBJIG5lZ2xlY3RlZCB0byBkbyBzby4gV2UgZmluYWxs
eSBnb3Qgb3VyIGhhbmRzIG9uIHRoZSB1cGRhdGVkIHJwbSB3aXRoIHRoZSBmaXhlcyB0aGF0IHdl
bnQgaW4gdXBzdHJlYW0gYW5kIGFyZSBzdGlsbCBzZWVpbmcgdGhpcyBtZW1vcnkgbGVhay4gVGhh
dCBpcyBob3cgSSBub3RpY2VkIHRoZSBwcm9ibGVtIGFuZCBpbnZlc3RpZ2F0ZWQgdGhlIGlzc3Vl
IG9uY2UgYWdhaW4uDQoNCkkgYmVsaWV2ZSB0aGUgcGllY2Ugb2YgdGhlIGZpeCB0aGF0IHdhcyBk
cm9wcGVkIGZyb20gdGhlIHBhdGNoIHNob3VsZCBiZToNCmRpZmYgLS1naXQgYS9zcmMvcnBjYl9j
bG50LmMgYi9zcmMvcnBjYl9jbG50LmMNCmluZGV4IDY4ZmU2OWEuLmQ5MDllZmMgMTAwNjQ0DQot
LS0gYS9zcmMvcnBjYl9jbG50LmMNCisrKyBiL3NyYy9ycGNiX2NsbnQuYw0KQEAgLTEyMSw2ICsx
MjEsNyBAQCBkZXN0cm95X2FkZHIoYWRkcikNCiAgICAgICAgICAgICAgICAgICAgICAgIGZyZWUo
YWRkci0+YWNfdGFkZHItPmJ1Zik7DQogICAgICAgICAgICAgICAgICAgICAgICBhZGRyLT5hY190
YWRkci0+YnVmID0gTlVMTDsNCiAgICAgICAgICAgICAgICB9DQorICAgICAgICAgICAgICAgZnJl
ZShhZGRyLT5hY190YWRkcik7DQogICAgICAgICAgICAgICAgYWRkci0+YWNfdGFkZHIgPSBOVUxM
Ow0KICAgICAgICB9DQogICAgICAgIGZyZWUoYWRkcik7DQoNCldvdWxkIGxvdmUgdG8gZ2V0IHRo
aXMgYWRkcmVzc2VkIGFuZCBwdWxsZWQgaW50byBhIFJIRUwgdmVyc2lvbiBhcyBzb29uIGFzIHBv
c3NpYmxlLg0KDQotSGVyYg0KDQrvu79PbiA4LzEvMjMsIDI6MzQgQU0sICJZb25nY2hlbmcgWWFu
ZyIgPHlveWFuZ0ByZWRoYXQuY29tIDxtYWlsdG86eW95YW5nQHJlZGhhdC5jb20+PiB3cm90ZToN
Cg0KDQpTaWduZWQtb2ZmLWJ5OiBIZXJiIFdhcnRlbnMgPHdhcnRlbnMyQGxsbmwuZ292IDxtYWls
dG86d2FydGVuczJAbGxubC5nb3Y+Pg0KLS0tDQpzcmMvcnBjYl9jbG50LmMgfCAyMiArKysrKysr
KysrKysrKysrKy0tLS0tDQoxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCg0KDQpkaWZmIC0tZ2l0IGEvc3JjL3JwY2JfY2xudC5jIGIvc3JjL3JwY2JfY2xu
dC5jDQppbmRleCA2MzBmOWFkLi41MzliNTIxIDEwMDY0NA0KLS0tIGEvc3JjL3JwY2JfY2xudC5j
DQorKysgYi9zcmMvcnBjYl9jbG50LmMNCkBAIC0xMDIsMTkgKzEwMiwzMSBAQCBzdGF0aWMgdm9p
ZA0KZGVzdHJveV9hZGRyKGFkZHIpDQpzdHJ1Y3QgYWRkcmVzc19jYWNoZSAqYWRkcjsNCnsNCi0g
aWYgKGFkZHIgPT0gTlVMTCkNCisgaWYgKGFkZHIgPT0gTlVMTCkgew0KcmV0dXJuOw0KLSBpZihh
ZGRyLT5hY19ob3N0ICE9IE5VTEwpDQorIH0NCisgaWYoYWRkci0+YWNfaG9zdCAhPSBOVUxMKSB7
DQpmcmVlKGFkZHItPmFjX2hvc3QpOw0KLSBpZihhZGRyLT5hY19uZXRpZCAhPSBOVUxMKQ0KKyBh
ZGRyLT5hY19ob3N0ID0gTlVMTDsNCisgfQ0KKyBpZihhZGRyLT5hY19uZXRpZCAhPSBOVUxMKSB7
DQpmcmVlKGFkZHItPmFjX25ldGlkKTsNCi0gaWYoYWRkci0+YWNfdWFkZHIgIT0gTlVMTCkNCisg
YWRkci0+YWNfbmV0aWQgPSBOVUxMOw0KKyB9DQorIGlmKGFkZHItPmFjX3VhZGRyICE9IE5VTEwp
IHsNCmZyZWUoYWRkci0+YWNfdWFkZHIpOw0KKyBhZGRyLT5hY191YWRkciA9IE5VTEw7DQorIH0N
CmlmKGFkZHItPmFjX3RhZGRyICE9IE5VTEwpIHsNCi0gaWYoYWRkci0+YWNfdGFkZHItPmJ1ZiAh
PSBOVUxMKQ0KKyBpZihhZGRyLT5hY190YWRkci0+YnVmICE9IE5VTEwpIHsNCmZyZWUoYWRkci0+
YWNfdGFkZHItPmJ1Zik7DQorIGFkZHItPmFjX3RhZGRyLT5idWYgPSBOVUxMOw0KKyB9DQorIGZy
ZWUoYWRkci0+YWNfdGFkZHIpOw0KKyBhZGRyLT5hY190YWRkciA9IE5VTEw7DQp9DQpmcmVlKGFk
ZHIpOw0KKyBhZGRyID0gTlVMTDsNCn0NCg0KDQovKg0KLS0gDQoyLjMxLjENCg0KDQoNCg0KDQo=

