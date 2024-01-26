Return-Path: <linux-nfs+bounces-1451-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DFB83D2A3
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 03:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB92529005C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 02:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD978C02;
	Fri, 26 Jan 2024 02:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="logsNawU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zvQd2f95"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4768F45;
	Fri, 26 Jan 2024 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236740; cv=fail; b=HG4fmKqH9jueU4SiHFF3hqN2R2GR+39YQ9jhTW+i/KzAD8rXaFcvphoGPi0QbOzIvpsGlzz3WeXo0GlxFH7F+G3LJzx7GJMKUz17PKhAQxoe6dbPmOwmQMDQZ1966S8ec0oxFra3jHN3LOBFWDHMPQEqI4NL5O8UdiMFYIe4808=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236740; c=relaxed/simple;
	bh=kZoAmbNTwWL9q9K145avYIWV4HxhC1/SK5kbjciUiRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MgGwdLjxVZ27dbYYKcJ012oqB0zECN/sfQM1u/SpbGmTXFu3Fp3qLDJd+UeUpMySdRDWdVVgK3YWXGhIzmMIcdu440kXhRkj9nW18l2po6RBMGs+n1gvkLShY9unClaob5uOT8jQjXbvDpMRFkfLAKHPeCItvDHZd7nVTnrfvSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=logsNawU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zvQd2f95; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40PMrJcl020562;
	Fri, 26 Jan 2024 02:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kZoAmbNTwWL9q9K145avYIWV4HxhC1/SK5kbjciUiRw=;
 b=logsNawU9hMxB/Yg0Qv5OpK5pgQCalwq0OwwGwjLP84WW6pbbMBYyUuV30jlT6HnpRi2
 KA576S8QlmYBNySsaDISPZrra7PXmi58hwe0WILJhVAl7SezdUbmg06G0BKKoDj0dKIx
 7NeWTtCIO9DHrqXo6yufcOOKn9ceKq7Q20P2VJfH3unMivc0b5+Kq9czZy2O9xJb9pY5
 QdulW7eh17xdvP+D64ouLm0WwrbFOk3/oDdwPrzIGK5cX39k9MjXeGf7i5HgbV+lLrkj
 KMlzAcxWSmhAgQbqtyEO++y2cMe5bdj9gYK3WA+5YFYQK7eLqAVOh2jVd+QG+vM5QTR0 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79w997g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 02:38:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40Q2NpLU011776;
	Fri, 26 Jan 2024 02:38:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs326ufud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 02:38:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVR4xakpA1wzBSkvBz0z0NGaWoO5s4ABV4BGWzWIbQ19FWRkMwtf07XHfTXiiXIIztYu7wk/cubGxCDUZZZBj/gPr7LhsHnPySOt2chqBVzktHwzP3XNjU0IaTMmtuFLMj2miq3eiGq23GJ/lhdqazMCaAFWT1EIA5Y0hAWsB/sFzvo3SOPECZtBZxD3vT402jecf9uJLEL9LWT7DMy33uQynRb5YBszjcKtcmSceXLH/kwkkuUmFB1Icg1AWfv1iKnn61IXPIkjuK+wotalW9LYZK3rPkNkAyv+tVjuKJe4YRa6fgxzjSQrg7efHKsFBM+tsahsU+4NhwrkJLmpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZoAmbNTwWL9q9K145avYIWV4HxhC1/SK5kbjciUiRw=;
 b=aDr7Agx4uzeULTmSDdssgEkr/owUF97id2mdkSGE9mwBewzNjKqbOUDuO2xjYlr+qoXrcAi7fcauDhubmSiXjVDTyhVka29ggXds20kSItMohr77G0To6otJ2CajF2QJUs2VwfzorR68C7NUT+P24hs9wFu4XcMwFwrZ8uZm9T0DvoVCieOmuBvNqFi0eR1c6c8N4q0CR6xUQva/njwOqf+KyqEcZmbEGQPBvnJEs9xzrluUIfEjMXA5PvhqQ6lhhaQ7ZZeBtyAvg5Wr/X73vXhmlmmzAa66rM4TZcT0zbC54F/+5AZ6hbHagFnooBAn2ZVYyCSftokPV+BD0SMtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZoAmbNTwWL9q9K145avYIWV4HxhC1/SK5kbjciUiRw=;
 b=zvQd2f95rDX0Gshu7muQmWJbDIAV0AVLvR0/2mgNZeYGNDegLrSNQ/wuM1sJrFEkhPl8C9VtfJjMLQRL+jZ4eRyCuf/vF/9Vc4uwtuAf4MNKMSK1Y54uwnVirdzIpvudHZYNBAfvh0WJQCBAg8QoMyxq/ZGOJC1oHauAmC18qDM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 02:38:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.026; Fri, 26 Jan 2024
 02:38:49 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Jeff Layton <jlayton@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi
	<lorenzo.bianconi@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Simon Horman
	<horms@kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Thread-Topic: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Thread-Index: 
 AQHaS8bpZ9RzO76t8E+mXe8FqSN12LDl2fGAgACEPYCAABdWAIAAuIYAgAAV2ICAACKWgIAAEuAAgAFFH4CAABm8AIAAKhqAgAImIICAAEGOgA==
