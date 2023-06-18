Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB637346E3
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Jun 2023 17:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjFRP7z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Jun 2023 11:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFRP7y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Jun 2023 11:59:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40ED18B;
        Sun, 18 Jun 2023 08:59:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35I6oUjo020880;
        Sun, 18 Jun 2023 15:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FSjP1foat7xk2JS9DrOVBz7SrI49zWBoZMzNlsfT/3c=;
 b=DMgWOJ8zqE0woSlDYYXsGO5kTz6yHJy+373Hl4bQcnOLWHdVcM7Y7gUytkzzQR1lxexg
 hlV0IZi8yAU0oZVTsmBfJ10c68VGCphei2dCwqh3mozXWr1aULydHDboSo5+cggOqZJl
 WAbyVvg2Z9zmeFJgbYRVACXjlzKS3tMVo16F0FC/SIL1FiCFvHOyCUsKsGAUKiFobffM
 lySdGPGtP9XebjnHfjTVyn4rYGQ1/Bn/Spko8qRkpqk4wULCBV8db+3d0nYRqosQ7rR9
 F9QIrAdJ3TpjOYfqKoag8pD7BoNoFv9AuDQvuXVYROsqw+heKdDjHofiuhvM0dmU2Waj Vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3hdam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Jun 2023 15:59:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35IBPe2E038863;
        Sun, 18 Jun 2023 15:59:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9392dhw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Jun 2023 15:59:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo4GDWHtOnaDAGoL0G4BDlY/trbpCMUlpaPNkbQPcknFzFlGTzVDW26NHTNBLiTl0QawTGPtNmYZNgs6/9fO2ZaD3k2JwqwfYpIM4UXKuN+0ZK/HIChl92kB8jTER4gWfGAiqDJdLAOdXyTl3oDLG42a7+SpcwTKwLTrPGp8WzJtjAEd+2gNJZjLCSH/iI0oS30LUpXOndrx92euZ0CXTOzlmzdcqWe0B9OAjG/BcAaPE1Zc5kkddoSl1K0Y3tMhqahIQAMUNqo8Oxvn3I7/xVmUBJeBL0VEhqE/gfWYWjxIy+kF9IlUa5vhpVG/S8rTl+rPtP3Vc4ZCr+psZOt2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSjP1foat7xk2JS9DrOVBz7SrI49zWBoZMzNlsfT/3c=;
 b=hbM80pF6FV4Dgczr8I8pDHort9uRMTtiY4V9Zq3xm1SYI6eJHfuUS/zLbWRHIj8hyqxdxym2Vf5Q2ksjMqx5iQPaRBI/Ie7DxZ6DsDwNbznMWVzdu5tLXbf1dB61XcqiPX0q680BiXiqm8C6Ocww4N2emfuZjp8KV3Fin7T73dUkim9KWP3pvnP38ZAhL0EddyQ9x88ZgldGQou3flK9IpzlKMNxN83XRtNeulnW4ojDZHvFBciNAJzqeGmNhiLSzFjksUcM8SBCYIl+fJcEVXwq7VShCwvMqA1uw0TxVlfcY/NqOY+Ro3yYp5CGISMgMhoo4ZSV7U76MA417x4cVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSjP1foat7xk2JS9DrOVBz7SrI49zWBoZMzNlsfT/3c=;
 b=OsLQQ6FbeBrlVaJrL+jyq5WzYSnXsnU7a8qua3R0Va9DUNdGU0ZP2hRrga9ca+TD/7c4h6KyzFMBTg+lN7CBPxgSoHt/KZgZa14TrEzr8v3JRyzxDLVJwM3Ww+H5HBfnPHPsCvrVY+bJ872lNVbSKVr8lNlfZejYlgEKmBM/NE8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7455.namprd10.prod.outlook.com (2603:10b6:8:161::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Sun, 18 Jun
 2023 15:59:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 15:59:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
CC:     Chuck Lever <cel@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-stable <stable@vger.kernel.org>,
        Eirik Fuller <efuller@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: move init of percpu reply_cache_stats counters back
 to nfsd_init_net
Thread-Topic: [PATCH] nfsd: move init of percpu reply_cache_stats counters
 back to nfsd_init_net
Thread-Index: AQHZoIdAK81J5DBFe0ilrwTJAM3M0K+N4NaAgAAHegCAAnkugIAAGQMAgABAI4A=
Date:   Sun, 18 Jun 2023 15:59:32 +0000
Message-ID: <9154BA25-C795-4BEF-B32D-EAB8679E9472@oracle.com>
References: <20230616191744.202292-1-jlayton@kernel.org>
 <ZIzFp3ViiU2SCi6J@manet.1015granger.net>
 <4b5063eb5a1139adc9dd4bdadde30674faee0700.camel@kernel.org>
 <d698b838-57e0-d019-a783-c229c04eeca4@leemhuis.info>
 <7d9515dbe6af110f2c32dce2b994120e4637b295.camel@kernel.org>
In-Reply-To: <7d9515dbe6af110f2c32dce2b994120e4637b295.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7455:EE_
x-ms-office365-filtering-correlation-id: a26bf091-a198-42a2-8c73-08db7015018f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hmn2fea4nfb1kotqV6zelzFTZrDoe61UsJ/UkvhqRgfua+GGxMBnWFRqy3T54xuXGd2qSdSLcMCZYWJ3qdWyXyXvzWOqeZL0b1xGJsbaYasS0db4WWoIqAF+f6adAsmXd/dZtLkzAthmN2xM6s8aRTKK386pvPOXVEJHpL+tAPN3l1jbh+M9YB3qQSSwOfWtCcUNLaqCYhjXqN4sPpGjOZAcDAv0yyVQETewNJCHZdRZMJhzGaVoOtmT6kaeyh41xTSqoGVo1kTJCwjiPn7/hkCdvi16vSjJWT/no0uyO0p1fGwg0OMB2KVZXVtl1kvZR1sHo6O79Zmrf5AtH9Fd1Hr/Qg2nxK5uSvw3rny18vsIpLQVWyVqlFDoO81oIkciTKO5OMWucVW+u4nOw9P5ElHgdr0/4B59TOqE/uIv2aPyL0xhoeEqhYfKre3XkXdiOBN0loBVcJgq1oxDnVoQmAXgP7ftUyOUDVtE4wEI1O8QavwlL172B3Kyo7+nrB4ByhHcmtJR9/wPlJTsYxp8g1HdJ1JTbcvk5U2khA6gUCE4UEXSMz9ZTyQhF2xyUhOdBW9j1G/M4sXW7FmO2xbnnO2icvdEBSxQAM9V76hJAJbDE4TlQAstmFG8kHaVDP4M3GWml7kFnSsDoGzG+dH58UaeGF8MatVJp1lX/fupOzbKbT73mWDjSHYmcFlZgdPI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39850400004)(136003)(451199021)(186003)(8676002)(8936002)(66946007)(66556008)(64756008)(66446008)(66476007)(5660300002)(76116006)(54906003)(110136005)(4326008)(71200400001)(6486002)(33656002)(316002)(38100700002)(478600001)(41300700001)(36756003)(966005)(26005)(53546011)(6506007)(6512007)(7416002)(91956017)(122000001)(38070700005)(86362001)(83380400001)(2906002)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VSUkrr2wwkJi1dAE8BC6tECIdhk9GWuTWcLAUvNFh/CCccAJcGSo0S4UC3ed?=
 =?us-ascii?Q?5EXJAESLtkrYaG/NNsB7UvA5xw4AWXnYM+TWdwaiMQrnZXgvyGsFTSuFBCQl?=
 =?us-ascii?Q?USqSzigcpSf9ofmZY1sICBRinmikBKRtxZyXBbYZ4ZpN7HJ+YOwYyYAZ2/J2?=
 =?us-ascii?Q?LX3seghvZz5U2ts0FytlABYSe8mkUgjj1hJrOlN6VmCY6+B60TNq39EEIEHK?=
 =?us-ascii?Q?LZEgdu1aNi1xwk9ccR/EaBKuinB2dnLxuybUB/+UjQAp4b3R5G0tK+kaJf3p?=
 =?us-ascii?Q?eJjMmS39M8gfoPQO3jfi25Tv73L8VQ0ezzI2e4RFtjEZZ/n5YV69h/weKXTU?=
 =?us-ascii?Q?7VgW2b+5JToZ1+bYYNTWlji/aIjzWK/Te4Iy2HT/FNIqfj7c64u1ted3MHZy?=
 =?us-ascii?Q?7sl+W4Z9HCZEbVH0+zeEmPSqHX5dgt0bQ/uvE6+9kQa0shVTmExEpbI0wxWz?=
 =?us-ascii?Q?L6l4zQNVGUErAn17vPwVNvH7B/E5MAKr7VWR0qKikrDcvyRAPnUh75wJmWC+?=
 =?us-ascii?Q?EHjUdYNlllLSW5LmOQHnMgsFNtSVsHTsk3NpSOhxz/ZIdbIfVLyQ5nzSgq/a?=
 =?us-ascii?Q?KcgybdCxVTrJbuZD3EzMQTsgikISz7EaKgU4sNaZ41B4VR0+UnEjIjgGVr8l?=
 =?us-ascii?Q?+S2+VtTXhHdV5btLZwAXD03cHXGYAFVWIfalRYlX5cOWnw0hbgNhQpgmtX9m?=
 =?us-ascii?Q?Clu8jLD1jXso98eDdRfzd9hqlQY94yOqV3hIxkJ9j8Ss8iPSsjLjgLO/fHXw?=
 =?us-ascii?Q?aQp1tTaZaAsQCFE1YkXpDsumIY1xTI9VF8jIbkQQt5bdmnYVLBmAhl0nw4Q/?=
 =?us-ascii?Q?fwUKF40zbX6UpJy0OX4yaav1yhOoAZ5PfqCN1RZ9a5hs0MRWlX5vhMQpedQF?=
 =?us-ascii?Q?63TBEVrjKW33OScRYL9g8SN2Fcu6Xbj2VlIA7Qsz12yoGUkVaRkWJYR8x5Su?=
 =?us-ascii?Q?P33GqBCO2/Ky0++kk7IoiW1j8XGGBA8zUWVM5aoYdjetYe6WTXC9gUY+l+vf?=
 =?us-ascii?Q?Qq6lq5Wu2s+MM6xqXUtTO4BFFDWwxVdmYaMF+y3CEYT7yMs/eS0m5MgMKQ+w?=
 =?us-ascii?Q?bKC4Ti9+1gbTVwEk+VMmpdqU7CNbiQyuOyBXx4cvjxJYpd7+PpBAjqmHZWls?=
 =?us-ascii?Q?DgpPwnvc+sjKSvgFCQvJMam8qGbwFAJ6+BMpOKRkz9YxZtQSEkrb49GWDHr1?=
 =?us-ascii?Q?/Fsgj2fzIYcsJYbdZikx5S4xB/5fZnJePInwaS7HoAcjpwaFNJ1E11k+/omy?=
 =?us-ascii?Q?3u92NHn44YCpn3hkV42F7T3i2X9n/3ClJ5Rgj1tL3f+d0eO7LRazb766mQFV?=
 =?us-ascii?Q?GoeUVaOtpofWpmiGngzhHuSbJIuH1mCIPCdbqOJ5hqBVkoX7n/4fofEF3mBK?=
 =?us-ascii?Q?M7svUIe7l1UBVCb/0rwXwdKz046m61AxlYAk3ad3Z1DaZLXCyXkEo4C5xFet?=
 =?us-ascii?Q?U5Td6ERfevsyhYsxFDgyE7/ruMD49go6t9HuPx5onUgYXrcrTbfzjFT3qLwT?=
 =?us-ascii?Q?LbWbO1KJiMxs96Hf8eAjRTS1wsQnWTOK9TxT6eUFknkwBNfOE1QUwGzh8tfK?=
 =?us-ascii?Q?xhNMtVOS4dRS1Q6C2xfVu+fpOVqkRwMRiRtbMo3oeKSrrzHMU0fqqGdBZWHe?=
 =?us-ascii?Q?HA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C058A2A3633C9F4B8A0272C6BA4F2B74@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Bjf9n9pLtVP7DKdslaPe4g8ZvsJO9Gp28ocjWfZ6Nx4iN9JEOcsUZdZzQxG9?=
 =?us-ascii?Q?OHa5kfwSw/ZFA9EfpyMD6IGBcFtdqbl01LvKSY9EdKSrkBPmnRRYCN6uTr1x?=
 =?us-ascii?Q?JbWapqQ9agxKmtIhh6mU8ZqSU20rvf4sY5bUH3sh1loumdbQCYsXIkGYsSu8?=
 =?us-ascii?Q?e9tYOqi9VxC7lamMDQyokRiemYlsB1TaQbjBnUxa5xXO8EDgYZ4MAqUIjL5Z?=
 =?us-ascii?Q?w/kQPtmRvSXCDn2D5pMjhCR8YNGz01eRDIp0gGDOMWF1ROCJyvd2zjAbjO3Z?=
 =?us-ascii?Q?gPGHY5pWDrJ3bSoOOh4srRcckxgCROZxt96V8S8XasAoD5UaFgtFTBjFgpIM?=
 =?us-ascii?Q?ckVTydW0eMSTkn9LiNP30s8KzFO1LW/Jkb8kbk+RR9uJ72VC1bXNsqHAaaEb?=
 =?us-ascii?Q?xY4DV8qT5r7dsv4KRzkPnb6aNX+WWu1eKEJCiGm5C+82qQfpNMq9VTENgPo1?=
 =?us-ascii?Q?uDELSiUXN1TCqNGhUm8UEUKdABmrjAYnLHadkKvkYLIW/HpG/c0gTLxAQg6F?=
 =?us-ascii?Q?4aOOflpUKEbLCdGMpW38hOZa61OiHdYGpymdnp+l9nuF+fl8NqxI1NFtnDJI?=
 =?us-ascii?Q?kxgD2YPC9gV1RTbyv+CaMO8X4p3O+SyFiRPzFt7zOd2RR2SkR4kpWqsHCjH1?=
 =?us-ascii?Q?CdvDr2QCBfHJZ85PsoxCAl6nIzgDabtTYpBPTThJypYmPFBNl5ankGUsT1cO?=
 =?us-ascii?Q?H3f+KJAVW1iu9Y2iK7crpqJRDHa+GdwsnfTwZVs8bWwLnTyoXGaD8xGOVZqB?=
 =?us-ascii?Q?Elnuw42RAsfGoQratysjnKM/hKIOzn4okINLRt1Uu/yiN8yVtfAv5/0M1EpC?=
 =?us-ascii?Q?C7C0/CqEwRUNjvj3LFCy5taOk8Kvx06jhWFJGfOfNzDKRzoHhnugFV+vT/TD?=
 =?us-ascii?Q?Ic5+Tt+mvtB7GZJizJh67i26Nw+2ElqXMGBwio1jGRM3lv6GphT3L2mr09iK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26bf091-a198-42a2-8c73-08db7015018f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2023 15:59:32.5840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDOQJa1i2mhT2gtqjMffNk4xX2e98yDZJs7y+Eg4eLtO0LJ6sYwK6VZVVXE30dhkczvWYVa1e2WiqFXC09deNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7455
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-18_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306180153
X-Proofpoint-GUID: euYk9YRwCKNGdFoXditaEdiQVftnXkws
X-Proofpoint-ORIG-GUID: euYk9YRwCKNGdFoXditaEdiQVftnXkws
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 18, 2023, at 8:09 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sun, 2023-06-18 at 12:40 +0200, Thorsten Leemhuis wrote:
>> On 16.06.23 22:54, Jeff Layton wrote:
>>> On Fri, 2023-06-16 at 16:27 -0400, Chuck Lever wrote:
>>>> Thanks Eirik and Jeff.
>>>>=20
>>>> At this point in the release cycle, I plan to apply this for the
>>>> next merge window (6.5).
>>>=20
>>> I think we should take this in sooner. This is a regression and a
>>> user-triggerable oops in the right situation. If:
>>>=20
>>> - non-x86_64 arch
>>> - /proc/fs/nfsd is mounted in the namespace
>>> - nfsd is not started in the namespace
>>> - unprivileged user calls "cat /proc/fs/nfsd/reply_cache_stats"
>>=20
>> FWIW, might be worth to simply tell Linus about it and let him decide,
>> that's totally fine and even documented in the old and the new docs for
>> handling regressions[1].
>>=20
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/comm=
it/Documentation/process/handling-regressions.rst?id=3Deed892da9cd08be76a8f=
467c600ef58716dbb4d2
>>=20
>=20
> I'd rather Chuck make the final call here.

