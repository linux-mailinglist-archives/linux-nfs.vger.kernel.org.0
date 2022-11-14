Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3B1628396
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Nov 2022 16:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiKNPOD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Nov 2022 10:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiKNPOC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Nov 2022 10:14:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B5A10B54;
        Mon, 14 Nov 2022 07:14:01 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEEk5F2004939;
        Mon, 14 Nov 2022 15:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=s3sWG69Pa8Di9nZgNWQjnavBm90sjQ4c5USsLkr5/pw=;
 b=dARGaqFJtNBpottxpmCQdQK+rBGjx7PM7DVDuIVzD1OH4TEnxPp16LCm7S7EvnIms1Fj
 0V0wYmCXK07AFcfjctDKHLoAID/R8dRrpvGUqCIQxTwfuY2wtIK1YCm3YIdRvpStawbB
 Rw6BZUT0hNhsfTvyU3gIUsCwl5/M/G2ehNOuvoU+9UvwBB9gzH0dNqryIH2/Xf5MmAlP
 XTpmtbCQComb8tkkYFaesvOGrs3n4yTIZ6d8SkR3elGfQ52NIy8raWxNcrycpgw4cMmh
 zZbxTYr3o4gq44MmO3qvELM6Odpx4ZSgCil1z+lX+b5vT11QtPDztGxxxnJjx/WjZW+K qw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ku1gwjawt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 15:13:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AEExhlp010329;
        Mon, 14 Nov 2022 15:13:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xahh8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 15:13:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/vg3qi6Us8rzFg2ay2N0P8fPO5rb46G6T3u84H0cK/UtCyNK2F/mqkRbBFRG853POe3q1IwQqJ69Kc8pCpXE+4QNvRfXkWpFGcDT+a7wQfsIT2Lf4QnXgSDTwMShTXexj/PnJB/+ynoXkF6sasjTim7d6APg8hdFui0ld61nAXk7f2AcwDWtCIjT557T34Bz/bihI5XxzrPGS3DlXivvRXMu2HWJ1/vAR/taS1PzWl1mTqujQS5nOp7f4Mzre2Aljf5NyBUHYWUgsTBGRiRdq+A3oc3uPOHKAx8FMdTBm00EjzqPpY+lj9MhxTBn8dpQGFnrE5KjCF+E27QW7pQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3sWG69Pa8Di9nZgNWQjnavBm90sjQ4c5USsLkr5/pw=;
 b=dfJQ73JE1DBzMiFzBvgXy2sTw23doSTqXKY3/Mcl7hA60s/tic/85z4Moxx5Jn+J26hIL0pdPTZJmEAbDhbWziLAKG0DOJh/HTN/aWZ7poBIt292HDt8Ao5PZ6zt4EqOh5HKzkxi8nT+ti+ssoLry0gEOcfapf+n5hWvZxuDXWv53srMRlFyJxPSL34YxCfkmjM9W2jEE4l98o8FLgWQU05fxlKanSkD2KRdEqrGYUeyixHhO2ANTTV6fx9LpsA8eFlEgIKMA2kTBR+1V6CvYOQx5LMsZrT9pu/MdmDOeHpNpAbeEqImbTuXkZAtlvJT/tFWKNq4oNdGimwd1uEuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3sWG69Pa8Di9nZgNWQjnavBm90sjQ4c5USsLkr5/pw=;
 b=a1neSfe7WXrgDQC2RmzBdgg+pUAAVnBOIJ6FiJmfhUVxU+9bQDQ8AhaMdRqRUOHro6vDJG5/i/gLhoI1I3eYvliM09sNC0oEPiQ9GbHDxzfVuc+mahv5aAqr54q5puxU9Fg8eePoK3f9WVY7dHD4AgmzdyqxKuYDv/nx64abBqo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5019.namprd10.prod.outlook.com (2603:10b6:610:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Mon, 14 Nov
 2022 15:13:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 15:13:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] trace: Relocate event helper files
Thread-Topic: [PATCH v1] trace: Relocate event helper files
Thread-Index: AQHY+DaL/jfryLM5skq0RFgPE2WAaq4+g/qAgAADBgA=
Date:   Mon, 14 Nov 2022 15:13:56 +0000
Message-ID: <C11D5606-4432-4FBC-8754-CA49832D172F@oracle.com>
References: <166843574651.160660.16747506894761495587.stgit@klimt.1015granger.net>
 <20221114100307.6abba30a@gandalf.local.home>
