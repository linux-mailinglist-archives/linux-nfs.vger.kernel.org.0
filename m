Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7594799AB1
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Sep 2023 22:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243170AbjIIUAi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Sep 2023 16:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjIIUAh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Sep 2023 16:00:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EAE12C;
        Sat,  9 Sep 2023 13:00:32 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 389JsHOk023784;
        Sat, 9 Sep 2023 20:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UNzDFXjbdD598vPRtEKPVN5BGJLry0i1MQk2YWgze1w=;
 b=s14ZjizA9/y8B2iWq5kLM3lGslGTdn5W2PaHwOVLwhXV+8fJrknHbQthuGj0jtCVMlgz
 kJOu8bu1hhIPhTOF/sOxEPP24/oYUCyHz1eNoVSRQtGk8SLUB26FpK7dnzJtQKcr08Ve
 wT5SHDmyyATsFomEF3PsjqlTaVABBwojEs+D8ak97l6Ge4Fq7KvvOK4mHtvPJP7zME6j
 5Z16eQX7+hDHBYIOEqoa1YscZYqtKT0bX52qlj/MvMa8YavVpHwNSNDVT2vExtWJeIwP
 jfpSr0xp+t7wFB99eHbUR+scD3x7yBoH7PkBDrDJZDEWFWyJlwzGS6zMWydyXszA098q FA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0y76006d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Sep 2023 20:00:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 389IeAKx004493;
        Sat, 9 Sep 2023 19:59:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f53hsvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Sep 2023 19:59:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgfADOZJFuZpc7UZtSHE3Q0fbmqGEjUJe68KVw2RKVGxKxPk9uB8LsbiahgxITyTkyFrwwqf9uzm21QcYBFvQFsp/BSJBJF8WqP1HWl+qGo0jY6baDjZrvapuA+qx1DejQytHHi38qz76PxgG4Fig57+UkQ1y8c8l773rW4IaW3GzWR5aS3fnwz7edwLvEElq1xsMkz5pWukCsHJeCSMMm4Iq9HHsAF8wdm+dCAUlk6JVBKgsbdxirBEc77XYQxNPudYJmVJhsK+wYcTcvlJcVLl29Q30L4liaUrI0vtxvCDCzoS9HtHElP3SAdEr9TkH6CY9+n6ne01oV5T0m4+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNzDFXjbdD598vPRtEKPVN5BGJLry0i1MQk2YWgze1w=;
 b=g2XmTzXsw9n91LA3LCK+KjwAoEGLgIK7YRdT9B+o1rd4E0TJWzCnKCxhNKW1MzjCjKuGNODZAyenFer0iaVxN9ujN1/8R0DmYsWUjwaapSQaFg8bSfgH7/rPguu5FvMqj7koIlrSY/EChgsEO7UvTYLpks67tFeHmMJZGXOmKZpzmlPddWkUe22QcLpoHyErBTkh60J6mLj8n2cRNmadFJpiAeJynPILzhXKU7XP+itSNYq9Qj3UE7euBRBlY+bFDdEl880xUaH0zpY6IlOuDa50LtXfkbVMAQshH7CtQ1Tfnq4hIOANkkDZmkfhcbupZdtRLI/PIRAsC9K6iIw3WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNzDFXjbdD598vPRtEKPVN5BGJLry0i1MQk2YWgze1w=;
 b=Ekp8yqSr0SAhWFIdgd4oDnBeaAUIfcUe7NZJoIETWXSr/i8gt4PbjctKQsjqgKeoS2b6P+Tu3sJ/oWX8Ug+vMjeytNOKNv1G6ZJMJ3GeTBzTfANeIP2XHQoGbyYDSH6vjcP3FFMEhxBYgJPvuI+a8udnTCb0CRrJ1Rc35LTpMhU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4611.namprd10.prod.outlook.com (2603:10b6:303:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Sat, 9 Sep
 2023 19:59:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.029; Sat, 9 Sep 2023
 19:59:55 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhi Li <yieli@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: [PATCH] nfsd: fix change_info in NFSv4 RENAME replies
Thread-Topic: [PATCH] nfsd: fix change_info in NFSv4 RENAME replies
Thread-Index: AQHZ4w6Rf6y88OsgiUOBm4+waE+3QrASm64AgAAi8gCAACuegA==
Date:   Sat, 9 Sep 2023 19:59:55 +0000
Message-ID: <2C228137-ECAF-4852-9FC6-FB63AC4CC7C8@oracle.com>
References: <20230909-nfsd-fixes-v1-1-2ebc659c0cf4@kernel.org>
 <ZPyMyv1nNFV2whKP@tissot.1015granger.net>
 <18563ba8226cdc28b3c9c91214dbb936b6ad7a01.camel@kernel.org>
In-Reply-To: <18563ba8226cdc28b3c9c91214dbb936b6ad7a01.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4611:EE_
x-ms-office365-filtering-correlation-id: 329fd6a7-96e5-4925-3dac-08dbb16f56ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TWBFQYGMvM4KtMgvVGssWcs/HoBpwIFy92qWUXDXnb2j2sT7RG3v3HkYrhV4lmIC858gy8n+r8PN2y+swwvhn/DralGrFPlaNf3p4/Dq5pndCA/8UDVYzjbuMSHU3CT2Fg+bVW3YX0DJ0jPM/X8e0dsjWwn++B1wZ6DUDuWgZU0ZvMy024PnbIIHYaOrkDc3ezZw8HTxP4Y+JyZCzPjepa/J2dV9crHyx1L4m0MKiI8YldKYYVKh2dNoZDSHYLx80ZTSrPYPKCpjG+5E+k3Dqeo8udLWXUHBrif3J5HoanG7FAb5LfUc+Sq2rFoEiUVOk58i5X+3Wse3FJcoobGil5YMSGayZvU6AHflfOLREpLDucrHvIle4f80Q5PESX44QXkAYRtI+L+YoGGKHCH3YcbaEozgfow3TRRJKJgFvvMC8w+QAos3jVd+oiMNscFS2UHSsfWNeDi//Pa2J3yylz13wFxqxJB7bjGrqIf84wLUUy+h0JZ8h93AT+GZJhnTzUiOr4kNcVU0CKSdXM2bXaS9uzxk6aYsi0KQy9PZw6vzGTNo30Y5HlITxJq8ytqlMxmoHfnDFi5aCDLTwrVn4swjo9BdNDGMd6+4Y3Xj5FgbLHAvgcuUTwgzF/XG0tLlvFIJh4/sLT91OFGZgqYaAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(1800799009)(186009)(451199024)(6506007)(6486002)(53546011)(71200400001)(6512007)(966005)(478600001)(83380400001)(2616005)(2906002)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(6916009)(26005)(316002)(76116006)(91956017)(41300700001)(5660300002)(4326008)(8936002)(8676002)(86362001)(36756003)(33656002)(38070700005)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TfL/SYGR0BZyro4mS5qoiM/ut6BQVoHEenWEMHTHmqprcY+g6ufQHq0jZJVL?=
 =?us-ascii?Q?11Dro3kI5fpFTg6tz4YpIIS/9e4nE391BNc7xDLm2PtpuBUaUcICnvz4lhqa?=
 =?us-ascii?Q?DeuZSIB0qPlbEGhNGr3+MJ0nD6IiFFrhomTN+C96JWPYLWlVVGfUT3DX+9cC?=
 =?us-ascii?Q?9IxxhPxnmIja0/szVnOEoBwZwvVyj/LRhhmOXJnZvU1NPPm3skBkMO+d6I1U?=
 =?us-ascii?Q?ojBOttiqr2MwJTj4NvkkjzEeXPTeJhwRzdDy7kjTICv8yZ4DIz7qGztpUbC8?=
 =?us-ascii?Q?E52eLnwRlKSu4bFxf4/xlEat5f051+N6IqhArtToR6Oca8dc6so1VWBqsk+s?=
 =?us-ascii?Q?T22YdhVdnYGT0s+annDA+3vD731kACDhAel6GS6ZlZertof77n+J+3VklbcQ?=
 =?us-ascii?Q?EP7PL/PFUMcoXvYTweizlfGix57ID8cxbUM6UnkxF6ibxGjJvb1soe5uAtx1?=
 =?us-ascii?Q?WNJ1NDm4ThtYCWcbo/DUD9PkoP+RBJWrGggc0aHqNsJntTU0zm93YmhddMtu?=
 =?us-ascii?Q?jTNe+TxOdusX/x6e7nGVPVedUzIcynfDBg5jU4NZ7ZUJtKB8AjUfWqJbLO7S?=
 =?us-ascii?Q?Gf3p78/X+tKx9+m6jV1DoUhDLdN1f0iMV+yRhrOgCH3hFdB+ZnWlp51YgScp?=
 =?us-ascii?Q?RP7QGs3fzBgzDeYidqtt1IB7jOyyamoMgLphBBKcxpbt513AJBnjEGh1v63C?=
 =?us-ascii?Q?aY48cYlexpqzCaxUs6eu9FAKFbiGaGgDQK+tsx6ZAdnwRUxJgHg/htnTUmax?=
 =?us-ascii?Q?F36vlBbitTHne8tWQ9tY7v+iKH0R+lwEc12RkQOp2wq+J+oVJh5u51TKdfL9?=
 =?us-ascii?Q?GV/dEsFr/cEJs2UugvDDM2YIikRXfuBzV3hzUYKJMc6Anles9FSLRHp/9AyT?=
 =?us-ascii?Q?Lxgppn1GBt7KQUreEoM6Auit4zcX4R0p720xybhrVMLhlv9XbweMMY3vsV17?=
 =?us-ascii?Q?Jrjkw5EOVC2FLg2eaVTcFi7xIPfVB8OXzMlYIgi3mX3VkTofzPmby/EDhOjU?=
 =?us-ascii?Q?kRfqHqf5dv/2UEy8TGDtVfpy/vWaY6r+E9XH8MSTc9n99DMIbXi9OOpU6zQ9?=
 =?us-ascii?Q?YyjvwpuYhlfD0K9tNINNm7rW3eMHQm3lWImCN6ZlwsypaxXC21O5YxDHm2sP?=
 =?us-ascii?Q?1R2Ond2512wDEsZJdp5tGb9V/qtlZiL585FGAyisoTQLvf2+SJ8mWR7aY4Zf?=
 =?us-ascii?Q?lz3a8D6esrk5Y56zYiouCWY2917wdkBMv2U1rH3yq6kqFhMYsmqqVXBTJkkO?=
 =?us-ascii?Q?yKdbV6C6YEN4UwbuE9D+kau5ZD+YqRDvsOBO9oEnxTyAgcQqYVpTuSsj/rIm?=
 =?us-ascii?Q?YtVrK1OLXIrL/pVXLN5DqFiP7N6KKklqXAkesFaxwTIwRV7cNr7GshDBtKh8?=
 =?us-ascii?Q?b+MTnymIuHFcEjn+kZQmE61xaNMz4laiUPAYuHmftrCq0/l0jWWzXYIyXQSt?=
 =?us-ascii?Q?BJ7Z08sb/uQHSxl6OBCxQrpBgNuooD+U1TYK/5gBLPQFQR+iqDlMbCVTi0V8?=
 =?us-ascii?Q?pP+g8ofp+ow0K9hVNy7rjPvteZD/7wVJOO1L6vFQp/y/2QG23XkupS1/GCfA?=
 =?us-ascii?Q?Y/W3vAnPl6mY3xd7xz1tNW1bh8lCp0TMAFH+culq1DOvXYyOtt31mVDVQjhI?=
 =?us-ascii?Q?Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC3F42681465EE488D074F292FCB361D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jfHVRAI+ACcxmoxrP11LBpHxxKuSU68lTeuERv11IQZmRrACuRlBy3xp/ASbe9B7SI0nQEhbBGs3JFo3A7KYkj+b6aiFHR59j/mP/ItSSlYpfBqruiIIKd3O9j69kL+6qbBDdUqOhBcos0Th8RjLPsB7GtkwF8aoEsB6Jn00x2yVjrhdCTK1hZ42nlgX0YwHUhGU7bHKj/1XlcF5SddYbpm3FyxQ7AUSveGzl+zmtUUnc6Xxxwr2NrGxUbZmEiBELHOe5Je0DVbyxB+pWjOOm0C/MSY2RFYRA0wqNohrt2JaT0RJ1jupdv1C5azm96HybM1w9tDdHig7r21rKmOiU6vVsNcqxqWatTfVghK1GsP+TceIbIcbeUQId2l2UKGTxOTwoUn4HFRHCR7MACe3/u1N+zxkG8SQipoQMwhpTV/wg/TpuGNcq+2bpEvgRFv9u/XgE5CdXlVzCijGEH65cOBGL9h8bPnjCdeBJzMC6GTQH9ZwbUv9hi2b9nDIB82jyXwla1aZ6LCD4fvL+UJ5CPo5TDUJAreon2uxUa6MGofOVgD5I3H7JxUzvUe8CptkHLorIE5bbUlgF/VLJ5vKriS4pRkjZ74g1W0MlxEQJw5fywihkHGG1oWk+pHgnkJxs3nXHa/AEUUR1vVdRmdnaYIVZmfzjqFbM+mAh4QxbZ3LjyeLYzcDyVW+Q6V6cCJOfOKrqgNgCmIZ1S2NvgNIMeHSAVb0yc+OS1H0PhnJJGLoD9NsQpHMH4WbrO2byLdI+ko3Bx1XtGBO/hjVaZmWH32jlcn5Fp96hVhfDcE9pE4OgU0Vi44EWu4nnwBpv6Hgr99cyU3babu0n7nfgvONGNcFBPiaEztI4X5CMNXEToKl2e+r/ClAKVeTsm+I9rYco4TQdYSWJG2sgATFHALWuw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329fd6a7-96e5-4925-3dac-08dbb16f56ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2023 19:59:55.8583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5WXgSn2aUTltC2JjlJEBfyeUBByeIJxVYNdae9CiGlde5TeozpreXrwOrbbTI4+B50tOnvRJZXW4nm9qGO5rDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=841 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309090184
X-Proofpoint-GUID: P5ttFTKcdVYdTsHJikqnYzgNV9u_JPG0
X-Proofpoint-ORIG-GUID: P5ttFTKcdVYdTsHJikqnYzgNV9u_JPG0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 9, 2023, at 1:23 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Sat, 2023-09-09 at 11:18 -0400, Chuck Lever wrote:
>> On Sat, Sep 09, 2023 at 07:12:30AM -0400, Jeff Layton wrote:
>>> nfsd sends the transposed directory change info in the RENAME reply. Th=
e
>>> source directory is in save_fh and the target is in current_fh.
>>>=20
>>> Reported-by: Zhi Li <yieli@redhat.com>
>>> Reported-by: Benjamin Coddington <bcodding@redhat.com>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> This bug predates git, so I can't add a proper Fixes tag. I think this
>>> is probably appropriate for stable series kernels though.
>>>=20
>>> This bug was largely papered over by the fact that we factored in the
>>> ctime when generating a change attribute. Since this commit, however:
>>>=20
>>>    638e3e7d9493 nfsd: use the getattr operation to fetch i_version
>>>=20
>>> We stopped doing that for directory inodes and that caused this bug to
>>> pop up.
>>=20
>> Applied to nfsd-fixes with a "Cc: stable" tag added.
>>=20
>> Is there a publicly-accessible bug report link that can be included?
>>=20
>>=20
>=20
> Yes. I just made this one public:
>=20
>    https://bugzilla.redhat.com/show_bug.cgi?id=3D2218844
>=20
> It has Ben's reproducer script for this in it too.

Thanks, added in my private repo, to be pushed out later.


>>> ---
>>> fs/nfsd/nfs4proc.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>> index 5ca748309c26..4199ede0583c 100644
>>> --- a/fs/nfsd/nfs4proc.c
>>> +++ b/fs/nfsd/nfs4proc.c
>>> @@ -1058,8 +1058,8 @@ nfsd4_rename(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
>>>      rename->rn_tname, rename->rn_tnamelen);
>>> if (status)
>>> return status;
>>> - set_change_info(&rename->rn_sinfo, &cstate->current_fh);
>>> - set_change_info(&rename->rn_tinfo, &cstate->save_fh);
>>> + set_change_info(&rename->rn_sinfo, &cstate->save_fh);
>>> + set_change_info(&rename->rn_tinfo, &cstate->current_fh);
>>> return nfs_ok;
>>> }
>>>=20
>>>=20
>>> ---
>>> base-commit: dd1386dd3c4f4bc55456c88180f9f39697bb95c0
>>> change-id: 20230908-nfsd-fixes-f5bdb87e6035
>>>=20
>>> Best regards,
>>> --=20
>>> Jeff Layton <jlayton@kernel.org>
>>>=20
>>=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>


--
Chuck Lever


