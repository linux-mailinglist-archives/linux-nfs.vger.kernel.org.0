Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF48E5E6B64
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Sep 2022 21:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiIVTDB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Sep 2022 15:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiIVTC7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Sep 2022 15:02:59 -0400
Received: from mx0a-0002ee02.pphosted.com (mx0a-0002ee02.pphosted.com [205.220.167.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCDCF9609
        for <linux-nfs@vger.kernel.org>; Thu, 22 Sep 2022 12:02:57 -0700 (PDT)
Received: from pps.filterd (m0270672.ppops.net [127.0.0.1])
        by mx0b-0002ee02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MFp5V6013237;
        Thu, 22 Sep 2022 14:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fedex.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtp-out;
 bh=ev2mzOJ7KIyjeY+UqIb0VSdzT2Dn1DrVKS32+gToxdI=;
 b=mHy+STN5CMpW/sZIvqsyghFein0t1r0D212JZtcQ18qhuzwxmIhCaZF1E+cWTjVmq7rt
 al+PzBk0FYQzkKGnfmZIm6jZNTPCxeGo6b5FruTBkOm3a55PUKScW3GZYb2MIPMQbv+l
 KISvCKBg9M8RUkXDcLlr8Jjp3Gl0JQBCMx+KeZYthQ4JUWJQl8RDLucypIw+3tCM40MI
 LHC1DSPEF5TEWTvmN2gz5/5v2vkkqWmiMfV1iisskAgyqUm08N/vxT+D4nPgwdtpQgjL
 4Nxqcvc+l1e3eQCy2cWZt6uV19yDsHIeDYbzqcCn/JriRVa4fyxAFX7eIZ3JDntCKilL aA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by mx0b-0002ee02.pphosted.com (PPS) with ESMTPS id 3jrtq6tart-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 14:02:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcdYGrv16T8mczznbtGipyv9oFkfLHU1ZM+ELlzFATY2YuNznji4leNj+77QD0y/jfrya6rWzYdOJ0L89BeKBmxOm2PvhuG/IDBX7MTKUH4Lspi4OoE3EEYLpSbcZiaNEI42fegi2/zHwYAdqrYrlUKEeT/x7xDaHyk31YpfSTnO9yHsjaNvLquE2ozd/rHwCiD5md9+IX1qSKicD/rpxXGg9Fi1kPV5C2vzvB3m1MiMPz0wiBJ/mFM7w4FV5GSpUJcz23EpYyQN6dgZ6FqM3ka21XiOnXPv+0B0Hqumh0j/9YvHZg3k6o7DeTzEsC9WpSDxSlGSmffCZJYZLrD2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev2mzOJ7KIyjeY+UqIb0VSdzT2Dn1DrVKS32+gToxdI=;
 b=l8QQ38SCvgqaNsglIDQWApSps9t+vv1L0KTkngNfd/cZFONdwhaYhVKNR5MB7UWoymL3epJG1Mq9z56aX6xDF5w/Ev0j0Mz/GDhJ1mcrK7IVFt/vZlAI1jSTl+UQII+F3e68cwltq1WwwaEcu5eMrM1g1PwvudfEyVGNH4DOK4/jbYQQOCzP63RNLlJLLl/t4Znp9EGE86dSbcnFQNK3Fg3hRS9vB9eNsdbhnCgftVVtM/5bGUnwXU6C9sVIdE5dd6G3gD0ZQxefDW8mcQvNLFTZARhd87caJYs2Ivw3O7kOLGYJqRmCVE468Efu4+C4gWmKOOay87BxbL3NvBh72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fedex.com; dmarc=pass action=none header.from=fedex.com;
 dkim=pass header.d=fedex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=myfedex.onmicrosoft.com; s=selector1-myfedex-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev2mzOJ7KIyjeY+UqIb0VSdzT2Dn1DrVKS32+gToxdI=;
 b=PJeFxKNzv0OFh7zvsLeiU3+cfL2JV+yV5arMVYGKp8Ejicu8b2IJZkKFP7LFNGHiVqL8flnO15o6m0NAw09rqzWjfTjMLAD5yVSePiCYaTSOuKojhZHG1KiGUxMWI7zldnAJmhKadc4BUsRJN/qVVTZ+Zn4VAxn3Y4IfamUFGhk=
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 19:02:53 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::f182:c1ec:d17d:43fa]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::f182:c1ec:d17d:43fa%7]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 19:02:53 +0000
From:   Alan Maxwell <amaxwell@fedex.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: [EXTERNAL] nfsv4 client idmapper issue
Thread-Topic: [EXTERNAL] nfsv4 client idmapper issue
Thread-Index: AQHYzoyLB0ZCEFrXiEO+WVUdCpVZ7K3rfeBggAAHfgCAAAJzcIAAA4CAgABC4QA=
Date:   Thu, 22 Sep 2022 19:02:53 +0000
Message-ID: <DS0PR12MB648681C31885D5483393F749C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
References: <DS0PR12MB6486987EC76AD88C7A80D229C84F9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <46FAEBBD-50BC-464B-A983-1DC2232795C5@redhat.com>
 <DS0PR12MB6486B941F1EA96D2634CED63C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <812A1C59-B489-4D6B-8673-15F5C86A99D0@redhat.com>
 <DS0PR12MB648637C3D4E07C6FCA90A0E4C84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <CA53F1A0-807D-4297-9E1E-75E4AA26D470@redhat.com>
 <DS0PR12MB6486A843F54547C497E6064AC84E9@DS0PR12MB6486.namprd12.prod.outlook.com>
 <D881148A-3521-47D3-873B-C244969B0599@redhat.com>
