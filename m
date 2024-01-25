Return-Path: <linux-nfs+bounces-1328-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D4683B6F1
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 02:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C997F1F21ED2
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 01:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2C4111A8;
	Thu, 25 Jan 2024 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VOpLRdEd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BP0WN8KV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47754111AB
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147704; cv=fail; b=B08ZueBCq+lTOPKG3VdxQjoHfX+wDO9fQob6/1guR+yOdXZt8CyFRS8JgDMAjzIjnUz5Q7YrX/lT+t+7R2MzHubIkwq6PoSnMf86WKX9mLafyW9DNd22xs8stA9F5ZkFDii20QXy+eGOH00O4nQ8nBvmbglSMRxMG2Woe75C6uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147704; c=relaxed/simple;
	bh=VbC9mJB9JL7PyE2tDJhi8oleJPbHeTqi96fGCMy/cAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=soKcocxIyl/FkYgSHkSq6LdFi8W1AXisysZTtujsnIUUFnNQ4EXV8MjkKuPQKM0F0XuBiRxDa3BiXCpWrQUH7EDJB3TsmgIk3lztF82LacL44AmLx9MsIqwKmQRxr+BKd9HrRQC3C9rwhnR76S+Y6uzzmk69m+rrjAqWwegurPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VOpLRdEd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BP0WN8KV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OLc5S1008135;
	Thu, 25 Jan 2024 01:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VbC9mJB9JL7PyE2tDJhi8oleJPbHeTqi96fGCMy/cAg=;
 b=VOpLRdEdJPTk3a9zdvXgG5BtKw2mvUxonkFFmPX8CSGbe6d8bWHn/ZtiTQ84QyX9/zZ0
 wbLjeS1kmeDmtM1IWWpBu+AAKlfHnuU9pRkgmWEs5SrSqoFCKauPU7AqbUBcnS61ZO0l
 60mEceUf5tQatsUvxc8ryQqtcJZcwiDQdhj4mQskhT9jBQY27Mf9Gtb7gdTB8gNLQ54N
 Jzqw7shuhvBTMhq29b3ybdqgZQGuEWgy2aDoKZtx9wFSv9ZbJsm1BUqEZV+Sbwd6hwJf
 0u0D5+hSGp4G8CUWiBZ9aoOL8j/iAh0+lKkmili73qg/E7jwObAipNgiWibfqFm/KXbk WA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy5cs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 01:54:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40P1Cvs4014644;
	Thu, 25 Jan 2024 01:54:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs373mwky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 01:54:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz0Z/qSyFNeKhTi4h1QWIwelIjLRayFYQcDLNY4QCGouC1hduBdJoi8V38WosKSZ/4nYvyYpREqC2hY4hSrhJ5y5zrXxMf0n6nmRf+6N5j9WiLZjddEzsJ/LMAeOuNeiDHiAUUFxT1WXDM8+c9+YDWG6carBdYqUdMui7NQzZ5YO4ld0m3iandBwITfzEdnPPFOHwTab4/+PfG+EdydMyKhDnDUzi7lXn743tSy9Tn8UaMLNsloOmlzDumu1H8TJ9q5S/h4iimS79y4gqORDHX2Vw+D1YqNXKM8YvMe7OkeKa33WiDVfzxZReVLDCEUro1SY7lVTxd0zS63fxVE3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbC9mJB9JL7PyE2tDJhi8oleJPbHeTqi96fGCMy/cAg=;
 b=KzcCnesoaUQ6vzc/cjV1cDMWnXACSMstU7LHWEO2blTQ/fEQx0BTPZhMeu5SvYtlAV7GSQZHHyZCVAsZQgtjby7OZ+++rJ4xrGv3RYvTrIKcmlmflt6LG9+St9vNhbGspHk6th7mIckC503zPF5dTyL8LAkBjwhTcg4vd4S3ce4Knv7BZQ1fL44kNMawcGTCMptYGwxYfgwFzTAzVSfJRwXlkyCiV4EMzRpMd20RzyuzrVsJooWxTfnqfoHrwcp/KoFzztSPyu7LkPXrHkZuSl4GlwHDrbNQ5YfAR1lNP5QbQLjJYnxiUkxvTI8yPsQvN0+4andGiQdyeKz8r6xaNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbC9mJB9JL7PyE2tDJhi8oleJPbHeTqi96fGCMy/cAg=;
 b=BP0WN8KV5y4kMNHUuadfVjy9GbAUrLKBr7qwC9NObcjPfyiHCKwVhP4+cP9iTaTCaCssNfI13oosRJuUsJgBbS69mqHsItmcYvSFthP1T9GPi0nyJcqiSQ04W2c0RYFzZz1yCPJrWxKSt63Yc8XFCxA9LiET3QixLLIu5D/35Pk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5165.namprd10.prod.outlook.com (2603:10b6:5:297::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 01:54:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 01:54:53 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Josef Bacik <josef@toxicpanda.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 2/2] nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