Date: Fri, 26 Jan 2024 02:38:49 +0000
Message-ID: <DAB30AAE-41F5-4FC5-AA14-E7E06BB389B5@oracle.com>
References: <cover.1705771400.git.lorenzo@kernel.org>
 <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>
 <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>
 <170595930799.23031.17998490973211605470@noble.neil.brown.name>
 <Za7zHvPJdei/vWm4@tissot.1015granger.net> <Za-N6BxOMXTGyxmW@lore-desk>
 <85b02061798a1b750a87b0302681b86651d0c7a3.camel@kernel.org>
 <Za-9P0NjlIsc1PcE@lore-desk>
 <3f035d3bc494ec03b83ae237e407c42f2ddc4c53.camel@kernel.org>
 <ZbDdzwvP6-O2zosC@lore-desk>
 <8fabd83caa0d44369853a4040a89c069f9b0f935.camel@kernel.org>
 <917EC07C-C9D9-4CF2-9ACB-DCA2676DFF67@oracle.com>
 <170622264103.21664.16941742935452333478@noble.neil.brown.name>
In-Reply-To: <170622264103.21664.16941742935452333478@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SN7PR10MB6547:EE_
x-ms-office365-filtering-correlation-id: 61d22bc1-3559-425c-961c-08dc1e17ed59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 M0X9JMvI4bTqiYxRl/vcJAFyonHrOpjhrha1P3JkAIxp7ufAYRroknKqumIoTNrweY/oaR4LFswyM1ZXChN0y5W+XjAI/Ex+oVHLDa6bZVtQiN3QsCW9Cq4Tn1tWcwGyaSAmBzzvv2Alhah0R0rrolXwRX78qwT9q0Ba6P8ReXir+OjLajw2cL4TyyD3Gl0dH0QclK8zLKiv4jWOEfTO1X/YW8UApwGLv4/akfVuncOzckoFU/bmqYrA6xa6eq4BKXMbdDvWS9YcLeNUMybyNFfC/TRgwQ9hZVCr0II3DMjhumf4hdRszrWOvoPbpCdBtKmz44OqZo++srDr7XY/ULgEvit13kGFbvHObBQUdY9bZkLEvSaFq+qWhlKXGvpipoi50YcSMQ98P7gfKfobfLpNPkRGEVRRaBrnDDalMYn8rc9RhOex6BSfzIeRkY9wKQgQpaj0w305X/eUAecD42G2gyEBaMFATw3hhgpteqOGlI1I0jGEH9RbQzE8Lkh0ahzmgWxz5BSTvzEA2VFLkdt9wDusTnT4yN7YMqVKEm8jV5eqSPIdBMcFeuWyD3heL6sXLs/2ptr14D2idLdFV5JoFxvrRu8DUrBIO4cPO5/NV7ZXHAToNRK9Zpd1rgSewvnecgv+8P9WuP2/29EBxA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(2616005)(66556008)(6486002)(6512007)(6506007)(122000001)(91956017)(38100700002)(2906002)(4326008)(6916009)(5660300002)(8676002)(8936002)(66476007)(64756008)(53546011)(54906003)(66946007)(66446008)(478600001)(76116006)(316002)(71200400001)(26005)(86362001)(33656002)(36756003)(38070700009)(66899024)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aHZxVkZNOHQzNHNXaGpBbG1LeUw4cVVKSHoxNlhJdC9oa0IwNEkveEFkMll3?=
 =?utf-8?B?UW91b1lVbDBJamdmKys3K3ZFbHg3NUlpK1BiekVFZ2x6MUl0WCtZdlRRL0NT?=
 =?utf-8?B?blV0Q2RENUJwK1VVbll4V21hUW5pYlZ6Q3Joam9tRHVyb3VJL2theGxaRGd4?=
 =?utf-8?B?NFBNbmJoNStDQkh1dWx6N1lmRm9aWVhNOWxFTy82cXY2K0JiRWpFeUlDVjF0?=
 =?utf-8?B?ZHBJNE9YdkhGZWU4T1pZN29YdzVyb3FRYlJnZmNkSGZDUlBqL1FaU2tEVnEx?=
 =?utf-8?B?QU5QNy94V3NBSkxvbVkrWmZmaFpOQmRYVUxuaEFXbEx4V2pxN0xHd3hvajdm?=
 =?utf-8?B?L2JOOXpsT3FlY0h0Tzd2RTRRcDlmZGN0TmxsZWliSVpRcGpzVFZGSHpMemJz?=
 =?utf-8?B?aVY0WUt1Wm02aktqY1FvS20xSW16a1JHNnJ1VkF2Nk9zbEFJVXNTTFNHRUpR?=
 =?utf-8?B?UEdQN2c5VUF4cFZLMUx6WHV0YUJPbmtIanR4aW4rNVRFL2hOYWdUZ05WWkV5?=
 =?utf-8?B?THFMV05QTkp6d2F0dFVhRnJZWklYekxib2liZVd3WWcrMit1MGtBczM4dHJN?=
 =?utf-8?B?VUJWWDJCNFV0UUFtbzhrVUtxRVFWQzdLdnloR0pTMTdUL25oeWlsOVFSQTlN?=
 =?utf-8?B?MXh0TVMzMHNya3Jxc0dOYkw1M21sVHZWTkVUdHpaeXRlNDJ2TTRKMnZKYzJY?=
 =?utf-8?B?MnFlL0swSFRKb0JWU2twQWx5VVo3cG1vWlpXbkd3TGFNZVIrTTk0Rkh4Tjlz?=
 =?utf-8?B?NVh5ODEySmU4Z1F6ZTZqWGhES1VSUExtUElsbnBkZE9EaFZhVW9KRE8rRmhH?=
 =?utf-8?B?M0NoMkRXeE0wR2dxTUhXTk42WHhYTXdLTUN0TFRiUmk5V0lab0ZlQzdDQk5Y?=
 =?utf-8?B?NDBUeVhSVXhEaGxkVzlodTRVdW5lVHVaak9BZ3dpa1llWlduc242VHhQcGNZ?=
 =?utf-8?B?aHlRSDFSSXdqSjFIeXpubnl1S3hQVTFwNzBvMDNpUEZaNGJWSlRwTlVQOXlF?=
 =?utf-8?B?NThTdnROTmZGL28xZlhlcTIxak9lbS9kTGlkNHZqbUFRM21rZG5mamZyWVpM?=
 =?utf-8?B?dEk4NVpldmRGcVZJVUFzcnRKblFYMDhacmFWL0MyQlp4V2ZwQ0oyTk9kT1lG?=
 =?utf-8?B?cWVWeThVdm9ac0ZQSk1DdGlmM3dkMlp5Q2xSQk91cEkveFdHU2FFZHZZQ3E4?=
 =?utf-8?B?VmExOXJ3dEl1d0xRUng1a2JXQ01mcjIrcHdCejd4SE1oekNCOEN3SWU4K3JD?=
 =?utf-8?B?QnlQNlJCQUw0OE5BemhpbUhLbUh6Y01mVXFFSUlTd1MxUUlCQ0RWWHV1dFpG?=
 =?utf-8?B?RERjdVA1TGd5RHVWdDdDZkxSNjJnZERCSTVlamw0ZjVzQjVLM2orc2hlSi9v?=
 =?utf-8?B?ODRkWXozMmNSc3JFanhXcHU1U0Q4TU9JR3AwZm9QV1BJYlFzU21udDcvQ2ho?=
 =?utf-8?B?cHpoaW5ocUwwS1VHWTJmOCt6Wks0NVUxOGNHTFQ1WHJ4Y3RudmpTOGZ6K0M0?=
 =?utf-8?B?aSt5WVljTmg2RDJVblR5YjB3Q2pvZzNOUWtTQ0VqVWxaUHJ5dUtRWFQrZ1lT?=
 =?utf-8?B?STBvSlpEdTRvdXdEY3UrbzlwWHZmU0pNNnBYS3IwTVo2b3dwRVptdVZNVnkx?=
 =?utf-8?B?bHIyVFJab0w4WmVPZ2dGbW42c1NBWjZnYTBCQkVNZEVMSm1IN2J5RngwdXBU?=
 =?utf-8?B?RTljT1VrQmg2eWxKZyt3OXB1SUIxQ2FuZEpGR0Nsb255VURLZ0R1UEhnTkF2?=
 =?utf-8?B?bWJUamZPdktiTXF4TFJxSENxeW50OU5HelM2Kzh6SXJQSjFta0xhK01uT0Y0?=
 =?utf-8?B?NkgyUXlVdEVwL3RXZ2w3UUh2NldhQWRkT3pkT1M4b1U2VnhEZFU4NWJJMnd0?=
 =?utf-8?B?Vkc1emFBWTkwRldWTGRhZ0h4Ukc0SElKRUhsTm1VWmVWOWJkRlVab2NqUE1u?=
 =?utf-8?B?NHlGUHVQNjNMclhtNnBubzFlOHljdlNsRjUvb1cyams4TzZnMmZTNERBaHYr?=
 =?utf-8?B?VWtUS3dvSVo3Z3ZjY3M5QmtsS0lmclJEb2sxOHVNN1BOQ3dqdVBoZGtSTkhZ?=
 =?utf-8?B?bkZwRFBLVkdORkticFVoS1hPYjhGL2lpUFNBVGZIN2JhcWx6eFRJQVBpeDI2?=
 =?utf-8?B?OE5NWTh5VVJoSk1UTXJ5NEY4U2hCMWlNTXFMNnE4d2s1cVhKcURRaS94KzFM?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A31536F34159C540BC8D52964EB1E545@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	q1Ille+wazN6il6DGqQ80EiIknvQNHbE9Mnu5KGS3QS6ER8ndUyuuC9g2pi7qvEFWqZE+6Ldr+be8qLQG9cR6i/ILmYNryNxvNcM05LtmNVG57D8//9SfsV5dDuns7tzTkkBLT0fLOZAcOhf/B9rx1iUrsZi8VS4NkYjlf4R5OPPj24m+9q3t5E+S3QmeSBP3Gt7mmRkE7zYN2n1EPwlQN97DIvVOOvN3p1lKtsYoCUh687HZBrSJXL73yCEpi45QXJwZs5lrq+ZmdyNZL2/M5DoWwD2IYdrKXjq0G1Tt8mNgEOBdsMjLkuJi2p4PV5K56Cr7ezuW2i4Od1+Zb8HOKONVGMQfOXLbhfhWWNKD9tG4LMDAMELzK99JvCyire3/9p901zqHv3YIk598cq6jgXT32vn+bjhw5tAeDNU97p6xanBXhAj/Z8Xs4AIQFOwCNhn/W1TFxF4kSUmgzVPKKn1cDz/VLlssnDAmnU79ix+4jDOI13gdUKHKfX7rrC3BgKrnba21pNV/l75uPfKDY/o5335UI1XK5zhQKly3bg6yu573/ovabY7r1MGY6cQ/zyWhxijpcciZ+Z5LfeU1XVyhsVLFKJb5yRZ/87Gxac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d22bc1-3559-425c-961c-08dc1e17ed59
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 02:38:49.4382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJ8GvkL02qFownt/V20NNewy7dBPu6MkfIYvs50ncS0KRxF6aBsBxZ9nlTSaWfye7qH4touAvPDyhJL9R8eWug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=913 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260018
X-Proofpoint-GUID: 3Nu1xGgE2E07Jfz8iMBskcwnr74XGGBR
X-Proofpoint-ORIG-GUID: 3Nu1xGgE2E07Jfz8iMBskcwnr74XGGBR