In-Reply-To: <D881148A-3521-47D3-873B-C244969B0599@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6486:EE_|PH7PR12MB7454:EE_
x-ms-office365-filtering-correlation-id: 3b3c2da6-905d-439b-bdff-08da9ccd0d85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GI7/GoYkQp6zxMvWDipEBsUQ/XVoeOkgXqkyYKMqiR0MJYgFC4wVH9PQeOSTRKtpOSBmkn+vRjHXrj/g/8XfNfVOnlIkEelBwX2Eerkt5WsoeXQRBJ2RPHuVh5zKGtCCVHCXJPJlVpr0s8lwDpdTtmAac8OKL2H2ECefMCb2R4RfOv9nt4dVNDBf7cKzaOKds556AMlIDiwx1fVonM8pGokwkDLzl5RB6LJ0LJCGo4nxnvbtZJTdx0Oge6RAD3pKysaJXFI6OqjTi4sWg4sRrJjgJ2tXcuDj2xB9MNeTno0VcGdkkzGCboUtodyU81AkdZrg2ak7pG+1BaV50UGOTVhlyM7jjIr+Mc08J0jK0mZFNKh5nKc007ryCnPXHr+eFDnGmAQk7qNm4gUeKB4SvtHxbwStXjAirBqVE3EI0t9LJZwopgoeIJltjvHT50741k2U74lL3JdRjqO9nWbCT26RVaqQ0J9BgOA/BfZ+n9P8N3NQBeV6TJeqw/7i+sIWPbLN2myudes4q1SRwpVqV3Xkv6cgERPGT+jtD+c99dsk/kf3TFJ7jZpNY+OLKFzwIj4LBsokotve40OTglvN3xwLZAa4gR6Wz7E5k6F6QLqFvAE0i9P4QWcMUrry+pnL4o+1yuV9AO4fMEJAJgTwn2L8eGiYAL1XVjgfW1Xufl/DbueZ1soQhx/AVsVpM3m+aftIcCiKNunxSISTDWZAi8HvhTxLpMTY8ykuY33P3sL+GneZC5C1qKwJM9hzm3C5XJfoQhGuoB7qOJ3iRdjiPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199015)(83380400001)(76116006)(86362001)(33656002)(122000001)(7696005)(6506007)(82960400001)(38100700002)(2906002)(6916009)(38070700005)(64756008)(66446008)(66476007)(66556008)(52536014)(478600001)(4326008)(41300700001)(186003)(8676002)(55016003)(66946007)(4744005)(5660300002)(8936002)(26005)(9686003)(53546011)(316002)(10290500003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TK6+dSIU1ONYqGq4t5nuyH8pfQ00435gVY9aUAzOcPvVS/MJul68kq4aEDTq?=
 =?us-ascii?Q?9BxGlK2bfOPGCcSo2loo3LFGyAyqtdYM9tqZoqluKS1K464oM7SSsarG82zJ?=
 =?us-ascii?Q?8XLoqL2OIiBkT3hxRSc81f9pmA0sifeKx9iSHHK3mNw0Ia9hDe1qxLXNNbNv?=
 =?us-ascii?Q?EQWQF9UkVWGgI758W5OJfirJ8YDLtTYevkiUhw6i5H1OpG2Bm/Cqv4P2jLdK?=
 =?us-ascii?Q?JBCCOl/PoHsr0uCxX7+Vt7d1CUEv05te3+yu7ZpDlNPehbkTVuVr0jqB2PUg?=
 =?us-ascii?Q?5WwPLZ0F5WYs9EWROybmb9qy8fVmEELEybcb+LMwLP2KZYCkGOlmGWoxq2wH?=
 =?us-ascii?Q?139gZaLohUGg/atIKYyA9ozWqBcwsceFSGLmxjl5lmmuoLhwFzZVi7GVFPs6?=
 =?us-ascii?Q?9frv+o2c9ehEpAizhq6uuc/0gDe/Ok9JpyU/rLGFBRNcBWzdke8EmQemjYYF?=
 =?us-ascii?Q?ttC7xbQQVPRMs5aKBbA2RXlWhszvIfnsrEF7U19526LPaChReo71d/qz34Ez?=
 =?us-ascii?Q?tkvxJi1F+nDuBC9ZEj6tjpO2F1C80mQUBotY44iUbK3wcTrdtf7d84g0AMvX?=
 =?us-ascii?Q?s9z6Zr1rhgYNeiLde9y6OA5tunWPakPVa0gMgaSo7zogGetwdh+XY/xmLcBt?=
 =?us-ascii?Q?pzDIN7W55CTBZioa8iGO4ki5pzJWf5AMNZSJEXG2tF1UPi+ob7xWAfz+5+W1?=
 =?us-ascii?Q?5fq/UhEY8uILJj/OYTt0fsLcreCh8f9OA6EhXE+i5LDm6ZUaJQQbGqtSm/Ho?=
 =?us-ascii?Q?zVsYRG/ISFNEKhK1Rek6YdpfWY6UjHoIbUoLq4HB8rm52LslYBdn/Os+soij?=
 =?us-ascii?Q?cRCPhRQdRrO3LhVi65DveJwPqcvonQUUbHjvhcnK1HYzLSF5gilcKJdQYNEl?=
 =?us-ascii?Q?c596wjMU38jNoEkBpzzWmOs60HyA7vVBE/1MFeX3AUDz9jRFJRVqVrozPN05?=
 =?us-ascii?Q?uDK12xtavDBC57aVXQqeLgJw/2FF6sggUGWi3O8AN4UjWVL/ATJ5IMtKRy7U?=
 =?us-ascii?Q?QdgL85KxhYO1FEBZ4sgehGsxLowHXp4LYy/cEYtzpY3bsGkDIJedViku8/WH?=
 =?us-ascii?Q?tpG7gg0CEcgHcZMvrorj6CFdkwwLPu2oqOfk3CNjot9IJUWaGbPm+DOdAoUs?=
 =?us-ascii?Q?XGbsE2PIpiVKIxFC+hDyRv2DonhUL5R43TsSG7A1uJ6ikP8byIJDLf041meh?=
 =?us-ascii?Q?WeQJUoC/GTBOg2wNSkq6nQXlLl1lRHcaJaG+8n/7S7BB7TpSqXFmDriM2jHJ?=
 =?us-ascii?Q?GxVLrMsvyqEzasoa/4LqfjMofwpblTr+dirwlnGk9qrdRq0k0gIY0Bur6I9M?=
 =?us-ascii?Q?B7HdAeMNWD75zFpmm1TEBm8kRGoKytVfp17guCq2LCskQjwH7OJuMRizUlpk?=
 =?us-ascii?Q?Qvm2voT396Xjm+s9zmhnClgJAEfkQpbnFp7pe6KATmD0O726kRiwk12YcbSw?=
 =?us-ascii?Q?EHXfdbXLM8fqy7XuQOFkn/x3PIJUULNJMxooUmkMkzBnd0sfEeQ1EL9qtphd?=
 =?us-ascii?Q?fzItV7SawPoFsDex6YNYQHETJmTq7ShYPIhXhgklhRqQW4DD7gop4EN6tkmi?=
 =?us-ascii?Q?21u4npdCvpVN9b08qz742GP+F43TjaYHv/HisoE2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fedex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3c2da6-905d-439b-bdff-08da9ccd0d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 19:02:53.4819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b945c813-dce6-41f8-8457-5a12c2fe15bf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJcJSmAXrt/VoH+KkQSFpbysgDbvZnJYJ2vpf8X27Rl9U2/j3+qqdVUosNA9WrMz+2SjsVly5S8jbj1BWef9HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454
X-Proofpoint-GUID: 45HOXcwN8NtzrDagtV41rSYatkz8iV4h
X-Proofpoint-ORIG-GUID: 45HOXcwN8NtzrDagtV41rSYatkz8iV4h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_13,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=900 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209220123
X-Spam-Status: No, score=-18.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I thought I said similar, but here's another example,=20
chgrp root nosuchfile
chgrp: cannot access 'nosuchfile': No such file or directory
So the file system didn't find the file and chgrp reported it.
So these are examples.

-----Original Message-----
From: Benjamin Coddington <bcodding@redhat.com>=20
Sent: Thursday, September 22, 2022 10:02 AM
To: Alan Maxwell <amaxwell@fedex.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [EXTERNAL] nfsv4 client idmapper issue

On 22 Sep 2022, at 10:50, Alan Maxwell wrote:

> I would expect chgrp to behave similar to a local file system:
> chgrp badgroupname junk
> chgrp: invalid group: 'badgroupname'

That's not the filesystem giving you that error, that's the chgrp binary tr=
ying to translate the argument into a gid.