Thread-Topic: [PATCH 2/2] nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
Thread-Index: 
 AQHaTvzEoihj7BzV4Eq9C9fkK344wLDpatEAgAAcLgCAAAxVAIAABeSAgAAGgICAAAGlAIAABTcAgAAeXwA=
Date: Thu, 25 Jan 2024 01:54:53 +0000
Message-ID: <BF83705F-89EE-43D4-A0B3-21B05B98FCF5@oracle.com>
References: <cover.1706124811.git.josef@toxicpanda.com>
 <71058c29683d44644aba8ab295fa028ee41365a8.1706124811.git.josef@toxicpanda.com>
 <ZbFzxmV6zgi/TACb@tissot.1015granger.net>
 <20240124221258.GA1243606@perftesting>
 <e724a63a63f30f927f1780ad9018811bc45bf4e1.camel@kernel.org>
 <20240124231811.GA1287448@perftesting>
 <5f264d8d506835c424d5cccfc55980fa2893337e.camel@kernel.org>
 <ZbGhiCxgpeSNi+Fw@tissot.1015granger.net>
 <7a9e9979c5e207713673bbec827e61c1b337a91c.camel@kernel.org>
In-Reply-To: <7a9e9979c5e207713673bbec827e61c1b337a91c.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5165:EE_
x-ms-office365-filtering-correlation-id: 24fc88d6-45d2-4730-ed83-08dc1d489f88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AAlX8tTP0YjauXlzu/nxPAWV/NSElfMwmGJWJ0HgLgKqnpfiObunBU7X8JCCabrpkTt8vddrVP9BGcsAN7fxefNs49dXTh30/ihlEHcewNN814QmwUipsdgBxVAuDIwi/3OSbDWSdp51LGfWX5n2Tt4cYki0JY7J+uYXmob94XPb0T0Fl8Cz450DN3CmK8e9WUvZBDpOmB4m4p/shmJyHIYM3s1K8aL9Xjk4Jy5ejxFwBf+HJdqvH6iSKh3AAzRHJXQpAisHgTNdhyCd95+c+JLlruFoJu7He3l51uIt+PmyNk5aU2k+W3sEy7/2OXLG7YBvomlPi8oFoYAypznuao+X7HLILIFDuxwBdFD26MEBmb53Q8mAjQ/8AuQ5343+/ZxeqDm+uainJKBEgDVbvY1xtml09ipdWGwCy9/946GanRm+6UztvcRnI+W5Bw1Kui0jn7wS4KgR5sfGfXCHeT9F422syM7BtUKCmZ0hWfwFIFj7SiwxjbBTZE2llPGjTxmJTdT4gnGOBkE09WBVmodhNKj6eYP/X6MAEROkvZ7MaLjstk1LbF0b/bTzpmu7vKmB0D5/KY9Zyr1h1RcOTl+JHRpvP6W++FNq6Ft/LCY6fFQAeWmEMZFh2oMXiW8Kmp1aLpoboG1vlWepkHhZMQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(41300700001)(6512007)(26005)(2616005)(38100700002)(122000001)(4326008)(8676002)(8936002)(5660300002)(2906002)(478600001)(6486002)(6506007)(53546011)(71200400001)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(6916009)(316002)(91956017)(38070700009)(36756003)(86362001)(33656002)(66899024)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YTBsV0FFekljWmhXRFJsVTJ1enkzQVpHcGJCUDFJeENVelN0L0ZkMzlrK04y?=
 =?utf-8?B?ZTI0YXRjQzkxQXNqSHRQTjQ2QkxjSldtM3pMdXhUSGw3ams0V1hYaGZrQUpi?=
 =?utf-8?B?cmE0VDlRUTZMS1JvSU16ck5kNHk0alFsWDJ6cUd3aWV1L0dkdGk1bFFkd0hV?=
 =?utf-8?B?dC9xR3FoSkorc0FvMklWZXlIckVYVm4xeVQwSnNkRkNtS1QrczZaWmlJMGZC?=
 =?utf-8?B?VUQ2YTdHdldxWStHZ3dDdGJzRGFmcGxIZ29iV2MzS1k2eGtsd21Xbk5EeEdm?=
 =?utf-8?B?SDUzQzZXSjRZZFdsZ3h3MVlFQ3pIeUlVaTJiRS9GejRFOFkvNFZoRlRVV1ZO?=
 =?utf-8?B?bldIcDZ6dDVGSTRBazFBNjZObzdMVThGa0l5UTlmQlkyZ0lLVEhua1k0V2FH?=
 =?utf-8?B?MFRNdytPYk95K2ZqV2g2UlREbkNUK2w1eXFLbFV6TEtEQWdjRFppUmMyWm1q?=
 =?utf-8?B?ZU4xcEppcXkyWTV4WUh6UG0waVR3T093cTFYSmViN3l5NFlERjlNeWpqQlVv?=
 =?utf-8?B?VVFQS3RiZzg4bmdpeDUySVNNVlpycGhxbk9CUjl1WFlZMEFiZXVTMmxaeDdI?=
 =?utf-8?B?Z3JLc0owNlFMSEZjeURXZVhGTHptWnp2aTVYTGRPQWZ3MnNoZHZmMHZpNURv?=
 =?utf-8?B?ZG1JTUNZd0pTd2VlQXc3TUdtdzFCb0dvVkt0VXBXVWQ1bXhDZXRhTkhrQmt2?=
 =?utf-8?B?dVVoUWY3MEN1c1NBVlY3THRjVG95bEE0TlVCZ2c4eHJTSWJtMlp4WVorTWhh?=
 =?utf-8?B?SmphcE5qeGtSWnJOanR4MVR0dWRmT1h6WEo5SWRhWUpLdTNNcm9sbm95QUts?=
 =?utf-8?B?TklLZEZFQW1BTWJ6SFpKQlpUVURQdU5iMDA1Mnhna0VDUFR4OTR6clFhcXRF?=
 =?utf-8?B?Wk1qWXZPZUdqVVdaamF1dzlCWXhKNGFNYkk1UExYK3I5QTZORFhRaG5wQ1lD?=
 =?utf-8?B?YWpqK1BaUmFWUklndEhydXUwcElZRW1HbGtSbDZiWkppbHlndXJaUWxOeGFo?=
 =?utf-8?B?SEFCZlY5WGhWbENPTXZNbWRNUnpqc0pLZDV1Tit5bDlTSTNvNnFjUFBtRmdu?=
 =?utf-8?B?c000N1kzci82RmtJclFKbk5IaWF0SU1iOSt3d1lMOWVVbzBINllhYXM3UUlJ?=
 =?utf-8?B?Sm42VHNZS1JWZFQ4VngwWEVrOEcrYmJBTyt0SjlQZ3BUY1UzTFk5MzJEbUwz?=
 =?utf-8?B?eDFxbVdEWURZSGFxQmYrMEt1WTFMR0lSU3JPdUpkdHdLVVdFdHMvWmdENDhV?=
 =?utf-8?B?a05YMllDOHl5b1Y4NjhCTG9tZTdaeVJTRzF0cWJ2SHk2d1hDQm5qNStIdTJt?=
 =?utf-8?B?eEs1TzJuTm9sMHhyWU84eG12eTluZkxJeVVucXFzdjhnNWdqbEZqaENzK2U3?=
 =?utf-8?B?S3dQMVVYN2FBd2NXQnVNeHJTU1YyV2FLT3BkSy96bThTb2FkMGVqTm41YnVS?=
 =?utf-8?B?VjdUWG5vUjdrZERIZ24rSEFUZWJib05HZTVEbWJjenc5N21lNEh1R0lHS1Ew?=
 =?utf-8?B?OHl4ZjJjdnFodXEwaWVUVFlYQ284a0JnTXVuL3V0NVpHdCtacXhRTjdjYmg3?=
 =?utf-8?B?Ry9vRUh3Q0d3ek9zRkFTUTJFZEdrQWo0aEJaT25xYjNLVHByazlMSGxqUG1H?=
 =?utf-8?B?TWlDcVh6MFZnK052U25pdTgwa2xZeE1KcENCU1l6UEtEQmthNW1aZEtjZURT?=
 =?utf-8?B?WTFndWhSMHc0UUdnNUxIUUNZWXJ6ZUFYSjRHV1RodkZuTGpla0hMYmwzWHA3?=
 =?utf-8?B?V0gzYWUrYzJJZWdxWU1MTVBUak1MaE03eTczWS95bHNXYVd0R2RmZEw1LzYw?=
 =?utf-8?B?MTVpNm1na1lObUZJUitUbjM2MTdjbHk4NVl6MGg2Mm1hUkRoUDdkai9yRnM2?=
 =?utf-8?B?cjYxUmxacWNzSFNsS2N4eCtOMkcyRldjWFNiYXhacEpGNXJSTUhpZVdzcDg4?=
 =?utf-8?B?RzEzb2hDTlBnamRNMC9QUkxnY09mRTcwaWlHZmtIZllCeFJBN1gyTDRvclAv?=
 =?utf-8?B?Z0s2bDMySmVhN0kyRUZGWnRCdWJncWNydlUvNHA5MGl5Y0VqaStGelZvZEFL?=
 =?utf-8?B?aENqZ2xobUZhWkFPYW5QazVaMVUzWFYvSVBGOFJFS1IyWlJwdWVVc1hYeEgx?=
 =?utf-8?B?bEtjakJoOW9jai9EWFZxZ2tCOFQvT2M0ck16YUlEZjA3cngyUGY1RHR4dkJL?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <823FAF11B2F13845AE4730F8E59B5A91@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gQmuByd7c1P9ihGJYKVLhuy9MhLt+pMeEqfBzsGUd9Rn0K6F9GN6DPAxmWL/Ek17tQz/4Lfa1Bls0PDrPECkyAka6/q8Wq2rXubjCNMQNYoG51Nb9+DV6w7K7R/kgNTGLRxxIbR4WLbE98oE0khTXTug3m0t5qMTyhPgIxo4i6JO6qRYOADRu5oyrk5yTGFhFL+vBrlfg5W5dHFtJiQyEh2RI2KKG1hxmEGfFPuREP0GWA9R1MnjbYK6n8posSrYBEd+4eKXL2w1LgxFE02C7HTDP7gOYUQ/Doew0d1uK4aGqfi7rSjYqhEjm+ZRhbW30aX88gmA3roy/CrahjPJ9OVQr4JTMpU3QMm3e3i01LGGJkrCdibczUSN8MGwg6SPxSZyXzjqzGmviQebfgCGmQPLXfC2vyUVZEVWj0vtUtMjNnP1DkyAyEzN5V4WuscJSo5K4QGcinAx3PiiEh7kjgRg2E6JbHjJTG3n5WqtJQ3rtZQhbBAMnqYylxBftZEvYjb1c5G6um4W3+Lh74SreIXsQnQWu/Pimg0ajeWTjqZnk1mGSEbl8j+4sgrxeczvkcTrkd7XuaadzcVHm09OiqwnCYVUnK8jFLYg50GfurY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fc88d6-45d2-4730-ed83-08dc1d489f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 01:54:53.1053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HlMoedrS/bzrawpPmYVWCDpuaKGvkVkFp2kBC9Hnws3ce13nuSd7szXXA2s0PIq2+mFsCMHJnRj1HWDozcuFhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250012