In-Reply-To: <20221114100307.6abba30a@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5019:EE_
x-ms-office365-filtering-correlation-id: d28a0d27-80f5-423d-b448-08dac652d994
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZG3qQg1w+wTQ0ZFLC8C4KwyFck6Ix2pz/fCZOhx/ve4OTs80C6hZDuoedEBktEoTdoLI1VR5xyN9AVG92iObMyL4o7t21jBfNw/5WSLwDHFfxYz7U8DCkLOtrGZSzwGWWuAwcBztiBuPEBC+QKMlRqZEDTELYbMx0wn9+EYP4bOaCYs1q3SRUSu4KHtZRA7hqNQ2TGouDhbwcha8T+KPuA+jZGikkR2XGdaBg0myjt+xyntZ9IRclq9deQLCGLpa8DSMEnkLttIHCRFpbVIX1f8zWhLiTekyCJ/5GmHD8h9GsknucB/OMwZfBljSdQhe9kr1h9w0QYm1QJIg250qLjHUWpPtZSBaYjM/96l8e2g1u2Ns2ZAfi1ncpSntCc8A1X8lj/Z6mQg2x1ph8yCZgs3sW/bONEzetFRsMxD5O0D5icXSn59HjobzTXQQSVPVYHHHT715YXomPJAczYGWq1wYZKcUesM9X+7akrlXGlX/D1tFYau4JOJCy1XuXOc8FNutO5P4VJHDMftaenb2w9xIqC6A9PUWMwSJ9ZA+RpZ0SpO/JAoA9W5+xErTL/MYF1162Ybx9MC1liFPSd7T9Q/A3HbQIP9h4cj5h0R/aBUGT2sllkCU4VbZTSlDq9UaNLQgkxc16TeSq4xNiHV720E8Qqp1FxZV1+fL2o9YUTeL9kwh8xiQJehiUmDa5wqEkaapjEhkmfOnl4xfMautkPch4v9Vg8af1dpgNKgX8uzCBhezUgVXY9DAmAEFf8e4nVII3FaeHyAjrJukpXJJr/Y3ge7KWYOf7u5Uuq5tro=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199015)(26005)(83380400001)(6486002)(2906002)(478600001)(53546011)(6512007)(6506007)(71200400001)(66476007)(316002)(54906003)(41300700001)(186003)(66446008)(66946007)(2616005)(64756008)(4326008)(8676002)(36756003)(66556008)(6916009)(91956017)(4744005)(86362001)(33656002)(38070700005)(8936002)(38100700002)(5660300002)(76116006)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UlvDTtzHGXI/DASCP5SU6RtaH0WR/xc3HKLpVxqwY0Hp855H9e1d5gFcT0PM?=
 =?us-ascii?Q?l3F8ScbxDlezpLO2wKlV1eKKsjRh++dwDv0pzwY74A0/teLXxY8LcknTNePG?=
 =?us-ascii?Q?qzAkSVnYrBaTH8c3XTQV3jNSZKwfgXk0PtS9hax2WdJckTbpeePd7Vwv/Dmc?=
 =?us-ascii?Q?bFfebhWaMgR7+DMmwX/wkNxmjaYynmHrOJ+A1AIfh/9aIO0P/EYkSMBbLrTy?=
 =?us-ascii?Q?x/qvKfcND5lkFZ+ZCc+oGLr29+jq7navr1j6WfSD+OjNOD/k0yYSP5uIDW9B?=
 =?us-ascii?Q?xtKIFapmo4hD5Uqerh/B+nDUGpJspEjdpVaF/Ylnw5xudVNd1uKUREKxYlyO?=
 =?us-ascii?Q?SXpUHS60g/tcwYTxAP3NTT3eXuCQOqbzzwBHTHjch2eLb3k+x1vszhXJiwfZ?=
 =?us-ascii?Q?R4WK/6r8pNiE8ZBD1SFYbYdZf3HyI/igVE26EvFWu2hjtH5zHPG+A1i5WsfA?=
 =?us-ascii?Q?w9nMk09hGxFS6DKR25NttLenGNxWXKUFrBiyI6pVcV7HcSVd9sWLpK/GFoXk?=
 =?us-ascii?Q?6h9dyMC2dGRfAgS5QZ9QpoCmAlpLDz1cTDd80rbTB/8+JgGuwN4m/JL8uKgT?=
 =?us-ascii?Q?ovV4yLeAmcfkzclgPNNT4NjqVjNufg5IzAum6Dwn/QjwrHYM1vSeX1KlEg/8?=
 =?us-ascii?Q?eo+/3313asW7ViPeKHwwXgKTTmw5DbuKGScGfcjiwKdfD6fIefVcYdrxQZ8/?=
 =?us-ascii?Q?rm27zfYk48d3EnTzjF2CsaSkLlwb1fCFuY+LBv6g5Wjw5/hS4mPp/dD3PeU9?=
 =?us-ascii?Q?pTKXJ6FMirAjJazoQ7sTlDeswdJSbiEFRbPfHaI5qFBAWaNp2z4bL+3T+Spm?=
 =?us-ascii?Q?8URkURL3Jcr18PORWYZ+QjxpYFJwOrlARNBj01tDj/vMyeJB/cy23B4IFgAk?=
 =?us-ascii?Q?GMZ/jtjUn/w78yyps6cS1PyAu79HSBvW2KqpZiMEbsl//7cG1T1LdL7PxqDi?=
 =?us-ascii?Q?7Bj7RGWCXaL6+JCtbDWSmUe0AdrSvyJZnkO9SOyt48BGysdjpHWOQBijilSv?=
 =?us-ascii?Q?+8bkmjU/4iz+zpSlk/bzwU9LkS/O2BhBW15/3aXmCd+N2xQjEyYgEVGuZe58?=
 =?us-ascii?Q?p1hRnAvQfcWZnkvTjp4WvUYHTNbDDHR6QmAxrAu1K2jxs9oFMFdpaySdJlt/?=
 =?us-ascii?Q?f6fetvz/nc4NbEIafw0c3IpVk54G/0Vhc1L1MwFzr6cxYbNRhxEz6Av8uyQk?=
 =?us-ascii?Q?ZSbKVaGlrgFF9BAOQ3WownnPA/bBE25DXxCGu6oOXqYxyh9C7x9gWzPMQd3K?=
 =?us-ascii?Q?FtIDsI9Qq8HJNYvhlXkSzh/m4kHvJVjsxQO05ghyrgT6iRFS1IBBV4yI/C3z?=
 =?us-ascii?Q?RB95r+m0JG0mnrjlNmWdE2TS3nLCK2F/lYzqhXHNOUz8kqv6QTuvlNXor1at?=
 =?us-ascii?Q?HTMrniU1KBF8kkXLQlXgkSLXFOsWemrqF4tEY23T9v+2UPzqbvPTGNzRx1eD?=
 =?us-ascii?Q?q/oRv6dUcAlTzHeMrBNgZR8ojAxpVoof/2zQps8Wrs73zbfKBVaPwLM5LpRP?=
 =?us-ascii?Q?FVUv8XiV0utmIEbzjptQkP3Dzf860LJnOfp0qZybgA+/K5KquFtsXlXNbf3L?=
 =?us-ascii?Q?X8O6x+IockagNmWqj3eqnHMvZ5Mch8CrvzNlavPSLkE9XX02RNKSH6r23Zgt?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <527E3488BB2511499532621EF8E7B1FA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fJnm8DVRM9K/X/yIxQXvaaxakPL38mp6v2fljs7S2GmSc/8mdXrI/Igo8GEGw2rqLUtA3aZ46WxEc1WDV6qxkFvKrkFpXFIJXyCh8xzHtHwdZm0sPZ9HCDadJKFCzlKm1StKDaPKBoTORCV8ezOCjyAW9gjMxZUXQKjzYSSTPmLJCp3TWsIvnu1/GwLvk67kiHmLTqKChFmoIw3GKXJRsvyctdcJLV/0EYKsRO5oPyGcH9s9RfOakGZjiA/4/QCFAvFoWSRMQKeuw8xRnSIlUcCRy2yhBVUJaRO7fA6mOGiYRlH4LKgc/KBhCr/wg/FzItHT9J79DnXIbvwFoOyEuk0UeKlSY3/PXdq/o3JgCVCUgGkAMLWYyaCLb6YlhAxqcj7RJrHKJKuc2xRnbRnSZnk4zj6JhRyRfcd1LGrsHP1RPACaGjjT9KbMraM5cFZVzcXZej9W301ia5UNMKcR6S+xmwb+zTDs6FVKCvUJjS9ib/SmvW6CRfw5bkmb6QZw5p8qM33OJeYNT0qiBHDAl4ie5MyHEwEz6/UsapYMGAJkPsMKgMZPr+0xKj+xr708fgT04bFfMuV8um+UfGI3LJrolgXF9WKl2f7JaVwFVa5gzkcd8wu7dDJi1ZlHgSqcE+p6oA36CpbahHaodZh5wtFHeBYMbxtlZVPzJBuA97BGoGRCB4JSxU170qBCqS8uPL+9vQKs80WgnRVIxdJfIE+MsPdq6aSMbVw11KgioJa7MdMZEljx0ZggvErA0tVPnBpcCjocv61Mc0ewPAJ5Q5sHEYWn93JJEz3lZ6rG7i6gtcLWD49Ig3Dbyv2Yv925nU8JwLAVpIdWIxGC3uEJ73H2ILoiJJId/d5eho/ATMTIb4FT4szHQj8OjG79XTzQ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28a0d27-80f5-423d-b448-08dac652d994
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 15:13:56.6056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9oqxDdTea4sBTUseUI/D8FwsTfZWwppvE3/Kgbq5js0i5cQw2Q/BprY4NLEVwDOEHNgeZtRWiaoyNLYDVBgWyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5019
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140108
X-Proofpoint-ORIG-GUID: 46zON7GFKAXxIucbLk-NhG59S_l0wQKc
X-Proofpoint-GUID: 46zON7GFKAXxIucbLk-NhG59S_l0wQKc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 14, 2022, at 10:03 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Mon, 14 Nov 2022 09:36:39 -0500
> Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
>>> Can you please move them out of include/trace/events/ as that
>>> directory is "special" in the creation of events. =20
>>=20
>> That should be documented somewhere, but I couldn't think of a
>> place to write it down.
>=20
> Probably needs to be updated in the Documentation/trace/events.rst?

That file seems to be a user's guide, not a programmer's guide.


--
Chuck Lever