Thanks! I feel this one needs broader testing than we can manage
in just a couple of days. If this were earlier in the -rc cycle
I would pull the patch right into 6.4-rc without hesitation. It
is obviously -rc material, but the timing is unfortunate.

I'm planning the nfsd for-6.5 pull request early in the merge
window, so practically speaking it shouldn't delay the finalized
upstream version of this patch by more than a few days.


> The original patch
> description didn't point out how easy it is to trigger a panic with
> this,

I will add that information.


> so I was hoping to convince him.

Oh, I agree it's significant. I just don't want to compound the
problem by sending a possibly-buggy patch at the last moment
in the 6.4 cycle.

When we have our shiny new CI infrastructure in place, we will
be able to move faster and with more confidence on fixes this
late in a cycle.


> To further that argument too:
>=20
> I have to wonder if this bug might cause (temporary?) memory corruption
> on x86_64. The code hits a spinlock in that struct, so there may be a
> window of time where it doesn't contain what's expected.
>=20
>>>>> Cc: stable@vger.kernel.org # v6.3+
>>>>> Fixes: f5f9d4a314da ("nfsd: move reply cache initialization into nfsd=
 startup")
>>>>=20
>>>> Why both Fixes: and Cc: stable?
>>>=20
>>> *shrug* : they mean different things. I can drop the Cc stable.
>>=20
>> Please leave it, only a stable tag ensures backporting; a fixes tag
>> alone is not enough. See [1] above or these recent messages from Greg:
>>=20
>> https://lore.kernel.org/all/2023061137-algorithm-almanac-1337@gregkh/
>> https://lore.kernel.org/all/2023060703-colony-shakily-3514@gregkh/
>=20
> Chuck and I also recently requested that the stable series not pick
> patches automatically for fs/nfsd.

To be clear, we requested that stable not pick up patches for
fs/nfsd using AUTOSEL. Basically that means stable will pick
up only fs/nfsd patches that are explicitly marked with Fixes:
or Cc:stable.


> This does need to be backported
> though, so I cc'ed stable to make that clear.

OK, I'll add the "cc: stable" back too.

My question wasn't so much a demand to drop the tag, but rather
a request for an explanation of why both were needed. I'll try
to be less terse next time.

Thorsten, if you've added this issue to the regbot database,
please feel free to follow up with the correct tags to mark the
issue closed as appropriate.

--
Chuck Lever