DQoNCj4gT24gSmFuIDI1LCAyMDI0LCBhdCA1OjQ04oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIDI1IEphbiAyMDI0LCBDaHVjayBMZXZlciBJSUkg
d3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIEphbiAyNCwgMjAyNCwgYXQgNjoyNOKAr0FNLCBKZWZm
IExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4+PiBPbiBXZWQsIDIw
MjQtMDEtMjQgYXQgMTA6NTIgKzAxMDAsIExvcmVuem8gQmlhbmNvbmkgd3JvdGU6DQo+Pj4+IFsu
Li5dDQo+Pj4+PiANCj4+Pj4+IFRoYXQncyBhIGdyZWF0IHF1ZXN0aW9uLiBXZSBkbyBuZWVkIHRv
IHByb3Blcmx5IHN1cHBvcnQgdGhlIC1IIG9wdGlvbiB0bw0KPj4+Pj4gcnBjLm5mc2QuIFdoYXQg
d2UgZG8gdG9kYXkgaXMgbG9vayB1cCB0aGUgaG9zdG5hbWUgb3IgYWRkcmVzcyB1c2luZw0KPj4+
Pj4gZ2V0YWRkcmluZm8sIGFuZCB0aGVuIG9wZW4gYSBsaXN0ZW5pbmcgc29ja2V0IGZvciB0aGF0
IGFkZHJlc3MgYW5kIHRoZW4NCj4+Pj4+IHBhc3MgdGhhdCBmZCBkb3duIHRvIHRoZSBrZXJuZWws
IHdoaWNoIEkgdGhpbmsgdGhlbiB0YWtlcyB0aGUgc29ja2V0IGFuZA0KPj4+Pj4gc3RpY2tzIGl0
IG9uIHN2X3Blcm1zb2Nrcy4NCj4+Pj4+IA0KPj4+Pj4gQWxsIG9mIHRoYXQgc2VlbXMgYSBiaXQg
a2x1bmt5LiBJZGVhbGx5LCBJJ2Qgc2F5IHRoZSBiZXN0IHRoaW5nIHdvdWxkIGJlDQo+Pj4+PiB0
byBhbGxvdyB1c2VybGFuZCB0byBwYXNzIHRoZSBzb2NrYWRkciB3ZSBsb29rIHVwIGRpcmVjdGx5
IHZpYSBuZXRsaW5rLA0KPj4+Pj4gYW5kIHRoZW4gbGV0IHRoZSBrZXJuZWwgb3BlbiB0aGUgc29j
a2V0LiBUaGF0IHdpbGwgcHJvYmFibHkgbWVhbg0KPj4+Pj4gcmVmYWN0b3Jpbmcgc29tZSBvZiB0
aGUgc3ZjX3hwcnRfY3JlYXRlIG1hY2hpbmVyeSB0byB0YWtlIGEgc29ja2FkZHIsDQo+Pj4+PiBi
dXQgSSBkb24ndCB0aGluayBpdCBsb29rcyB0b28gaGFyZCB0byBkby4NCj4+Pj4gDQo+Pj4+IERv
IHdlIGFscmVhZHkgaGF2ZSBhIHNwZWNpZmljIHVzZSBjYXNlIGZvciBpdD8gSSB0aGluayB3ZSBj
YW4gZXZlbiBhZGQgaXQNCj4+Pj4gbGF0ZXIgd2hlbiB3ZSBoYXZlIGEgZGVmaW5lZCB1c2UgY2Fz
ZSBmb3IgaXQgb24gdG9wIG9mIHRoZSBjdXJyZW50IHNlcmllcy4NCj4+Pj4gDQo+Pj4gDQo+Pj4g
WWVzOg0KPj4+IA0KPj4+IHJwYy5uZnNkIC1IIG1ha2VzIG5mc2QgbGlzdGVuIG9uIGEgcGFydGlj
dWxhciBhZGRyZXNzIGFuZCBwb3J0LiBCeQ0KPj4+IHBhc3NpbmcgZG93biB0aGUgc29ja2FkZHIg
aW5zdGVhZCBvZiBhbiBhbHJlYWR5LW9wZW5lZCBzb2NrZXQNCj4+PiBkZXNjcmlwdG9yLCB3ZSBj
YW4gYWNoaWV2ZSB0aGUgZ29hbCB3aXRob3V0IGhhdmluZyB0byBvcGVuIHNvY2tldHMgaW4NCj4+
PiB1c2VybGFuZC4NCj4+IA0KPj4gVGVhcmluZyBkb3duIGEgbGlzdGVuZXIgdGhhdCB3YXMgY3Jl
YXRlZCB0aGF0IHdheSB3b3VsZCBiZSBhDQo+PiB1c2UgY2FzZSBmb3I6DQo+IA0KPiBPbmx5IGlm
IGl0IHdhcyBhY3R1YWxseSB1c2VmdWwuDQo+IEhhdmUgeW91ICpldmVyKiB3YW50ZWQgdG8gZG8g
dGhhdD8gIE9yIGhlYXJkIGZyb20gYW55b25lIGVsc2Ugd2hvIGRpZD8NCg0KQ29udGFpbmVyIHNo
dXRkb3duIHdpbGwgd2FudCB0byBjbGVhciBvdXQgYW55IGxpc3RlbmVyDQp0aGF0IG1pZ2h0IGhh
dmUgYmVlbiBjcmVhdGVkIGR1cmluZyB0aGUgY29udGFpbmVyJ3MNCmxpZmV0aW1lLiBIb3cgaXMg
dGhhdCBkb25lIHRvZGF5PyBJcyB0aGF0IHNpbXBseSBoYW5kbGVkDQpieSBuZXQgbmFtZXNwYWNl
IHRlYXItZG93bj8NCg0KDQo+Pj4gRG8gd2UgZXZlciB3YW50L25lZWQgdG8gcmVtb3ZlIGxpc3Rl
bmluZyBzb2NrZXRzPw0KPj4+IE5vcm1hbCBwcmFjdGljZSB3aGVuIG1ha2luZyBhbnkgY2hhbmdl
cyBpcyB0byBzdG9wIGFuZCByZXN0YXJ0IHdoZXJlDQo+Pj4gInN0b3AiIHJlbW92ZXMgYWxsIHNv
Y2tldHMsIHVuZXhwb3J0cyBhbGwgZmlsZXN5c3RlbXMsIGRpc2FibGVzIGFsbA0KPj4+IHZlcnNp
b25zLg0KPj4gDQo+PiANCj4+IA0KPj4gLS0NCj4+IENodWNrIExldmVyDQoNCg0KLS0NCkNodWNr
IExldmVyDQoNCg0K