X-Proofpoint-ORIG-GUID: tbYUlHI4wPws2o1LMEWoViF-HUqPFjoj
X-Proofpoint-GUID: tbYUlHI4wPws2o1LMEWoViF-HUqPFjoj

DQoNCj4gT24gSmFuIDI0LCAyMDI0LCBhdCA3OjA24oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCAyMDI0LTAxLTI0IGF0IDE4OjQ3IC0w
NTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4+IE9uIFdlZCwgSmFuIDI0LCAyMDI0IGF0IDA2OjQx
OjI3UE0gLTA1MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPj4+IE9uIFdlZCwgMjAyNC0wMS0yNCBh
dCAxODoxOCAtMDUwMCwgSm9zZWYgQmFjaWsgd3JvdGU6DQo+Pj4+IE9uIFdlZCwgSmFuIDI0LCAy
MDI0IGF0IDA1OjU3OjA2UE0gLTA1MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPj4+Pj4gT24gV2Vk
LCAyMDI0LTAxLTI0IGF0IDE3OjEyIC0wNTAwLCBKb3NlZiBCYWNpayB3cm90ZToNCj4+Pj4+PiBP
biBXZWQsIEphbiAyNCwgMjAyNCBhdCAwMzozMjowNlBNIC0wNTAwLCBDaHVjayBMZXZlciB3cm90
ZToNCj4+Pj4+Pj4gT24gV2VkLCBKYW4gMjQsIDIwMjQgYXQgMDI6Mzc6MDBQTSAtMDUwMCwgSm9z
ZWYgQmFjaWsgd3JvdGU6DQo+Pj4+Pj4+PiBXZSBhcmUgcnVubmluZyBuZnNkIHNlcnZlcnMgaW5z
aWRlIG9mIGNvbnRhaW5lcnMgd2l0aCB0aGVpciBvd24gbmV0d29yaw0KPj4+Pj4+Pj4gbmFtZXNw
YWNlLCBhbmQgd2Ugd2FudCB0byBtb25pdG9yIHRoZXNlIHNlcnZpY2VzIHVzaW5nIHRoZSBzdGF0
cyBmb3VuZA0KPj4+Pj4+Pj4gaW4gL3Byb2MuICBIb3dldmVyIHRoZXNlIGFyZSBub3QgZXhwb3Nl
ZCBpbiB0aGUgcHJvYyBpbnNpZGUgb2YgdGhlDQo+Pj4+Pj4+PiBjb250YWluZXIsIHNvIHdlIGhh
dmUgdG8gYmluZCBtb3VudCB0aGUgaG9zdCAvcHJvYyBpbnRvIG91ciBjb250YWluZXJzDQo+Pj4+
Pj4+PiB0byBnZXQgYXQgdGhpcyBpbmZvcm1hdGlvbi4NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gU2Vw
YXJhdGUgb3V0IHRoZSBzdGF0IGNvdW50ZXJzIGluaXQgYW5kIHRoZSBwcm9jIHJlZ2lzdHJhdGlv
biwgYW5kIG1vdmUNCj4+Pj4+Pj4+IHRoZSBwcm9jIHJlZ2lzdHJhdGlvbiBpbnRvIHRoZSBwZXJu
ZXQgb3BlcmF0aW9ucyBlbnRyeSBhbmQgZXhpdCBwb2ludHMNCj4+Pj4+Pj4+IHNvIHRoYXQgdGhl
c2Ugc3RhdHMgY2FuIGJlIGV4cG9zZWQgaW5zaWRlIG9mIG5ldHdvcmsgbmFtZXNwYWNlcy4NCj4+
Pj4+Pj4gDQo+Pj4+Pj4+IE1heWJlIEkgbWlzc2VkIHNvbWV0aGluZywgYnV0IHRoaXMgbG9va3Mg
bGlrZSBpdCBleHBvc2VzIHRoZSBnbG9iYWwNCj4+Pj4+Pj4gc3RhdCBjb3VudGVycyB0byBhbGwg
bmV0IG5hbWVzcGFjZXMuLi4/IElzIHRoYXQgYW4gaW5mb3JtYXRpb24gbGVhaz8NCj4+Pj4+Pj4g
QXMgYW4gYWRtaW5pc3RyYXRvciBJIG1pZ2h0IGJlIHN1cnByaXNlZCBieSB0aGF0IGJlaGF2aW9y
Lg0KPj4+Pj4+PiANCj4+Pj4+Pj4gU2VlbXMgbGlrZSB0aGlzIHBhdGNoIG5lZWRzIHRvIG1ha2Ug
bmZzZHN0YXRzIGFuZCBuZnNkX3N2Y3N0YXRzIGludG8NCj4+Pj4+Pj4gcGVyLW5hbWVzcGFjZSBv
YmplY3RzIGFzIHdlbGwuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+PiBJJ3Zl
IGdvdCB0aGUgcGF0Y2hlcyB3cml0dGVuIGZvciB0aGlzLCBidXQgSSd2ZSBnb3QgYSBxdWVzdGlv
bi4gIFRoZXJlJ3MgYSANCj4+Pj4+PiANCj4+Pj4+PiBzdmNfc2VxX3Nob3coc2VxLCAmbmZzZF9z
dmNzdGF0cyk7DQo+Pj4+Pj4gDQo+Pj4+Pj4gaW4gbmZzZC9zdGF0cy5jLiAgVGhpcyBhcHBlYXJz
IHRvIGJlIGFuIGVtcHR5IHN0cnVjdCwgdGhlcmUncyBub3RoaW5nIHRoYXQNCj4+Pj4+PiB1dGls
aXplcyBpdCwgc28gdGhpcyBpcyBhbHdheXMgZ29pbmcgdG8gcHJpbnQgMCByaWdodD8gIFRoZXJl
J3MgYSBzdmNfaW5mbyBpbg0KPj4+Pj4+IHRoZSBuZnNkX25ldCwgYW5kIHRoYXQgc3RhdHMgYmxv
Y2sgYXBwZWFycyB0byBnZXQgdXBkYXRlZCBwcm9wZXJseS4gIFNob3VsZCBJDQo+Pj4+Pj4gcHJp
bnQgdGhpcyBvdXQgaGVyZT8gIEkgZG9uJ3Qgc2VlIGFueXdoZXJlIHdlIGdldCB0aGUgcnBjIHN0
YXRzIG91dCBvZiBuZnNkLCBhbQ0KPj4+Pj4+IEkgbWlzc2luZyBzb21ldGhpbmc/ICBJIGRvbid0
IHdhbnQgdG8gcmlwIG91dCBzdHVmZiB0aGF0IEkgZG9uJ3QgcXVpdGUNCj4+Pj4+PiB1bmRlcnN0
YW5kLiAgVGhhbmtzLA0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+PiBuZnNkX3N2Y3N0
YXRzIGVuZHMgdXAgYmVpbmcgdGhlIHN2X3N0YXRzIGZvciB0aGUgbmZzZCBzZXJ2aWNlLiBUaGUg
UlBDDQo+Pj4+PiBjb2RlIGhhcyBzb21lIGNvdW50ZXJzIGluIHRoZXJlIGZvciBjb3VudGluZyBk
aWZmZXJlbnQgc29ydHMgb2YgbmV0IGFuZA0KPj4+Pj4gcnBjIGV2ZW50cyAoc2VlIHN2Y19wcm9j
ZXNzX2NvbW1vbiwgYW5kIHNvbWUgb2YgdGhlIHJlY3YgYW5kIGFjY2VwdA0KPj4+Pj4gaGFuZGxl
cnMpLiAgSSB0aGluayBuZnNzdGF0KDgpIG1heSBmZXRjaCB0aGF0IGluZm8gdmlhIHRoZSBhYm92
ZQ0KPj4+Pj4gc2VxZmlsZSwgc28gaXQncyBkZWZpbml0ZWx5IG5vdCB1bnVzZWQgKGFuZCBpdCBz
aG91bGQgYmUgcHJpbnRpbmcgbW9yZQ0KPj4+Pj4gdGhhbiBqdXN0IGEgJzAnKS4NCj4+Pj4gDQo+
Pj4+IEFoaGgsIEkgbWlzc2VkIHRoaXMgYml0DQo+Pj4+IA0KPj4+PiBzdHJ1Y3Qgc3ZjX3Byb2dy
YW0gICAgICAgICAgICAgIG5mc2RfcHJvZ3JhbSA9IHsNCj4+Pj4gI2lmIGRlZmluZWQoQ09ORklH
X05GU0RfVjJfQUNMKSB8fCBkZWZpbmVkKENPTkZJR19ORlNEX1YzX0FDTCkNCj4+Pj4gICAgICAg
IC5wZ19uZXh0ICAgICAgICAgICAgICAgID0gJm5mc2RfYWNsX3Byb2dyYW0sDQo+Pj4+ICNlbmRp
Zg0KPj4+PiAgICAgICAgLnBnX3Byb2cgICAgICAgICAgICAgICAgPSBORlNfUFJPR1JBTSwgICAg
ICAgICAgLyogcHJvZ3JhbSBudW1iZXIgKi8NCj4+Pj4gICAgICAgIC5wZ19udmVycyAgICAgICAg
ICAgICAgID0gTkZTRF9OUlZFUlMsICAgICAgICAgIC8qIG5yIG9mIGVudHJpZXMgaW4NCj4+Pj4g
bmZzZF92ZXJzaW9uICovDQo+Pj4+ICAgICAgICAucGdfdmVycyAgICAgICAgICAgICAgICA9IG5m
c2RfdmVyc2lvbiwgICAgICAgICAvKiB2ZXJzaW9uIHRhYmxlICovDQo+Pj4+ICAgICAgICAucGdf
bmFtZSAgICAgICAgICAgICAgICA9ICJuZnNkIiwgICAgICAgICAgICAgICAvKiBwcm9ncmFtIG5h
bWUgKi8NCj4+Pj4gICAgICAgIC5wZ19jbGFzcyAgICAgICAgICAgICAgID0gIm5mc2QiLCAgICAg
ICAgICAgICAgIC8qIGF1dGhlbnRpY2F0aW9uIGNsYXNzDQo+Pj4+ICovDQo+Pj4+ICAgICAgICAu
cGdfc3RhdHMgICAgICAgICAgICAgICA9ICZuZnNkX3N2Y3N0YXRzLCAgICAgICAvKiB2ZXJzaW9u
IHRhYmxlICovDQo+Pj4+ICAgICAgICAucGdfYXV0aGVudGljYXRlICAgICAgICA9ICZzdmNfc2V0
X2NsaWVudCwgICAgICAvKiBleHBvcnQgYXV0aGVudGljYXRpb24NCj4+Pj4gKi8NCj4+Pj4gICAg
ICAgIC5wZ19pbml0X3JlcXVlc3QgICAgICAgID0gbmZzZF9pbml0X3JlcXVlc3QsDQo+Pj4+ICAg
ICAgICAucGdfcnBjYmluZF9zZXQgICAgICAgICA9IG5mc2RfcnBjYmluZF9zZXQsDQo+Pj4+IH07
DQo+Pj4+IA0KPj4+PiBhbmQgc28gbmZzZF9zdmNzdGF0cyBkZWZpbml0ZWx5IGlzIGdldHRpbmcg
dXNlZC4NCj4+Pj4gDQo+Pj4+PiANCj4+Pj4+IHN2Y19pbmZvIGlzIGEgY29tcGxldGVseSBkaWZm
ZXJlbnQgdGhpbmc6IGl0J3MgYSBjb250YWluZXIgZm9yIHRoZQ0KPj4+Pj4gc3ZjX3NlcnYuLi5z
byBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHlvdXIgcXVlc3Rpb24/DQo+Pj4+IA0KPj4+PiBJ
IHdhcyBqdXN0IGNvbmZ1c2VkLCBhbmQgc3RpbGwgYW0gYSBsaXR0bGUgYml0Lg0KPj4+PiANCj4+
Pj4gVGhlIGNvdW50ZXJzIGFyZSBlYXN5LCBJIHB1dCB0aG9zZSBpbnRvIHRoZSBuZnNkX25ldCBz
dHJ1Y3QgYW5kIG1ha2UgZXZlcnl0aGluZw0KPj4+PiBtZXNzIHdpdGggdGhvc2UgY291bnRlcnMg
YW5kIHJlcG9ydCB0aG9zZSBmcm9tIHByb2MuDQo+Pj4+IA0KPj4+PiBIb3dldmVyIHRoZSBuZnNk
X3N2Y3N0YXRzIGFyZSBpbiB0aGlzIHN2Y19wcm9ncmFtIHRoaW5nLCB3aGljaCBhcHBlYXJzIHRv
IG5lZWQNCj4+Pj4gdG8gYmUgZ2xvYmFsPyAgT3IgZG8gSSBuZWVkIHRvIG1ha2UgaXQgcGVyIG5l
dCBhcyB3ZWxsPyAgT3IgZG8gSSBuZWVkIHRvIGRvDQo+Pj4+IHNvbWV0aGluZyBjb21wbGV0ZWx5
IGRpZmZlcmVudCB0byB0cmFjayB0aGUgcnBjIHN0YXRzIHBlciBuZXR3b3JrIG5hbWVzcGFjZT8N
Cj4+PiANCj4+PiBNYWtpbmcgdGhlIHN2Y19wcm9ncmFtIHBlci1uZXQgaXMgdW5uZWNlc3Nhcnkg
Zm9yIHRoaXMgKGFuZCBwcm9iYWJseSBub3QNCj4+PiBkZXNpcmFibGUpLiBUaGF0IHN0cnVjdHVy
ZSBzb3J0IG9mIGRlc2NyaWJlcyB0aGUgbmZzZCBycGMgInByb2dyYW0iIGFuZA0KPj4+IHRoYXQg
aXMgcHJldHR5IG11Y2ggdGhlIHNhbWUgYmV0d2VlbiBjb250YWluZXJzLg0KPj4gDQo+PiBNYXli
ZSB3ZSB3YW50IHBlci1uYW1lc3BhY2Ugc3ZjX3Byb2dyYW1zLiBTb21lIFJQQyBwcm9ncmFtcyB3
aWxsDQo+PiBiZSByZWdpc3RlcmVkIGluIHNvbWUgbmFtZXNwYWNlcywgc29tZSBpbiBvdGhlcnM/
IFRoYXQgbWlnaHQgYmUNCj4+IHRoZSBzaW1wbGVzdCBhcHByb2FjaC4NCj4+IA0KPiANCj4gVGhh
dCBzZWVtcyBsaWtlIGEgbXVjaCBoZWF2aWVyIGxpZnQsIGFuZCBJJ20gbm90IHN1cmUgSSBzZWUg
dGhlIGJlbmVmaXQuDQo+IEhlcmUncyBuZnNkX3Byb2dyYW0gdG9kYXk6DQo+IA0KPiBzdHJ1Y3Qg
c3ZjX3Byb2dyYW0gICAgICAgICAgICAgIG5mc2RfcHJvZ3JhbSA9IHsNCj4gI2lmIGRlZmluZWQo
Q09ORklHX05GU0RfVjJfQUNMKSB8fCBkZWZpbmVkKENPTkZJR19ORlNEX1YzX0FDTCkNCj4gICAg
ICAgIC5wZ19uZXh0ICAgICAgICAgICAgICAgID0gJm5mc2RfYWNsX3Byb2dyYW0sDQo+ICNlbmRp
Zg0KPiAgICAgICAgLnBnX3Byb2cgICAgICAgICAgICAgICAgPSBORlNfUFJPR1JBTSwgICAgICAg
ICAgLyogcHJvZ3JhbSBudW1iZXIgKi8NCj4gICAgICAgIC5wZ19udmVycyAgICAgICAgICAgICAg
ID0gTkZTRF9OUlZFUlMsICAgICAgICAgIC8qIG5yIG9mIGVudHJpZXMgaW4gbmZzZF92ZXJzaW9u
ICovDQo+ICAgICAgICAucGdfdmVycyAgICAgICAgICAgICAgICA9IG5mc2RfdmVyc2lvbiwgICAg
ICAgICAvKiB2ZXJzaW9uIHRhYmxlICovDQo+ICAgICAgICAucGdfbmFtZSAgICAgICAgICAgICAg
ICA9ICJuZnNkIiwgICAgICAgICAgICAgICAvKiBwcm9ncmFtIG5hbWUgKi8NCj4gICAgICAgIC5w
Z19jbGFzcyAgICAgICAgICAgICAgID0gIm5mc2QiLCAgICAgICAgICAgICAgIC8qIGF1dGhlbnRp
Y2F0aW9uIGNsYXNzICovDQo+ICAgICAgICAucGdfc3RhdHMgICAgICAgICAgICAgICA9ICZuZnNk
X3N2Y3N0YXRzLCAgICAgICAvKiB2ZXJzaW9uIHRhYmxlICovDQo+ICAgICAgICAucGdfYXV0aGVu
dGljYXRlICAgICAgICA9ICZzdmNfc2V0X2NsaWVudCwgICAgICAvKiBleHBvcnQgYXV0aGVudGlj
YXRpb24gKi8NCj4gICAgICAgIC5wZ19pbml0X3JlcXVlc3QgICAgICAgID0gbmZzZF9pbml0X3Jl
cXVlc3QsDQo+ICAgICAgICAucGdfcnBjYmluZF9zZXQgICAgICAgICA9IG5mc2RfcnBjYmluZF9z
ZXQsDQo+IH07DQo+IA0KPiBBbGwgb2YgdGhhdCBzZWVtcyBmYWlybHkgY29uc3RhbnQgYWNyb3Nz
IGNvbnRhaW5lcnMuIFRoZSBtYWluIGV4Y2VwdGlvbg0KPiBpcyB0aGUgc3ZjX3N0YXRzLCB3aGlj
aCBkb2VzIG5lZWQgdG8gYmUgcGVyLXByb2dyYW0gYW5kIHBlci1uZXQsIGF0DQo+IGxlYXN0IGZv
ciBuZnNkLg0KDQpUaGlzIHdvdWxkIGJlIHRoZSBiZW5lZml0IHJpZ2h0IGhlcmU6IHRoZSBzdGF0
cyBuZWVkIHRvIGJlIG1hdHJpeGVkDQpwZXIgcHJvZ3JhbSBhbmQgcGVyIG5ldC4gVGhlIHN0YXRz
IGFuZCB0aGUgcHJvZ3JhbSAoc2V0IG9mIFJQQw0KcHJvY2VkdXJlcykgYXJlIHByZXR0eSB0aWdo
dGx5IGludGVyY29ubmVjdGVkLg0KDQpTb21lIG5hbWVzcGFjZXMgbWlnaHQgd2FudCBORlN2MiBv
ciBORlN2Mywgc29tZSBtaWdodCB3YW50IE5GU3Y0IG9ubHkuDQoNCkJ1dCBJIGRvbid0IGhhdmUg
YSBzdHJvbmcgb3BpbmlvbiBhYm91dCBpdCBhdCB0aGlzIHBvaW50LiBZb3UgY291bGQNCmJlIHJp
Z2h0IHRoYXQgdGhpcyB3b3VsZCBiZSB0aGUgbW9yZSBvYnR1c2UgYXBwcm9hY2guIFRoZXJlIGlz
IG9uZQ0KZml4ZWQgZGVmaW5pdGlvbiBmb3IgZWFjaCBSUEMgcHJvZ3JhbSwgc28gaGF2aW5nIG9u
ZSBzdmNfcHJvZ3JhbQ0KcGVyIFJQQyBwcm9ncmFtLCBhbmQgaGF2aW5nIGVhY2ggbGl2ZSBpbiBn
bG9iYWwgbW9kdWxlIG1lbW9yeSwgaXMNCnNlbnNpYmxlLg0KDQpUaGUgd2F5IHN0YXRzIHdvcmsg
bm93IGlzIGZyb20gYSBsb25nLWFnbyBlcmEuDQoNCg0KPiBGV0lXLCBsb29raW5nIGF0IHRoZSBv
dGhlciBzZXJ2aWNlcyB0aGF0IHNldCBwZ19zdGF0cywgbm9uZSBvZiB0aGVtIGhhdmUNCj4gYSB3
YXkgdG8gYWN0dWFsbHkgcmVwb3J0IHRoZW0hIFRoZXkgYXJlIHdyaXRlLW9ubHkuIFdlIHNob3Vs
ZCBwcm9iYWJseQ0KPiBtYWtlIHRoZSBvdGhlcnMganVzdCBzZXQgcGdfc3RhdHMgdG8gTlVMTCBz
byB3ZSBkb24ndCBib3RoZXINCj4gaW5jcmVtZW50aW5nIG9uIHRoZW0uDQo+IA0KPiBUaGF0IHNo
b3VsZCBzaW1wbGlmeSByZXdvcmtpbmcgaG93IHRoaXMgd29ya3MgZm9yIG5mc2QgdG9vLi4uDQoN
ClRydWUsIGJ1dCBJJ3ZlIGJlZW4gdG9sZCB0aGF0IGhhdmluZyBOTE0gUlBDIHN0YXRzIGF2YWls
YWJsZSB3b3VsZCBiZQ0KaGVscGZ1bCBmb3IgZGlzdHJvIHN1cHBvcnQgdGVhbXMuIEl0IHdvdWxk
IGJlIGNvb2wgdG8gZGVsZXRlIHNvbWUgbGluZXMNCm9mIGNvZGUsIGJ1dCB3ZSBzaG91bGQgYXNr
IGFyb3VuZCBiZWZvcmUgdG9zc2luZyBvdXQgdGhpcyB1bnVzZWQNCmluZnJhc3RydWN0dXJlLg0K
DQpJbiBmYWN0LCBKb3NlZjogd2hhdCBkbyB5b3UgdGhpbms/IFdvdWxkIGhhdmluZyBOTE0gc3Rh
dHMgZm9yIHlvdXINCk5GU3YzIHNlcnZlcnMgYmUgaGVscGZ1bD8NCg0KDQotLQ0KQ2h1Y2sgTGV2
ZXINCg0KDQo=

